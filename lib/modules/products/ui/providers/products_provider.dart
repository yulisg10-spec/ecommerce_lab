import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/core.dart';
import '../../product_module.dart';

final Provider<GetProductsByCategoryUsecase>
getProductsByCategoryUsecaseProvider = Provider<GetProductsByCategoryUsecase>(
  (Ref ref) => GetIt.instance<GetProductsByCategoryUsecase>(),
);

final AsyncNotifierProviderFamily<ProductsNotifier, List<ProductEntity>, String>
productsProvider = AsyncNotifierProvider.autoDispose
    .family<ProductsNotifier, List<ProductEntity>, String>(
      ProductsNotifier.new,
      retry: (int retryCount, Object error) => null,
    );

class ProductsNotifier extends AsyncNotifier<List<ProductEntity>> {
  ProductsNotifier(this.categoryId);
  final String categoryId;

  @override
  FutureOr<List<ProductEntity>> build() async {
    final GetProductsByCategoryUsecase usecase = ref.read(
      getProductsByCategoryUsecaseProvider,
    );
    final ApiResult<List<ProductEntity>> result = await usecase.call(
      categoryId,
    );

    return result.when(
      success: (List<ProductEntity> products) => products,
      failure: (AppError error) => throw error.message,
    );
  }
}
