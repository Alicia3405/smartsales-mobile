class User {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String? phone;
  final String role;
  final bool isActive;
  
  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.phone,
    required this.role,
    required this.isActive,
  });
  
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      phone: json['phone'],
      role: json['role'] ?? 'cliente',
      isActive: json['is_active'] ?? true,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'role': role,
      'is_active': isActive,
    };
  }
  
  String get fullName => '$firstName $lastName';
  
  bool get isAdmin => role == 'admin';
  bool get isVendedor => role == 'vendedor';
  bool get isCliente => role == 'cliente';
}
