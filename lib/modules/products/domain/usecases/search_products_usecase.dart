import '../../../../core/core.dart';
import '../../product_module.dart';

class SearchProductsUsecase {
  final ProductRepository repository;

  SearchProductsUsecase({required this.repository});

  Future<ApiResult<List<ProductEntity>>> call(String query) async {
    return repository.searchProducts(query);
  }
}
