import '../../../../core/core.dart';
import '../../product_module.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDatasource datasource;

  ProductRepositoryImpl({required this.datasource});

  @override
  Future<ApiResult<List<ProductEntity>>> getProductsByCategory(
    String categoryId,
  ) async {
    final ApiResult<List<ProductModel>> result = await datasource
        .getProductsByCategory(categoryId);

    return result.when(
      success: (List<ProductModel> productsModel) {
        final List<ProductEntity> productsEntity = productsModel
            .map((ProductModel product) => product.toEntity())
            .toList();
        return Success<List<ProductEntity>>(productsEntity);
      },
      failure: (AppError error) {
        return Failure<List<ProductEntity>>(error);
      },
    );
  }

  @override
  Future<ApiResult<List<ProductEntity>>> searchProducts(String query) async {
    final ApiResult<List<ProductModel>> result = await datasource
        .searchProducts(query);

    return result.when(
      success: (List<ProductModel> productsModel) {
        final List<ProductEntity> productsEntity = productsModel
            .map((ProductModel product) => product.toEntity())
            .toList();
        return Success<List<ProductEntity>>(productsEntity);
      },
      failure: (AppError error) {
        return Failure<List<ProductEntity>>(error);
      },
    );
  }
}
