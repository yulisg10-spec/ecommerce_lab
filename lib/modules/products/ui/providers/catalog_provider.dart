import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../product_module.dart';

final AsyncNotifierProvider<CatalogNotifier, CatalogEntity> catalogProvider =
    AsyncNotifierProvider<CatalogNotifier, CatalogEntity>(
  CatalogNotifier.new,
  retry: (int retryCount, Object error) => null,
);

class CatalogNotifier extends AsyncNotifier<CatalogEntity> {
  @override
  FutureOr<CatalogEntity> build() async {
    final List<CategoryEntity> categories = await ref.watch(
      categoryProvider.future,
    );

    final String? selectedId =
        categories.isNotEmpty ? categories.first.id : null;

    final List<ProductEntity> products = selectedId != null
        ? await ref.watch(productsProvider(selectedId).future)
        : <ProductEntity>[];

    return CatalogEntity(
      categories: categories,
      selectedId: selectedId,
      products: products,
    );
  }

  Future<void> selectCategory(String id) async {
    final CatalogEntity? catalog = state.value;
    if (catalog == null) return;

    state = const AsyncLoading<CatalogEntity>();

    final List<ProductEntity> products = await ref.read(
      productsProvider(id).future,
    );

    state = AsyncData<CatalogEntity>(
      CatalogEntity(
        categories: catalog.categories,
        selectedId: id,
        products: products,
      ),
    );
  }
}
