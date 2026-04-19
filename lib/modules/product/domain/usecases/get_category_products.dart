import '../../../../core/core.dart';
import '../../product_module.dart';

class GetCategoryProductsUsecase {
  final CategoryRepository repository;

  GetCategoryProductsUsecase({required this.repository});

  Future<ApiResult<CategoryDetailEntity>> call(String category) async {
    return repository.getCategoryWithProducts(category);
  }
}
