import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart';
import '../models/user.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _currentUser;
  String? _token;
  bool _isLoading = false;

  // Clé pour sauvegarder le token
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'auth_user';

  AuthProvider() {
    _loadAuthData();
  }

  User? get currentUser => _currentUser;
  String? get token => _token;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _token != null;

  // Charger les données d'authentification sauvegardées
  Future<void> _loadAuthData() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();

      // Récupérer le token sauvegardé
      final savedToken = prefs.getString(_tokenKey);

      if (savedToken != null && savedToken.isNotEmpty) {
        _token = savedToken;

        // Essayer de récupérer le profil utilisateur
        try {
          _currentUser = await _authService.getProfile(_token!);
          print('✅ Utilisateur chargé depuis le cache: ${_currentUser?.name}');
        } catch (e) {
          print('⚠️ Erreur chargement profil: $e');
          // Si le token est invalide, nettoyer
          await _clearSavedData();
        }
      }

      _isLoading = false;
      notifyListeners();

    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print('❌ Erreur chargement auth: $e');
    }
  }

  // Inscription
  Future<void> register(String name, String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      print('🔄 Inscription pour: $email');
      _currentUser = await _authService.register(name, email, password);
      print('✅ Inscription réussie');

      // Après inscription, connecter automatiquement
      await login(email, password);

    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print('❌ Erreur inscription: $e');
      rethrow;
    }
  }

  // Connexion
  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      print('🔄 Connexion pour: $email');
      _token = await _authService.login(email, password);
      _currentUser = await _authService.getProfile(_token!);

      // Sauvegarder le token
      await _saveAuthData();

      _isLoading = false;
      notifyListeners();
      print('✅ Connexion réussie pour: ${_currentUser?.name}');

    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print('❌ Erreur connexion: $e');
      rethrow;
    }
  }

  // Déconnexion
  Future<void> logout() async {
    print('🔒 Déconnexion');

    // Nettoyer les données locales
    await _clearSavedData();

    _currentUser = null;
    _token = null;
    notifyListeners();

    print('✅ Déconnexion réussie');
  }

  // Sauvegarder les données d'authentification
  Future<void> _saveAuthData() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Sauvegarder le token
      if (_token != null) {
        await prefs.setString(_tokenKey, _token!);
      }

      // Sauvegarder les données utilisateur
      if (_currentUser != null) {
        await prefs.setString(_userKey, _currentUser!.toJson().toString());
      }

      print('✅ Données auth sauvegardées');
    } catch (e) {
      print('❌ Erreur sauvegarde auth: $e');
    }
  }

  // Nettoyer les données sauvegardées
  Future<void> _clearSavedData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_tokenKey);
      await prefs.remove(_userKey);
      print('✅ Données auth nettoyées');
    } catch (e) {
      print('❌ Erreur nettoyage auth: $e');
    }
  }

  // Vérifier le statut d'authentification
  Future<void> checkAuthStatus() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final savedToken = prefs.getString(_tokenKey);

      if (savedToken != null && savedToken.isNotEmpty) {
        _token = savedToken;

        // Vérifier si le token est encore valide
        try {
          _currentUser = await _authService.getProfile(_token!);
          print('✅ Token valide, utilisateur: ${_currentUser?.name}');
        } catch (e) {
          print('⚠️ Token invalide, nettoyage...');
          await _clearSavedData();
          _token = null;
          _currentUser = null;
        }
      }

      _isLoading = false;
      notifyListeners();

    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print('❌ Erreur vérification auth: $e');
    }
  }

  // Pour debug
  void printStatus() {
    print('=== ÉTAT AUTH ===');
    print('Authentifié: $isAuthenticated');
    print('Utilisateur: ${_currentUser?.name ?? "Aucun"}');
    print('Token: ${_token?.substring(0, 20) ?? "Aucun"}...');
    print('Chargement: $_isLoading');
    print('=================');
  }
}