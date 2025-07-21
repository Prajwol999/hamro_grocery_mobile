import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// The class name is OrderItemEntity as per the import
import 'package:hamro_grocery_mobile/feature/order/domain/entity/order_item_entity.dart';
// Removed unused import for CartScreen as we are no longer navigating from here
// import 'package:hamro_grocery_mobile/feature/order/presentation/view/cart_screen.dart';
import 'package:hamro_grocery_mobile/feature/order/presentation/view_model/cart_event.dart';
import 'package:hamro_grocery_mobile/feature/order/presentation/view_model/cart_state.dart';
import 'package:hamro_grocery_mobile/feature/order/presentation/view_model/cart_view_model.dart';
import 'package:hamro_grocery_mobile/feature/product/domain/entity/product_entity.dart';

import '../../../order/presentation/view/cart_screen.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      buildWhen:
          (previous, current) =>
              previous.cartItems[product.productId] !=
              current.cartItems[product.productId],
      builder: (context, cartState) {
        final isInCart = cartState.cartItems.containsKey(product.productId);
        final cartItem =
            isInCart ? cartState.cartItems[product.productId] : null;
        int quantityInCart = cartItem?.quantity ?? 0;

        return SizedBox(
          height: 250,
          width: 160,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Center(
                    child: Image.network(
                      product.imageUrl ?? '',
                      width: double.infinity,
                      height: 100,
                      fit: BoxFit.contain,
                      errorBuilder:
                          (context, error, stackTrace) => Container(
                            width: double.infinity,
                            height: 100,
                            color: Colors.grey[200],
                            child: const Icon(
                              Icons.image_not_supported,
                              size: 50,
                              color: Colors.grey,
                            ),
                          ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 8.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name ?? 'No Name',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Nrs. ${product.price?.toStringAsFixed(0) ?? '0'} /-',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        if (isInCart)
                          _QuantityChanger(
                            quantity: quantityInCart,
                            onDecrement: () {
                              context.read<CartBloc>().add(
                                DecrementCartItem(product.productId!),
                              );
                            },
                            onIncrement: () {
                              context.read<CartBloc>().add(
                                IncrementCartItem(product.productId!),
                              );
                            },
                          )
                        else
                          _AddToCartButton(
                            onPressed: () {
                              // This check correctly handles unavailable items
                              if (product.productId == null ||
                                  product.price == null ||
                                  product.name == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.redAccent,
                                    content: Text(
                                      'This item is currently unavailable.',
                                    ),
                                  ),
                                );
                                return;
                              }

                              // FIX 1: Use the correct class name 'OrderItemEntity'
                              final orderItem = OrderItem(
                                productId: product.productId!,
                                quantity: 1,
                                price: product.price!,
                                name: product.name!,
                                imageUrl: product.imageUrl ?? '',
                              );

                              context.read<CartBloc>().add(
                                AddItemToCart(orderItem),
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const CartScreen(),
                                ),
                              );
        }
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AddToCartButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _AddToCartButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 36,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(vertical: 8),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: const Text(
          'Add to Cart',
          style: TextStyle(fontSize: 12, color: Colors.white),
        ),
      ),
    );
  }
}

class _QuantityChanger extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const _QuantityChanger({
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.remove, size: 18, color: Colors.green),
            onPressed: onDecrement,
          ),
          Text(
            '$quantity',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.add, size: 18, color: Colors.green),
            onPressed: onIncrement,
          ),
        ],
      ),
    );
  }
}
