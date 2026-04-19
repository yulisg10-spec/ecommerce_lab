import '../../../../core/core.dart';
import '../../product_module.dart';

class CategoryDatasourceImpl implements CategoryDatasource {
  final ApiClient apiClient;

  CategoryDatasourceImpl({required this.apiClient});

  @override
  Future<ApiResult<List<CategoryModel>>> getCategories() async {
    return apiClient.get(
      url: ApiEndpoints.categories,
      fromJson: (Map<String, dynamic> data) {
        final List<Map<String, dynamic>> jsonList = (data as List<dynamic>)
            .cast<Map<String, dynamic>>();

        return jsonList
            .map((Map<String, dynamic> json) => CategoryModel.fromJson(json))
            .toList();
      },
    );
  }

  @override
  Future<ApiResult<CategoryDetailModel>> getCategoryWithProducts(
    String categoryId,
  ) async {
    return apiClient.post(
      url: ApiEndpoints.categoryProducts,
      body: <String, dynamic>{'category_id': categoryId},
      fromJson: (Map<String, dynamic> data) {
        return CategoryDetailModel.fromJson(data);
      },
    );
  }
}
