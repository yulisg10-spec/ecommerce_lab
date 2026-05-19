import '../../../../core/core.dart';
import '../../product_module.dart';

class CategoryDatasourceImpl implements CategoryDatasource {
  final ApiClient apiClient;

  CategoryDatasourceImpl({required this.apiClient});

  @override
  Future<ApiResult<List<CategoryModel>>> getCategories() async {
    return apiClient.get(
      url: ApiEndpoints.categories,
      fromJson: (Map<String, dynamic> json) {
        final List<Map<String, dynamic>> jsonList =
            (json['data'] as List<dynamic>).cast<Map<String, dynamic>>();

        return jsonList
            .map((Map<String, dynamic> json) => CategoryModel.fromJson(json))
            .toList();
      },
    );
  }
}
