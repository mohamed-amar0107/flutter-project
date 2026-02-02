import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/cart_item.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, 'cart.db');

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE cart_items(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            productId INTEGER UNIQUE,
            title TEXT,
            price REAL,
            image TEXT,
            quantity INTEGER
          )
        ''');
        print('✅ Table cart_items créée');
      },
      onOpen: (db) {
        print('✅ Base de données ouverte');
      },
    );
  }

  // Ajouter au panier
  Future<int> addToCart(CartItem item) async {
    final db = await database;

    // Vérifier si le produit existe déjà
    final existing = await db.query(
      'cart_items',
      where: 'productId = ?',
      whereArgs: [item.productId],
    );

    if (existing.isNotEmpty) {
      // Mettre à jour la quantité
      final currentItem = CartItem.fromMap(existing.first);
      final newQuantity = currentItem.quantity + 1;

      return await db.update(
        'cart_items',
        {'quantity': newQuantity},
        where: 'productId = ?',
        whereArgs: [item.productId],
      );
    } else {
      // Ajouter nouveau produit
      return await db.insert('cart_items', item.toMap());
    }
  }

  // Récupérer tous les articles du panier
  Future<List<CartItem>> getCartItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('cart_items');
    return List.generate(maps.length, (i) {
      return CartItem.fromMap(maps[i]);
    });
  }

  // Mettre à jour la quantité
  Future<int> updateQuantity(int productId, int quantity) async {
    final db = await database;
    return await db.update(
      'cart_items',
      {'quantity': quantity},
      where: 'productId = ?',
      whereArgs: [productId],
    );
  }

  // Supprimer du panier
  Future<int> removeFromCart(int productId) async {
    final db = await database;
    return await db.delete(
      'cart_items',
      where: 'productId = ?',
      whereArgs: [productId],
    );
  }

  // Vider le panier
  Future<int> clearCart() async {
    final db = await database;
    return await db.delete('cart_items');
  }

  // Compter les articles
  Future<int> getCartCount() async {
    final db = await database;
    final result = await db.rawQuery(
        'SELECT SUM(quantity) as total FROM cart_items'
    );
    return result.first['total'] as int? ?? 0;
  }
}