import '../../../../core/core.dart';
import '../../product_module.dart';

abstract class CategoryDatasource {
  Future<ApiResult<List<CategoryModel>>> getCategories();
  Future<ApiResult<CategoryDetailModel>> getCategoryWithProducts(
    String categoryId,
  );
}
