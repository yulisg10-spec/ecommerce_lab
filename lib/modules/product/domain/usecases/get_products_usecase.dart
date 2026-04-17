import '../../../../core/core.dart';
import '../../product_module.dart';

class GetProductsUsecase {
  final ProductRepository repository;

  GetProductsUsecase({required this.repository});

  Future<ApiResult<List<ProductEntity>>> call() async {
    return repository.getProducts();
  }
}
