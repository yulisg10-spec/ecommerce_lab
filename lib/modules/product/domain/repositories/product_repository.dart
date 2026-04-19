import '../../../../core/core.dart';
import '../../product_module.dart';

abstract class ProductRepository {
  Future<ApiResult<List<ProductEntity>>> getSearchProducts(String query);
}
