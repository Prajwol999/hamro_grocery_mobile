import 'package:hamro_grocery_mobile/feature/product/data/data_source/product_data_source.dart';
import 'package:hamro_grocery_mobile/feature/product/domain/entity/product_entity.dart';

class ProductRemoteRepository implements IProductDataSource {
  final IProductDataSource _productDataSource;

  ProductRemoteRepository(this._productDataSource);
  @override
  Future<List<ProductEntity>> getAllProducts() async {
    try {
      return await _productDataSource.getAllProducts();
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }
}
