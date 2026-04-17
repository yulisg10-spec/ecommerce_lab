import '../../../../core/core.dart';
import '../../product_module.dart';

class ProductDatasourceImpl implements ProductDatasource {
  final ApiClient apiClient;

  ProductDatasourceImpl({required this.apiClient});

  @override
  Future<ApiResult<List<ProductModel>>> getProducts() async {
    return apiClient.get(
      url: ApiEndpoints.products,
      fromJson: (data) {
        final List<Map<String, dynamic>> jsonList =
            (data['products'] as List<dynamic>).cast<Map<String, dynamic>>();

        return jsonList.map((json) => ProductModel.fromJson(json)).toList();
      },
    );
  }

  @override
  Future<ApiResult<List<ProductModel>>> getSearchProducts(String query) {
    return apiClient.get(
      url: ApiEndpoints.searchProducts(query),
      fromJson: (data) {
        final List<Map<String, dynamic>> jsonList =
            (data['products'] as List<dynamic>).cast<Map<String, dynamic>>();

        return jsonList.map((json) => ProductModel.fromJson(json)).toList();
      },
    );
  }

  @override
  Future<ApiResult<List<ProductModel>>> getProductByCategory(String category) {
    return apiClient.get(
      url: ApiEndpoints.productByCategory(category),
      fromJson: (data) {
        final List<Map<String, dynamic>> jsonList =
            (data['products'] as List<dynamic>).cast<Map<String, dynamic>>();

        return jsonList.map((json) => ProductModel.fromJson(json)).toList();
      },
    );
  }
}
