import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamro_grocery_mobile/feature/product/presentation/view/product_card.dart';
import 'package:hamro_grocery_mobile/feature/product/presentation/view_model/product_event.dart';
import 'package:hamro_grocery_mobile/feature/product/presentation/view_model/product_state.dart';
import 'package:hamro_grocery_mobile/feature/product/presentation/view_model/product_view_model.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    // Dispatch the event to load products when the screen is initialized
    context.read<ProductViewModel>().add(LoadProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Products')),
      body: BlocBuilder<ProductViewModel, ProductState>(
        builder: (context, state) {
          if (state.isLoading && state.products.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.errorMessage!),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ProductViewModel>().add(LoadProductsEvent());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state.products.isEmpty) {
            return const Center(child: Text('No products found.'));
          }

          // Use a GridView to display the products
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.6, // Adjust this ratio to fit your card size
            ),
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              final product = state.products[index];
              return ProductCard(product: product);
            },
          );
        },
      ),
    );
  }
}
