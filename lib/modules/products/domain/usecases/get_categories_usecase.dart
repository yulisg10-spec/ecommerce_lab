import '../../../../core/core.dart';
import '../../product_module.dart';

class GetCategoriesUsecase {
  final CategoryRepository repository;

  GetCategoriesUsecase({required this.repository});

  Future<ApiResult<List<CategoryEntity>>> call() async {
    return repository.getCategories();
  }
}
