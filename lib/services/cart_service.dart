import '../models/cart_item.dart';
import '../utils/database_helper.dart';

class CartService {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> addProductToCart({
    required int productId,
    required String title,
    required double price,
    required String image,
  }) async {
    final item = CartItem(
      productId: productId,
      title: title,
      price: price,
      image: image,
      quantity: 1, // Initialiser à 1
    );
    await _dbHelper.addToCart(item);
  }

  Future<List<CartItem>> getCartItems() async {
    return await _dbHelper.getCartItems();
  }

  Future<void> updateItemQuantity(int productId, int quantity) async {
    if (quantity <= 0) {
      await _dbHelper.removeFromCart(productId);
    } else {
      await _dbHelper.updateQuantity(productId, quantity);
    }
  }

  Future<void> removeItem(int productId) async {
    await _dbHelper.removeFromCart(productId);
  }

  Future<void> clearCart() async {
    await _dbHelper.clearCart();
  }

  Future<int> getCartItemCount() async {
    return await _dbHelper.getCartCount();
  }

  Future<double> getCartTotal() async {
    final items = await getCartItems();
    double total = 0;
    for (var item in items) {
      total += item.total;
    }
    return total;
  }
}