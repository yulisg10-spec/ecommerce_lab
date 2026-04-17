import '../../../../core/core.dart';
import '../../product_module.dart';

abstract class ProductRepository {
  Future<ApiResult<List<ProductEntity>>> getProducts();
  Future<ApiResult<List<ProductEntity>>> getSearchProducts(String query);
  Future<ApiResult<List<ProductEntity>>> getProductByCategory(String category);
}
