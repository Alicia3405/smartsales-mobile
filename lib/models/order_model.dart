class Order {
  final int id;
  final String orderNumber;
  final DateTime createdAt;
  final String status;
  final double total;
  final List<OrderItem> items;
  final String? paymentMethod;
  
  Order({
    required this.id,
    required this.orderNumber,
    required this.createdAt,
    required this.status,
    required this.total,
    required this.items,
    this.paymentMethod,
  });
  
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? 0,
      orderNumber: json['order_number'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      status: json['status'] ?? 'pendiente',
      total: (json['total'] ?? 0).toDouble(),
      items: (json['items'] as List?)
          ?.map((item) => OrderItem.fromJson(item))
          .toList() ?? [],
      paymentMethod: json['payment_method'],
    );
  }
  
  String get statusText {
    switch (status.toLowerCase()) {
      case 'pendiente':
        return 'Pendiente';
      case 'procesando':
        return 'Procesando';
      case 'enviado':
        return 'Enviado';
      case 'entregado':
        return 'Entregado';
      case 'cancelado':
        return 'Cancelado';
      default:
        return status;
    }
  }
}

class OrderItem {
  final int id;
  final String productName;
  final int quantity;
  final double price;
  
  OrderItem({
    required this.id,
    required this.productName,
    required this.quantity,
    required this.price,
  });
  
  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'] ?? 0,
      productName: json['product_name'] ?? '',
      quantity: json['quantity'] ?? 0,
      price: (json['price'] ?? 0).toDouble(),
    );
  }
  
  double get subtotal => price * quantity;
}
