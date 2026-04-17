import '../../../../core/core.dart';
import '../../product_module.dart';

class GetSearchProductsUsecase {
  final ProductRepository repository;

  GetSearchProductsUsecase({required this.repository});

  Future<ApiResult<List<ProductEntity>>> call(String query) async {
    return repository.getSearchProducts(query);
  }
}
