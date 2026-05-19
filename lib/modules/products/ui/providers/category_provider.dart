import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/core.dart';
import '../../product_module.dart';

final Provider<GetCategoriesUsecase> getCategoriesUsecaseProvider =
    Provider<GetCategoriesUsecase>(
  (Ref ref) => GetIt.instance<GetCategoriesUsecase>(),
  retry: (int retryCount, Object error) => null,
);

final FutureProvider<List<CategoryEntity>> categoryProvider =
    FutureProvider<List<CategoryEntity>>(
  (Ref ref) async {
    final GetCategoriesUsecase usecase = ref.read(
      getCategoriesUsecaseProvider,
    );

    final ApiResult<List<CategoryEntity>> result = await usecase.call();

    return result.when(
      success: (List<CategoryEntity> categories) => categories,
      failure: (AppError error) => throw error.message,
    );
  },
  retry: (int retryCount, Object error) => null,
);
