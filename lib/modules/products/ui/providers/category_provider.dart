import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/core.dart';
import '../../product_module.dart';

final Provider<GetCategoriesUsecase> getCategoriesUsecaseProvider =
    Provider<GetCategoriesUsecase>(
      (Ref ref) => GetIt.instance<GetCategoriesUsecase>(),
    );

final FutureProvider<ApiResult<List<CategoryEntity>>> categoryProvider =
    FutureProvider<ApiResult<List<CategoryEntity>>>((Ref ref) async {
      final GetCategoriesUsecase usecase = ref.read(
        getCategoriesUsecaseProvider,
      );

      return usecase.call();
    });
