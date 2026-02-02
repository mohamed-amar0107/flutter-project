// lib/test_all.dart
import 'services/auth_service.dart';
import 'services/cart_service.dart';
import 'utils/database_helper.dart';

void testAllServices() async {
  print('🧪 TEST COMPLET DES SERVICES');
  print('=' * 50);

  // 1. Test Base de données
  try {
    final db = DatabaseHelper();
    await db.database;
    print('✅ Base de données: OK');
  } catch (e) {
    print('❌ Base de données: ERREUR - $e');
  }

  // 2. Test Service Panier
  try {
    final cart = CartService();
    final count = await cart.getCartItemCount();
    print('✅ Service Panier: OK (items: $count)');
  } catch (e) {
    print('❌ Service Panier: ERREUR - $e');
  }

  // 3. Test Service Auth (sans appel réseau)
  try {
    final auth = AuthService();
    print('✅ Service Auth: Initialisé');

    // Test optionnel de l'API (décommente si tu veux tester)
    /*
    print('🔗 Test connexion API...');
    final token = await auth.login('john@mail.com', 'changeme');
    print('✅ Login API: OK (token reçu)');
    */
  } catch (e) {
    print('❌ Service Auth: ERREUR - $e');
  }

  print('=' * 50);
  print('🎉 Tests terminés !');
}