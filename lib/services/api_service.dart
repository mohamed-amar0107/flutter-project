import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  static const String baseUrl = 'https://fakestoreapi.com';

  Future<List<Product>> fetchProducts() async {
    print('🔄 Chargement depuis Fake Store API...');

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products'),
      ).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print('✅ ${data.length} produits chargés');

        return data.map((json) {
          return Product(
            id: json['id'],
            title: json['title'],
            price: json['price'].toDouble(),
            description: json['description'],
            // Fake Store API stocke l'image dans 'image' (string)
            // On la convertit en liste pour ton modèle
            images: [json['image']],
            category: json['category'],
          );
        }).toList();
      } else {
        print('❌ Erreur HTTP: ${response.statusCode}');
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('❌ Exception: $e');
      throw Exception('Network error: $e');
    }
  }

  // Méthode pour récupérer les catégories
  Future<List<String>> fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products/categories'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return List<String>.from(data);
      }
      return ['electronics', 'jewelery', "men's clothing", "women's clothing"];
    } catch (e) {
      return ['electronics', 'jewelery', "men's clothing", "women's clothing"];
    }
  }

  // Méthode pour produits par catégorie
  Future<List<Product>> fetchProductsByCategory(String category) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products/category/$category'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) {
          return Product(
            id: json['id'],
            title: json['title'],
            price: json['price'].toDouble(),
            description: json['description'],
            images: [json['image']],
            category: json['category'],
          );
        }).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}