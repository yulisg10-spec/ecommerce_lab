import 'package:ecommerce_lab/modules/products/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/fake_cart_data.dart';
import '../helpers/fake_cart_router.dart';

Widget buildSubject(ProductEntity product) {
  return ProviderScope(
    child: MaterialApp.router(
      routerConfig: FakeCartRouter.build(product),
    ),
  );
}

void main() {
  final ProductEntity product = FakeCartData.fakeProduct(
    id: 'p1',
    name: 'Blue Sneakers',
    price: 99.99,
    description: 'Great sneakers for everyday use.',
  );

  group('ProductDetailScreen', () {
    testWidgets('muestra el nombre del producto', (WidgetTester tester) async {
      await tester.pumpWidget(buildSubject(product));
      await tester.pump();

      expect(find.text('Blue Sneakers'), findsOneWidget);
    });

    testWidgets('muestra el precio del producto', (WidgetTester tester) async {
      await tester.pumpWidget(buildSubject(product));
      await tester.pump();

      expect(find.textContaining('99.99'), findsWidgets);
    });

    testWidgets('muestra la descripción del producto', (WidgetTester tester) async {
      await tester.pumpWidget(buildSubject(product));
      await tester.pump();

      expect(find.text('Great sneakers for everyday use.'), findsOneWidget);
    });

    testWidgets('muestra el título en el AppBar', (WidgetTester tester) async {
      await tester.pumpWidget(buildSubject(product));
      await tester.pump();

      expect(find.text('Detalle del producto'), findsOneWidget);
    });

    testWidgets('muestra el botón Agregar al Carrito', (WidgetTester tester) async {
      await tester.pumpWidget(buildSubject(product));
      await tester.pump();

      expect(find.text('Agregar al Carrito'), findsOneWidget);
    });

    testWidgets('cantidad inicial es 1', (WidgetTester tester) async {
      await tester.pumpWidget(buildSubject(product));
      await tester.pump();

      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('incrementa la cantidad al tocar +', (WidgetTester tester) async {
      await tester.pumpWidget(buildSubject(product));
      await tester.pump();

      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      expect(find.text('2'), findsOneWidget);
    });

    testWidgets('no decrementa por debajo de 1', (WidgetTester tester) async {
      await tester.pumpWidget(buildSubject(product));
      await tester.pump();

      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();

      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('agrega al carrito y muestra SnackBar', (WidgetTester tester) async {
      await tester.pumpWidget(buildSubject(product));
      await tester.pump();

      await tester.tap(find.text('Agregar al Carrito'));
      await tester.pump();

      expect(find.textContaining('Blue Sneakers'), findsWidgets);
    });
  });
}
