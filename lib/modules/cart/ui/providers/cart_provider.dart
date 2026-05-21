import 'package:ecommerce_lab/modules/products/domain/entities/product_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/cart_entity.dart';
import '../../domain/entities/cart_item_entity.dart';

final NotifierProvider<CartNotifier, CartEntity> cartProvider =
    NotifierProvider<CartNotifier, CartEntity>(CartNotifier.new);

class CartNotifier extends Notifier<CartEntity> {
  // TODO: Replace with Supabase REST call to fetch user's cart items
  static const List<CartItemEntity> _mockItems = <CartItemEntity>[
    CartItemEntity(
      productId: 'mock-1',
      name: 'Minimalist Smartwatch Pro',
      imagePath:
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=300&h=300&fit=crop',
      price: 199.00,
      quantity: 1,
    ),
    CartItemEntity(
      productId: 'mock-2',
      name: 'Aura Studio Headphones',
      imagePath:
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=300&h=300&fit=crop',
      price: 89.00,
      quantity: 1,
    ),
    CartItemEntity(
      productId: 'mock-3',
      name: 'Premium Running Sneakers',
      imagePath:
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=300&h=300&fit=crop',
      price: 120.00,
      quantity: 1,
    ),
  ];

  @override
  CartEntity build() => const CartEntity(items: _mockItems);

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
