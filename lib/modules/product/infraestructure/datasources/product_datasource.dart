import '../../../../core/core.dart';
import '../../product_module.dart';

abstract class ProductDatasource {
  Future<ApiResult<List<ProductModel>>> getSearchProducts(String query);
}
