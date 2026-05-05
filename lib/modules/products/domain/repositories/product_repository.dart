import '../../../../core/core.dart';
import '../../product_module.dart';

abstract class ProductRepository {
  Future<ApiResult<List<ProductEntity>>> getProductsByCategory(
    String categoryId,
  );
  Future<ApiResult<List<ProductEntity>>> searchProducts(String query);
}
