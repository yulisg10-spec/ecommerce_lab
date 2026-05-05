import '../../../../core/core.dart';
import '../../product_module.dart';

abstract class ProductDatasource {
  Future<ApiResult<List<ProductModel>>> getProductsByCategory(
    String categoryId,
  );
  Future<ApiResult<List<ProductModel>>> searchProducts(String query);
}
