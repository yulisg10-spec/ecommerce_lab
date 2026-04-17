import '../../../../core/core.dart';
import '../../product_module.dart';

class CategoryDatasourceImpl implements CategoryDatasource {
  final ApiClient apiClient;

  CategoryDatasourceImpl({required this.apiClient});

  @override
  Future<ApiResult<List<CategoryModel>>> getCategories() async {
    return apiClient.get(
      url: ApiEndpoints.categories,
      fromJson: (data) {
        final List<String> jsonList = (data as List<dynamic>).cast<String>();

        return jsonList.map((json) => CategoryModel.fromJson(json)).toList();
      },
    );
  }
}
