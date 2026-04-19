import '../../../../core/core.dart';
import '../../product_module.dart';

abstract class CategoryRepository {
  Future<ApiResult<List<CategoryEntity>>> getCategories();
  Future<ApiResult<CategoryDetailEntity>> getCategoryWithProducts(
    String categoryId,
  );
}
