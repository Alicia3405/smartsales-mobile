// Order model for SmartSales Mobile

class Order {
  final int id;
  final String status;
  final double total;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final List<OrderItem> items;
  final String? shippingAddress;
  final String? notes;

  Order({
    required this.id,
    required this.status,
    required this.total,
    required this.createdAt,
    this.updatedAt,
    required this.items,
    this.shippingAddress,
    this.notes,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? 0,
      status: json['status'] ?? 'PENDING',
      total: double.tryParse(json['total']?.toString() ?? '0') ?? 0.0,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: json['updated_at'] != null 
          ? DateTime.tryParse(json['updated_at']) 
          : null,
      items: (json['items'] as List<dynamic>?)
          ?.map((item) => OrderItem.fromJson(item))
          .toList() ?? [],
      shippingAddress: json['shipping_address'],
      notes: json['notes'],
    );
  }

  String get statusText {
    switch (status) {
      case 'PENDING':
        return 'Pendiente';
      case 'PAID':
        return 'Pagado';
      case 'SHIPPED':
        return 'Enviado';
      case 'DELIVERED':
        return 'Entregado';
      case 'CANCELLED':
        return 'Cancelado';
      default:
        return status;
    }
  }

  String get formattedTotal => '\$${total.toStringAsFixed(2)}';

  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);
}

class OrderItem {
  final int id;
  final String productName;
  final double price;
  final int quantity;
  final String? productImage;

  OrderItem({
    required this.id,
    required this.productName,
    required this.price,
    required this.quantity,
    this.productImage,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'] ?? 0,
      productName: json['product_name'] ?? json['product']?['name'] ?? '',
      price: double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
      quantity: json['quantity'] ?? 1,
      productImage: json['product_image'] ?? json['product']?['image'],
    );
  }

  double get totalPrice => price * quantity;
  String get formattedPrice => '\$${price.toStringAsFixed(2)}';
  String get formattedTotal => '\$${totalPrice.toStringAsFixed(2)}';
}
