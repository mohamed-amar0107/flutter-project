import 'package:ecommflutter1/utils/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  Locale _locale = const Locale('en');
  static const String _localeKey = 'app_locale';

  LanguageProvider() {
    _loadLocale();
  }

  Locale get locale => _locale;

  String get languageCode => _locale.languageCode;

  bool get isEnglish => _locale.languageCode == 'en';
  bool get isFrench => _locale.languageCode == 'fr';

  Future<void> _loadLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedLocale = prefs.getString(_localeKey);

      if (savedLocale == 'fr') {
        _locale = const Locale('fr');
      } else {
        _locale = const Locale('en');
      }
      notifyListeners();
    } catch (e) {
      print('Error loading locale: $e');
    }
  }

  Future<void> setLocale(Locale newLocale) async {
    if (!['en', 'fr'].contains(newLocale.languageCode)) {
      return;
    }

    _locale = newLocale;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_localeKey, newLocale.languageCode);
    } catch (e) {
      print('Error saving locale: $e');
    }
  }

  Future<void> toggleLanguage() async {
    if (isEnglish) {
      await setLocale(const Locale('fr'));
    } else {
      await setLocale(const Locale('en'));
    }
  }

  // Helper pour obtenir le nom de la langue
  String getLanguageName(BuildContext context) {
    if (isEnglish) {
      return context.tr('english');
    } else {
      return context.tr('french');
    }
  }

  // Helper pour obtenir le nom du thème
  String getThemeName(BuildContext context, ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return context.tr('light_theme');
      case ThemeMode.dark:
        return context.tr('dark_theme');
      case ThemeMode.system:
        return context.tr('system_theme');
    }
  }
}