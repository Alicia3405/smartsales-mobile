class Product {
  final int id;
  final String name;
  final String? description;
  final String? sku;
  final int categoryId;
  final String? categoryName;
  final double currentPrice;
  final int stock;
  final String? imageUrl;
  final bool isActive;
  
  Product({
    required this.id,
    required this.name,
    this.description,
    this.sku,
    required this.categoryId,
    this.categoryName,
    required this.currentPrice,
    required this.stock,
    this.imageUrl,
    this.isActive = true,
  });
  
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'],
      sku: json['sku'],
      categoryId: json['category'] ?? 0,
      categoryName: json['category_name'],
      currentPrice: (json['current_price'] ?? 0).toDouble(),
      stock: json['stock'] ?? 0,
      imageUrl: json['image_url'],
      isActive: json['is_active'] ?? true,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'sku': sku,
      'category': categoryId,
      'category_name': categoryName,
      'current_price': currentPrice,
      'stock': stock,
      'image_url': imageUrl,
      'is_active': isActive,
    };
  }
  
  bool get isInStock => stock > 0;
  bool get isLowStock => stock > 0 && stock <= 10;
}

class Category {
  final int id;
  final String name;
  final String? description;
  
  Category({
    required this.id,
    required this.name,
    this.description,
  });
  
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}
