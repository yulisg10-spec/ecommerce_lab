import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../cart/cart_module.dart';
import '../../product_module.dart';

class SearchProductsScreen extends ConsumerStatefulWidget {
  const SearchProductsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SearchProductsScreenState();
}

class _SearchProductsScreenState extends ConsumerState<SearchProductsScreen> {
  late final TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String query = ref.watch(searchQueryProvider);
    final AsyncValue<List<ProductEntity>> searchProductsState = ref.watch(
      searchProductsProvider(query),
    );
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      body: SafeArea(
        child: Column(
          children: <Widget>[
            HeaderSearchFieldWidget(
              autofocus: true,
              showBack: true,
              controller: textController,
              onFieldSubmitted: (String value) {
                ref.read(searchQueryProvider.notifier).setQuery(value);
              },
              onSuffixIconPressed: () {
                ref
                    .read(searchQueryProvider.notifier)
                    .setQuery(textController.text);
              },
            ),
            const SizedBox(height: 24.0),
            if (query.isNotEmpty)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: searchProductsState.when(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (Object error, StackTrace stackTrace) {
                      return Center(child: Text('Error: $error'));
                    },
                    data: (List<ProductEntity> products) {
                      return GridView.builder(
                        itemCount: products.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.9,
                        ),
                        itemBuilder: ((BuildContext context, int index) {
                          final ProductEntity product = products[index];

                          return CardProductWidget(
                            name: product.name,
                            price: product.price.toString(),
                            imagePath: product.imagePath,
                            onTap: () => context.push(
                              CartRoutes.productDetail,
                              extra: product,
                            ),
                          );
                        }),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
