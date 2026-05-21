import 'package:ecommerce_lab/modules/cart/cart_module.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/fake_cart_data.dart';

ProviderContainer makeContainer() {
  final ProviderContainer container = ProviderContainer();
  addTearDown(container.dispose);
  return container;
}

void main() {
  group('ProductDetailNotifier', () {
    test('cantidad inicial es 1', () {
      final ProviderContainer container = makeContainer();
      expect(container.read(productDetailProvider), 1);
    });

    test('increment aumenta la cantidad en 1', () {
      final ProviderContainer container = makeContainer();
      container.read(productDetailProvider.notifier).increment();
      expect(container.read(productDetailProvider), 2);
    });

    test('decrement disminuye la cantidad en 1', () {
      final ProviderContainer container = makeContainer();
      container.read(productDetailProvider.notifier).increment();
      container.read(productDetailProvider.notifier).decrement();
      expect(container.read(productDetailProvider), 1);
    });

    test('decrement no baja por debajo de 1', () {
      final ProviderContainer container = makeContainer();
      container.read(productDetailProvider.notifier).decrement();
      expect(container.read(productDetailProvider), 1);
    });

    test('addToCart delega al cartProvider con la cantidad correcta', () {
      final ProviderContainer container = makeContainer();
      final ProductDetailNotifier notifier =
          container.read(productDetailProvider.notifier);

      notifier.increment();
      notifier.increment(); // quantity = 3
      notifier.addToCart(FakeCartData.fakeProduct(id: 'p1', price: 10.0));

      final CartEntity cart = container.read(cartProvider);
      expect(cart.items.length, 1);
      expect(cart.items.first.quantity, 3);
      expect(cart.items.first.productId, 'p1');
    });

    test('addToCart con cantidad 1 agrega correctamente al carrito', () {
      final ProviderContainer container = makeContainer();
      container
          .read(productDetailProvider.notifier)
          .addToCart(FakeCartData.fakeProduct());

      expect(container.read(cartProvider).items.first.quantity, 1);
    });
  });
}
