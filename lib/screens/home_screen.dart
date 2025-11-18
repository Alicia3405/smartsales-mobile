import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_colors.dart';
import '../providers/auth_provider.dart';
import '../providers/product_provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    final productProvider = context.read<ProductProvider>();
    final cartProvider = context.read<CartProvider>();

    await Future.wait([
      productProvider.loadProducts(),
      productProvider.loadCategories(),
      cartProvider.loadCart(),
    ]);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final productProvider = context.watch<ProductProvider>();
    final cartProvider = context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('SmartSales'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          // Cart icon with badge
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed('/cart');
                },
              ),
              if (cartProvider.itemCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColors.error,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${cartProvider.itemCount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          // Profile menu
          PopupMenuButton(
            icon: const Icon(Icons.account_circle),
            itemBuilder: (context) => <PopupMenuEntry>[
              PopupMenuItem(
                enabled: false,
                child:
                    Text('Hola, ${authProvider.user?.firstName ?? "Usuario"}'),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem(
                value: 'profile',
                child: Row(
                  children: [
                    Icon(Icons.person, size: 20),
                    SizedBox(width: 8),
                    Text('Mi Perfil'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'orders',
                child: Row(
                  children: [
                    Icon(Icons.receipt_long, size: 20),
                    SizedBox(width: 8),
                    Text('Mis Pedidos'),
                  ],
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout, size: 20, color: AppColors.error),
                    SizedBox(width: 8),
                    Text('Cerrar Sesión',
                        style: TextStyle(color: AppColors.error)),
                  ],
                ),
              ),
            ],
            onSelected: (value) async {
              if (value == 'logout') {
                await authProvider.logout();
                if (mounted) {
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushReplacementNamed('/login');
                }
              } else if (value == 'profile') {
                if (mounted) {
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushNamed('/profile');
                }
              } else if (value == 'orders') {
                if (mounted) {
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushNamed('/orders');
                }
              }
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: Column(
          children: [
            // Search bar
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Buscar productos...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            productProvider.setSearchQuery('');
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.divider),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                onChanged: (value) {
                  productProvider.setSearchQuery(value);
                },
              ),
            ),

            // Categories
            if (productProvider.categories.isNotEmpty)
              Container(
                height: 50,
                color: Colors.white,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _buildCategoryChip(
                      'Todos',
                      productProvider.selectedCategoryId == null,
                      () => productProvider.setSelectedCategory(null),
                    ),
                    ...productProvider.categories.map((category) {
                      return _buildCategoryChip(
                        category.name,
                        productProvider.selectedCategoryId == category.id,
                        () => productProvider.setSelectedCategory(category.id),
                      );
                    }),
                  ],
                ),
              ),

            // Products grid
            Expanded(
              child: productProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : productProvider.filteredProducts.isEmpty
                      ? const Center(
                          child: Text(
                            'No hay productos disponibles',
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                        )
                      : GridView.builder(
                          padding: const EdgeInsets.all(16),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                          itemCount: productProvider.filteredProducts.length,
                          itemBuilder: (context, index) {
                            final product =
                                productProvider.filteredProducts[index];
                            return ProductCard(
                              product: product,
                              onTap: () {
                                // TODO: Navigate to product detail
                              },
                              onAddToCart: () async {
                                final success =
                                    await cartProvider.addToCart(product.id, 1);
                                if (mounted) {
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        success
                                            ? 'Producto agregado al carrito'
                                            : 'Error al agregar al carrito',
                                      ),
                                      backgroundColor: success
                                          ? AppColors.success
                                          : AppColors.error,
                                    ),
                                  );
                                }
                              },
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label, bool isSelected, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => onTap(),
        backgroundColor: Colors.white,
        selectedColor: AppColors.primary.withValues(alpha: 0.2),
        checkmarkColor: AppColors.primary,
        labelStyle: TextStyle(
          color: isSelected ? AppColors.primary : AppColors.textSecondary,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }
}
