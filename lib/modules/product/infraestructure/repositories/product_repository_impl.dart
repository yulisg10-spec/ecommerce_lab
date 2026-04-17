import '../../../../core/core.dart';
import '../../product_module.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDatasource datasource;

  ProductRepositoryImpl({required this.datasource});

  @override
  Future<ApiResult<List<ProductEntity>>> getProducts() async {
    final ApiResult<List<ProductModel>> result = await datasource.getProducts();

    return result.when(
      success: (productsModel) {
        final productsEntity = productsModel
            .map((product) => product.toEntity())
            .toList();
        return Success(productsEntity);
      },
      failure: (error) {
        return Failure(error);
      },
    );
  }

  @override
  Future<ApiResult<List<ProductEntity>>> getSearchProducts(String query) async {
    final ApiResult<List<ProductModel>> result = await datasource
        .getSearchProducts(query);

    return result.when(
      success: (productsModel) {
        final productsEntity = productsModel
            .map((product) => product.toEntity())
            .toList();
        return Success(productsEntity);
      },
      failure: (error) {
        return Failure(error);
      },
    );
  }

  @override
  Future<ApiResult<List<ProductEntity>>> getProductByCategory(
    String category,
  ) async {
    final ApiResult<List<ProductModel>> result = await datasource
        .getProductByCategory(category);

    return result.when(
      success: (productsModel) {
        final productsEntity = productsModel
            .map((product) => product.toEntity())
            .toList();
        return Success(productsEntity);
      },
      failure: (error) {
        return Failure(error);
      },
    );
  }
}
