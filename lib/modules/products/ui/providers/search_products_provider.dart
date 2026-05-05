import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/core.dart';
import '../../product_module.dart';

final Provider<SearchProductsUsecase> searchProductsUsecaseProvider =
    Provider<SearchProductsUsecase>(
      (Ref ref) => GetIt.instance<SearchProductsUsecase>(),
    );

final AsyncNotifierProviderFamily<
  SearchProductsNotifier,
  List<ProductEntity>,
  String
>
searchProductsProvider = AsyncNotifierProvider.autoDispose
    .family<SearchProductsNotifier, List<ProductEntity>, String>(
      SearchProductsNotifier.new,
    );

class SearchProductsNotifier extends AsyncNotifier<List<ProductEntity>> {
  SearchProductsNotifier(this.query);
  final String query;

  @override
  FutureOr<List<ProductEntity>> build() {
    return _searchProducts(query);
  }

  FutureOr<List<ProductEntity>> _searchProducts(String query) async {
    final SearchProductsUsecase usecase = ref.read(
      searchProductsUsecaseProvider,
    );
    final ApiResult<List<ProductEntity>> result = await usecase.call(query);

    return result.when(
      success: (List<ProductEntity> products) => products,
      failure: (AppError error) => throw error.message,
    );
  }
}
