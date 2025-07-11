import 'package:hamro_grocery_mobile/feature/product/data/data_source/product_data_source.dart';
import 'package:hamro_grocery_mobile/feature/product/data/data_source/remote_data_source/product_remote_data_source.dart';
import 'package:hamro_grocery_mobile/feature/product/domain/entity/product_entity.dart';

class ProductRemoteRepository implements IProductDataSource {
  final ProductRemoteDataSource _productDataSource;

  ProductRemoteRepository({required ProductRemoteDataSource productRemoteDataSource}) : _productDataSource = productRemoteDataSource
  ;
  @override
  Future<List<ProductEntity>> getAllProducts() async {
    try {
      return await _productDataSource.getAllProducts();
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }
}
