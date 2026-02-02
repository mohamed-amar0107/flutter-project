class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final List<String> images;
  final String category;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.images,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      description: json['description'],
      images: List<String>.from(json['images']),
      category: json['category']['name'] ?? 'Unknown',
    );
  }
}