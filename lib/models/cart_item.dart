import 'product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    required this.quantity,
  });

  double get totalPrice => product.price * quantity;

  Map<String, dynamic> toJson() {
    return {
      'product_id': product.id,
      'quantity': quantity,
      'price': product.price,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json, Product product) {
    return CartItem(
      product: product,
      quantity: json['quantity'] ?? 1,
    );
  }

  CartItem copyWith({
    Product? product,
    int? quantity,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}
