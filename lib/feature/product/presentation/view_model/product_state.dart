import 'package:equatable/equatable.dart';
import 'package:hamro_grocery_mobile/feature/product/domain/entity/product_entity.dart';

class ProductState extends Equatable {
  final List<ProductEntity> products;
  final bool isLoading;
  final String? errorMessage;

  const ProductState({
    required this.products,
    this.isLoading = false,
    this.errorMessage,
  });

  const ProductState.initial()
    : products = const [],
      isLoading = false,
      errorMessage = null;

  ProductState copyWith({
    List<ProductEntity>? products,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ProductState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [products, isLoading, errorMessage];
}
