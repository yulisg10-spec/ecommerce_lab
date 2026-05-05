import '../../../../core/core.dart';
import '../../product_module.dart';

class ProductDatasourceImpl implements ProductDatasource {
  final ApiClient apiClient;

  ProductDatasourceImpl({required this.apiClient});

  @override
  Future<ApiResult<List<ProductModel>>> getProductsByCategory(
    String categoryId,
  ) async {
    return apiClient.post(
      url: ApiEndpoints.productsByCategory,
      body: <String, dynamic>{'categoryId': categoryId},
      fromJson: (Map<String, dynamic> json) {
        final List<Map<String, dynamic>> jsonList =
            (json['data'] as List<dynamic>).cast<Map<String, dynamic>>();

        return jsonList
            .map((Map<String, dynamic> json) => ProductModel.fromJson(json))
            .toList();
      },
    );
  }

  @override
  Future<ApiResult<List<ProductModel>>> searchProducts(String query) {
    return apiClient.post(
      url: ApiEndpoints.searchProducts,
      body: <String, dynamic>{'name': query},
      fromJson: (Map<String, dynamic> json) {
        final List<Map<String, dynamic>> jsonList =
            (json['data'] as List<dynamic>).cast<Map<String, dynamic>>();

        return jsonList
            .map((Map<String, dynamic> json) => ProductModel.fromJson(json))
            .toList();
      },
    );
  }
}
