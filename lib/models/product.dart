class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final int stock;
  final String? image;
  final String category;
  final String sku;
  final bool isActive;
  final DateTime createdAt;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    this.image,
    required this.category,
    required this.sku,
    required this.isActive,
    required this.createdAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
      stock: json['stock'] ?? 0,
      image: json['image'],
      category: json['category'] ?? '',
      sku: json['sku'] ?? '',
      isActive: json['is_active'] ?? true,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'stock': stock,
      'image': image,
      'category': category,
      'sku': sku,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
    };
  }

  bool get isInStock => stock > 0;
  
  String get formattedPrice => '\$${price.toStringAsFixed(2)}';
}
