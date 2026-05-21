import 'package:ecommerce_lab/modules/products/domain/entities/product_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/cart_entity.dart';
import '../../domain/entities/cart_item_entity.dart';

final NotifierProvider<CartNotifier, CartEntity> cartProvider =
    NotifierProvider<CartNotifier, CartEntity>(CartNotifier.new);

class CartNotifier extends Notifier<CartEntity> {
  @override
  CartEntity build() => const CartEntity(items: <CartItemEntity>[]);

  void addItem(ProductEntity product, int quantity) {
    final List<CartItemEntity> items = List<CartItemEntity>.from(state.items);
    final int index =
        items.indexWhere((CartItemEntity i) => i.productId == product.id);

    if (index >= 0) {
      items[index] = items[index].copyWith(
        quantity: items[index].quantity + quantity,
      );
    } else {
      items.add(
        CartItemEntity(
          productId: product.id,
          name: product.name,
          imagePath: product.imagePath,
          price: product.price,
          quantity: quantity,
        ),
      );
    }
    state = CartEntity(items: items);
  }

  void removeItem(String productId) {
    state = CartEntity(
      items: state.items
          .where((CartItemEntity i) => i.productId != productId)
          .toList(),
    );
  }

  void updateQuantity(String productId, int quantity) {
    if (quantity <= 0) {
      removeItem(productId);
      return;
    }
    final List<CartItemEntity> updated = state.items.map((CartItemEntity i) {
      return i.productId == productId ? i.copyWith(quantity: quantity) : i;
    }).toList();
    state = CartEntity(items: updated);
  }

  void clear() => state = const CartEntity(items: <CartItemEntity>[]);
}
