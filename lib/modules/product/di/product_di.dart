import 'package:get_it/get_it.dart';

import '../product_module.dart';

class ProductDI {
  ProductDI._();

  static void register(GetIt getIt) {
    getIt.registerLazySingleton<ProductDatasource>(
      () => ProductDatasourceImpl(apiClient: getIt()),
    );
    getIt.registerLazySingleton<CategoryDatasource>(
      () => CategoryDatasourceImpl(apiClient: getIt()),
    );
    getIt.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(datasource: getIt()),
    );
    getIt.registerLazySingleton<CategoryRepository>(
      () => CategoryRepositoryImpl(datasource: getIt()),
    );
    getIt.registerLazySingleton<GetCategoriesUsecase>(
      () => GetCategoriesUsecase(repository: getIt()),
    );
    getIt.registerLazySingleton<GetCategoryProductsUsecase>(
      () => GetCategoryProductsUsecase(repository: getIt()),
    );
    getIt.registerLazySingleton<GetSearchProductsUsecase>(
      () => GetSearchProductsUsecase(repository: getIt()),
    );
  }
}
