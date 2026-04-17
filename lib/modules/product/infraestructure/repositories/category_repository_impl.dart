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
      success: (categoriesModel) {
        final categoriesEntity = categoriesModel
            .map((category) => category.toEntity())
            .toList();
        return Success(categoriesEntity);
      },
      failure: (error) {
        return Failure(error);
      },
    );
  }
}
