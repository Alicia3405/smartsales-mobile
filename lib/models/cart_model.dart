import 'product_model.dart';

class CartItem {
  final int? id;
  final Product product;
  int quantity;
  
  CartItem({
    this.id,
    required this.product,
    required this.quantity,
  });
  
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      product: Product.fromJson(json['product']),
      quantity: json['quantity'] ?? 1,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'product': product.id,
      'quantity': quantity,
    };
  }
  
  double get subtotal => product.currentPrice * quantity;
}

class Cart {
  final List<CartItem> items;
  
  Cart({required this.items});
  
  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      items: (json['items'] as List?)
          ?.map((item) => CartItem.fromJson(item))
          .toList() ?? [],
    );
  }
  
  double get total {
    return items.fold(0, (sum, item) => sum + item.subtotal);
  }
  
  int get totalItems {
    return items.fold(0, (sum, item) => sum + item.quantity);
  }
  
  bool get isEmpty => items.isEmpty;
  bool get isNotEmpty => items.isNotEmpty;
}
