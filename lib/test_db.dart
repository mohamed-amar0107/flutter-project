import 'utils/database_helper.dart';

Future<void> testDatabase() async {
  print('🧪 Test de la base de données...');

  final dbHelper = DatabaseHelper();

  try {
    final db = await dbHelper.database;
    print('✅ Base de données initialisée avec succès');

    // Test d'ajout d'un article
    final result = await db.insert('cart_items', {
      'productId': 999,
      'title': 'Produit Test',
      'price': 10.0,
      'image': 'test.jpg',
      'quantity': 1,
    });

    print('✅ Article ajouté avec id: $result');

    // Test de lecture
    final items = await db.query('cart_items');
    print('✅ ${items.length} article(s) dans le panier');

    // Nettoyage
    await db.delete('cart_items', where: 'productId = ?', whereArgs: [999]);
    print('✅ Test nettoyé');

  } catch (e) {
    print('❌ Erreur base de données: $e');
  }
}