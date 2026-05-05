import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../product_module.dart';

class ProductsScreen extends ConsumerWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<CatalogEntity> catalogState = ref.watch(catalogProvider);

    return Scaffold(
      backgroundColor: Colors.indigo[50],
      body: SafeArea(
        child: Column(
          children: <Widget>[
            HeaderSearchFieldWidget(
              readOnly: true,
              canRequestFocus: true,
              onTap: () {
                context.push('/search-products');
              },
            ),
            Expanded(
              child: catalogState.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (Object error, StackTrace stackTrace) {
                  return Center(child: Text('Error: $error'));
                },
                data: (CatalogEntity catalog) {
                  return CustomScrollView(
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: 100,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.only(
                              top: 24.0,
                              left: 16.0,
                              right: 16.0,
                            ),
                            itemCount: catalog.categories.length,
                            separatorBuilder:
                                (BuildContext context, int index) {
                                  return const SizedBox(width: 24);
                                },
                            itemBuilder: (BuildContext context, int index) {
                              final CategoryEntity category =
                                  catalog.categories[index];

                              return GestureDetector(
                                onTap: () {
                                  ref
                                      .read(catalogProvider.notifier)
                                      .selectCategory(category.id);
                                },
                                child: CategoryIconWidget(
                                  name: category.name,
                                  iconPath: category.iconPath,
                                  isSelected: catalog.selectedId == category.id,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 24.0,
                          horizontal: 16.0,
                        ),
                        sliver: SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16,
                                childAspectRatio: 0.9,
                              ),
                          delegate: SliverChildBuilderDelegate(
                            childCount: catalog.products.length,
                            (BuildContext context, int index) {
                              final ProductEntity product =
                                  catalog.products[index];

                              return CardProductWidget(
                                name: product.name,
                                price: product.price.toString(),
                                imagePath: product.imagePath,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
