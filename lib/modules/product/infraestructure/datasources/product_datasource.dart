import '../../../../core/core.dart';
import '../../product_module.dart';

abstract class ProductDatasource {
  Future<ApiResult<List<ProductModel>>> getProducts();
  Future<ApiResult<List<ProductModel>>> getSearchProducts(String query);
  Future<ApiResult<List<ProductModel>>> getProductByCategory(String category);
}
