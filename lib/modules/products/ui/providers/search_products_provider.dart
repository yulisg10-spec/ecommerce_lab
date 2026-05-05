import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/core.dart';
import '../../product_module.dart';

final NotifierProvider<SearchQueryNotifier, String> searchQueryProvider =
    NotifierProvider.autoDispose<SearchQueryNotifier, String>(
      SearchQueryNotifier.new,
    );

class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void setQuery(String value) => state = value;
}

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
  FutureOr<List<ProductEntity>> build() async {
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
