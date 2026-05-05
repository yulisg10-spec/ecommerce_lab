import '../../../../core/core.dart';
import '../../product_module.dart';

class GetProductsByCategoryUsecase {
  final ProductRepository repository;

  GetProductsByCategoryUsecase({required this.repository});

  Future<ApiResult<List<ProductEntity>>> call(String categoryId) async {
    return repository.getProductsByCategory(categoryId);
  }
}
