import '../../../../core/core.dart';
import '../../product_module.dart';

class ProductDatasourceImpl implements ProductDatasource {
  final ApiClient apiClient;

  ProductDatasourceImpl({required this.apiClient});

  @override
  Future<ApiResult<List<ProductModel>>> getSearchProducts(String query) {
    return apiClient.get(
      url: ApiEndpoints.searchProducts(query),
      fromJson: (Map<String, dynamic> data) {
        final List<Map<String, dynamic>> jsonList =
            (data['products'] as List<dynamic>).cast<Map<String, dynamic>>();

        return jsonList
            .map((Map<String, dynamic> json) => ProductModel.fromJson(json))
            .toList();
      },
    );
  }
}
