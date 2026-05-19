import 'package:ecommerce_lab/core/core.dart';
import 'package:ecommerce_lab/modules/products/product_module.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../domain/mocks/mock_search_products_usecase.dart';
import '../helpers/fake_catalog_data.dart';

void main() {
  late MockSearchProductsUsecase mockSearchProducts;

  setUp(() {
    mockSearchProducts = MockSearchProductsUsecase();
  });

  ProviderContainer makeContainer() {
    return ProviderContainer.test(
      overrides: <Override>[
        searchProductsUsecaseProvider.overrideWithValue(mockSearchProducts),
      ],
    );
  }

  group('SearchProductsNotifier', () {
    group('build', () {
      test('Retorna productos cuando la búsqueda es exitosa', () async {
        final List<ProductEntity> products =
            FakeCatalogData.fakeProductsEntity();

        when(
          () => mockSearchProducts.call('Camisa'),
        ).thenAnswer((_) async => Success<List<ProductEntity>>(products));

        final ProviderContainer container = makeContainer();

        final List<ProductEntity> result = await container.read(
          searchProductsProvider('Camisa').future,
        );

        expect(result, products);
      });

      test('Retorna lista vacía cuando no hay resultados', () async {
        when(() => mockSearchProducts.call('xyz')).thenAnswer(
          (_) async => const Success<List<ProductEntity>>(<ProductEntity>[]),
        );

        final ProviderContainer container = makeContainer();

        final List<ProductEntity> result = await container.read(
          searchProductsProvider('xyz').future,
        );

        expect(result, isEmpty);
      });

      test('Lanza error cuando la búsqueda falla', () async {
        when(() => mockSearchProducts.call('Camisa')).thenAnswer(
          (_) async =>
              const Failure<List<ProductEntity>>(NetworkError('Sin conexión')),
        );

        final ProviderContainer container = makeContainer();

        await expectLater(
          container.read(searchProductsProvider('Camisa').future),
          throwsA(equals('Sin conexión')),
        );

        expect(
          container.read(searchProductsProvider('Camisa')),
          isA<AsyncError<List<ProductEntity>>>(),
        );
      });

      test('Providers con queries distintas son independientes', () async {
        when(() => mockSearchProducts.call(any())).thenAnswer(
          (_) async => const Success<List<ProductEntity>>(<ProductEntity>[]),
        );

        final ProviderContainer container = makeContainer();

        final ProviderSubscription<AsyncValue<List<ProductEntity>>>
            subscriptionA = container.listen(
          searchProductsProvider('Camisa'),
          (_, __) {},
        );
        final ProviderSubscription<AsyncValue<List<ProductEntity>>>
            subscriptionB = container.listen(
          searchProductsProvider('Pantalón'),
          (_, __) {},
        );

        await container.read(searchProductsProvider('Camisa').future);
        await container.read(searchProductsProvider('Pantalón').future);

        verify(() => mockSearchProducts.call('Camisa')).called(1);
        verify(() => mockSearchProducts.call('Pantalón')).called(1);

        subscriptionA.close();
        subscriptionB.close();
      });
    });
  });
}
