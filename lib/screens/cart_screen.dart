import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../core/constants/app_colors.dart';
import '../providers/cart_provider.dart';
import '../widgets/custom_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();
    final currencyFormat = NumberFormat.currency(symbol: '\$', decimalDigits: 2);
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Mi Carrito'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          if (cartProvider.cart.isNotEmpty)
            TextButton(
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Vaciar Carrito'),
                    content: const Text('¿Estás seguro de que deseas vaciar el carrito?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text(
                          'Vaciar',
                          style: TextStyle(color: AppColors.error),
                        ),
                      ),
                    ],
                  ),
                );
                
                if (confirm == true && context.mounted) {
                  await context.read<CartProvider>().clearCart();
                }
              },
              child: const Text(
                'Vaciar',
                style: TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
      body: cartProvider.cart.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 100,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Tu carrito está vacío',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Ir a Comprar'),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                // Cart items
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cartProvider.cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cartProvider.cart.items[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              // Product image
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: item.product.imageUrl != null
                                    ? Image.network(
                                        item.product.imageUrl!,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return const Icon(Icons.image, size: 40);
                                        },
                                      )
                                    : const Icon(Icons.image, size: 40),
                              ),
                              const SizedBox(width: 12),
                              
                              // Product info
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.product.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      currencyFormat.format(item.product.currentPrice),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    
                                    // Quantity controls
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.remove_circle_outline),
                                          onPressed: () {
                                            if (item.id != null) {
                                              cartProvider.updateQuantity(
                                                item.id!,
                                                item.quantity - 1,
                                              );
                                            }
                                          },
                                          iconSize: 24,
                                          color: AppColors.primary,
                                        ),
                                        Text(
                                          '${item.quantity}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.add_circle_outline),
                                          onPressed: () {
                                            if (item.id != null && item.quantity < item.product.stock) {
                                              cartProvider.updateQuantity(
                                                item.id!,
                                                item.quantity + 1,
                                              );
                                            }
                                          },
                                          iconSize: 24,
                                          color: AppColors.primary,
                                        ),
                                        const Spacer(),
                                        Text(
                                          currencyFormat.format(item.subtotal),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              
                              // Delete button
                              IconButton(
                                icon: const Icon(Icons.delete_outline),
                                onPressed: () {
                                  if (item.id != null) {
                                    cartProvider.removeFromCart(item.id!);
                                  }
                                },
                                color: AppColors.error,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                
                // Total and checkout
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total:',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              currencyFormat.format(cartProvider.total),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            text: 'Proceder al Pago',
                            onPressed: () {
                              Navigator.of(context).pushNamed('/checkout');
                            },
                            icon: Icons.payment,
                            isLoading: cartProvider.isLoading,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
