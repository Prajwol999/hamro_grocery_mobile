import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamro_grocery_mobile/feature/product/domain/usecase/get_all_product_usecase.dart';
import 'package:hamro_grocery_mobile/feature/product/presentation/view_model/product_event.dart';
import 'package:hamro_grocery_mobile/feature/product/presentation/view_model/product_state.dart';

class ProductViewModel extends Bloc<ProductEvent, ProductState> {
  final GetAllProductUsecase getAllProductUsecase;
  ProductViewModel({required this.getAllProductUsecase})
    : super(const ProductState.initial()) {
    on<LoadProductsEvent>(_onLoadProducts);
    add(LoadProductsEvent());
  }

  Future<void> _onLoadProducts(
    LoadProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await getAllProductUsecase();

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, errorMessage: failure.message));
      },
      (products) {
        emit(state.copyWith(isLoading: false, products: products));
      },
    );
  }
}
