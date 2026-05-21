import 'package:ecommerce_lab/modules/cart/cart_module.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const CartItemEntity item1 = CartItemEntity(
    productId: '1',
    name: 'Product A',
    imagePath: 'a.png',
    price: 10.0,
    quantity: 2,
  );

  const CartItemEntity item2 = CartItemEntity(
    productId: '2',
    name: 'Product B',
    imagePath: 'b.png',
    price: 5.0,
    quantity: 3,
  );

  group('CartEntity', () {
    test('isEmpty retorna true cuando no hay items', () {
      const CartEntity cart = CartEntity(items: <CartItemEntity>[]);
      expect(cart.isEmpty, isTrue);
    });

    test('isEmpty retorna false cuando hay items', () {
      const CartEntity cart = CartEntity(items: <CartItemEntity>[item1]);
      expect(cart.isEmpty, isFalse);
    });

    test('itemCount suma las cantidades de todos los items', () {
      const CartEntity cart = CartEntity(items: <CartItemEntity>[item1, item2]);
      expect(cart.itemCount, 5); // 2 + 3
    });

    test('total calcula price * quantity por cada item', () {
      const CartEntity cart = CartEntity(items: <CartItemEntity>[item1, item2]);
      expect(cart.total, 35.0); // (10 * 2) + (5 * 3)
    });

    test('total es 0 cuando el carrito está vacío', () {
      const CartEntity cart = CartEntity(items: <CartItemEntity>[]);
      expect(cart.total, 0);
    });
  });

  group('CartItemEntity', () {
    test('copyWith actualiza la cantidad', () {
      const CartItemEntity updated = CartItemEntity(
        productId: '1',
        name: 'Product A',
        imagePath: 'a.png',
        price: 10.0,
        quantity: 5,
      );
      expect(item1.copyWith(quantity: 5), equals(updated));
    });

    test('copyWith sin argumentos conserva los valores originales', () {
      expect(item1.copyWith(), equals(item1));
    });
  });
}
