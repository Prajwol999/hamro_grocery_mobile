import 'package:hamro_grocery_mobile/app/constant/api_endpoints.dart';
import 'package:hamro_grocery_mobile/core/network/api_service.dart';
import 'package:hamro_grocery_mobile/feature/product/data/data_source/product_data_source.dart';
import 'package:hamro_grocery_mobile/feature/product/data/dto/get_all_product_dto.dart';
import 'package:hamro_grocery_mobile/feature/product/data/model/product_api_model.dart';
import 'package:hamro_grocery_mobile/feature/product/domain/entity/product_entity.dart';

class ProductRemoteDataSource implements IProductDataSource {
  final ApiService _apiService;

  ProductRemoteDataSource({required ApiService apiService})
    : _apiService = apiService;

  @override
  Future<List<ProductEntity>> getAllProducts() async {
    try {
      // Assuming the API endpoint for products is defined in ApiEndpoints
      final response = await _apiService.dio.get(ApiEndpoints.getAllProducts);
      if (response.statusCode == 200) {
        GetAllProductDto getAllProductDto = GetAllProductDto.fromJson(
          response.data,
        );
        return ProductApiModel.toEntityList(getAllProductDto.data);
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }
}
