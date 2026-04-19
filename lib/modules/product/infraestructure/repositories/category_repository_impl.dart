import '../../../../core/core.dart';
import '../../product_module.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryDatasource datasource;

  CategoryRepositoryImpl({required this.datasource});

  @override
  Future<ApiResult<List<CategoryEntity>>> getCategories() async {
    final ApiResult<List<CategoryModel>> result = await datasource
        .getCategories();

    return result.when(
      success: (List<CategoryModel> categoriesModel) {
        final List<CategoryEntity> categoriesEntity = categoriesModel
            .map((CategoryModel category) => category.toEntity())
            .toList();
        return Success<List<CategoryEntity>>(categoriesEntity);
      },
      failure: (AppError error) {
        return Failure<List<CategoryEntity>>(error);
      },
    );
  }

  @override
  Future<ApiResult<CategoryDetailEntity>> getCategoryWithProducts(
    String categoryId,
  ) async {
    final ApiResult<CategoryDetailModel> result = await datasource
        .getCategoryWithProducts(categoryId);

    return result.when(
      success: (CategoryDetailModel categoryDetailModel) {
        final CategoryDetailEntity categoryDetailEntity = categoryDetailModel
            .toEntity();

        return Success<CategoryDetailEntity>(categoryDetailEntity);
      },
      failure: (AppError error) {
        return Failure<CategoryDetailEntity>(error);
      },
    );
  }
}
