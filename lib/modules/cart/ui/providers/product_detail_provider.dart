import 'package:ecommerce_lab/modules/products/domain/entities/product_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'cart_provider.dart';

final NotifierProvider<ProductDetailNotifier, int> productDetailProvider =
    NotifierProvider.autoDispose<ProductDetailNotifier, int>(
  ProductDetailNotifier.new,
);

class ProductDetailNotifier extends Notifier<int> {
  @override
  int build() => 1;

  void increment() => state++;

  void decrement() {
    if (state > 1) state--;
  }

  void addToCart(ProductEntity product) {
    ref.read(cartProvider.notifier).addItem(product, state);
  }
}
