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
  group('CartNotifier', () {
    test('estado inicial es un carrito vacío', () {
      final ProviderContainer container = makeContainer();
      final CartEntity cart = container.read(cartProvider);
      expect(cart.isEmpty, isTrue);
      expect(cart.items, isEmpty);
    });

    test('addItem agrega un nuevo producto al carrito', () {
      final ProviderContainer container = makeContainer();
      container.read(cartProvider.notifier).addItem(FakeCartData.fakeProduct(), 2);

      final CartEntity cart = container.read(cartProvider);
      expect(cart.items.length, 1);
      expect(cart.items.first.productId, 'p1');
      expect(cart.items.first.quantity, 2);
    });

    test('addItem incrementa la cantidad si el producto ya existe', () {
      final ProviderContainer container = makeContainer();
      final CartNotifier notifier = container.read(cartProvider.notifier);
      notifier.addItem(FakeCartData.fakeProduct(), 1);
      notifier.addItem(FakeCartData.fakeProduct(), 3);

      final CartEntity cart = container.read(cartProvider);
      expect(cart.items.length, 1);
      expect(cart.items.first.quantity, 4);
    });

    test('addItem agrega productos distintos como items separados', () {
      final ProviderContainer container = makeContainer();
      final CartNotifier notifier = container.read(cartProvider.notifier);
      notifier.addItem(FakeCartData.fakeProduct(id: 'p1'), 1);
      notifier.addItem(FakeCartData.fakeProduct(id: 'p2', name: 'Other'), 2);

      expect(container.read(cartProvider).items.length, 2);
    });

    test('removeItem elimina el producto por id', () {
      final ProviderContainer container = makeContainer();
      final CartNotifier notifier = container.read(cartProvider.notifier);
      notifier.addItem(FakeCartData.fakeProduct(id: 'p1'), 1);
      notifier.addItem(FakeCartData.fakeProduct(id: 'p2', name: 'Other'), 1);
      notifier.removeItem('p1');

      final CartEntity cart = container.read(cartProvider);
      expect(cart.items.length, 1);
      expect(cart.items.first.productId, 'p2');
    });

    test('updateQuantity actualiza la cantidad del item', () {
      final ProviderContainer container = makeContainer();
      final CartNotifier notifier = container.read(cartProvider.notifier);
      notifier.addItem(FakeCartData.fakeProduct(), 1);
      notifier.updateQuantity('p1', 5);

      expect(container.read(cartProvider).items.first.quantity, 5);
    });

    test('updateQuantity con cantidad <= 0 elimina el item', () {
      final ProviderContainer container = makeContainer();
      final CartNotifier notifier = container.read(cartProvider.notifier);
      notifier.addItem(FakeCartData.fakeProduct(), 2);
      notifier.updateQuantity('p1', 0);

      expect(container.read(cartProvider).isEmpty, isTrue);
    });

    test('clear vacía el carrito', () {
      final ProviderContainer container = makeContainer();
      final CartNotifier notifier = container.read(cartProvider.notifier);
      notifier.addItem(FakeCartData.fakeProduct(), 3);
      notifier.clear();

      expect(container.read(cartProvider).isEmpty, isTrue);
    });

    test('total se calcula correctamente tras agregar items', () {
      final ProviderContainer container = makeContainer();
      final CartNotifier notifier = container.read(cartProvider.notifier);
      notifier.addItem(FakeCartData.fakeProduct(price: 10.0), 2);
      notifier.addItem(FakeCartData.fakeProduct(id: 'p2', name: 'B', price: 5.0), 4);

      expect(container.read(cartProvider).total, 40.0); // (10*2) + (5*4)
    });
  });
}
