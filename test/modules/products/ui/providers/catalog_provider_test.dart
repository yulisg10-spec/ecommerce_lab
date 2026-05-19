import 'package:ecommerce_lab/core/core.dart';
import 'package:ecommerce_lab/modules/products/product_module.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../domain/mocks/mock_get_categories_usecase.dart';
import '../../domain/mocks/mock_get_products_by_category_usecase.dart';
import '../helpers/fake_catalog_data.dart';

void main() {
  late MockGetCategoriesUsecase mockGetCategories;
  late MockGetProductsByCategoryUsecase mockGetProductsByCategory;

  setUp(() {
    mockGetCategories = MockGetCategoriesUsecase();
    mockGetProductsByCategory = MockGetProductsByCategoryUsecase();
  });

  ProviderContainer makeContainer() {
    return ProviderContainer.test(
      overrides: <Override>[
        getCategoriesUsecaseProvider.overrideWithValue(mockGetCategories),
        getProductsByCategoryUsecaseProvider.overrideWithValue(
          mockGetProductsByCategory,
        ),
      ],
    );
  }

  group('CatalogNotifier', () {
    group('Build', () {
      test('Carga categorías y productos de la primera categoría', () async {
        final List<CategoryEntity> categories =
            FakeCatalogData.fakeCategoriesEntity();

        final List<ProductEntity> products =
            FakeCatalogData.fakeProductsEntity();

        when(
          () => mockGetCategories.call(),
        ).thenAnswer((_) async => Success<List<CategoryEntity>>(categories));
        when(
          () => mockGetProductsByCategory.call(any()),
        ).thenAnswer((_) async => Success<List<ProductEntity>>(products));

        final ProviderContainer container = makeContainer();

        final CatalogEntity catalog = await container.read(
          catalogProvider.future,
        );

        expect(catalog.categories, categories);
        expect(catalog.selectedId, categories.first.id);
        expect(catalog.products, products);
      });

      test('Retorna lista vacía de productos si no hay categorías', () async {
        when(() => mockGetCategories.call()).thenAnswer(
          (_) async => const Success<List<CategoryEntity>>(<CategoryEntity>[]),
        );

        final ProviderContainer container = makeContainer();

        final CatalogEntity catalog = await container.read(
          catalogProvider.future,
        );

        expect(catalog.categories, isEmpty);
        expect(catalog.selectedId, isNull);
        expect(catalog.products, isEmpty);
      });

      test(
        'Lanza error desde catalogProvider cuando la consulta de categorías falla',
        () async {
          when(() => mockGetCategories.call()).thenAnswer(
            (_) async => const Failure<List<CategoryEntity>>(
              NetworkError('Sin conexión'),
            ),
          );

          final ProviderContainer container = makeContainer();

          await expectLater(
            container.read(catalogProvider.future),
            throwsA(equals('Sin conexión')),
          );

          expect(
            container.read(catalogProvider),
            isA<AsyncError<CatalogEntity>>(),
          );
        },
      );

      test(
        'Lanza error desde catalogProvider cuando la consulta de productos falla',
        () async {
          final List<CategoryEntity> categories =
              FakeCatalogData.fakeCategoriesEntity();

          when(
            () => mockGetCategories.call(),
          ).thenAnswer((_) async => Success<List<CategoryEntity>>(categories));
          when(() => mockGetProductsByCategory.call(any())).thenAnswer(
            (_) async => const Failure<List<ProductEntity>>(
              NetworkError('Error al cargar productos'),
            ),
          );

          final ProviderContainer container = makeContainer();

          await expectLater(
            container.read(catalogProvider.future),
            throwsA(equals('Error al cargar productos')),
          );

          expect(
            container.read(catalogProvider),
            isA<AsyncError<CatalogEntity>>(),
          );
        },
      );
    });

    group('selectCategory', () {
      test(
        'Actualiza selectedId y productos al seleccionar otra categoría',
        () async {
          final List<CategoryEntity> categories =
              FakeCatalogData.fakeCategoriesEntity();

          final List<ProductEntity> productsA =
              FakeCatalogData.fakeProductsEntity();

          final List<ProductEntity> productsB =
              FakeCatalogData.fakeProductsEntity();

          when(
            () => mockGetCategories.call(),
          ).thenAnswer((_) async => Success<List<CategoryEntity>>(categories));
          when(
            () => mockGetProductsByCategory.call(categories.first.id),
          ).thenAnswer((_) async => Success<List<ProductEntity>>(productsA));
          when(
            () => mockGetProductsByCategory.call(categories.last.id),
          ).thenAnswer((_) async => Success<List<ProductEntity>>(productsB));

          final ProviderContainer container = makeContainer();

          await container.read(catalogProvider.future);

          await container
              .read(catalogProvider.notifier)
              .selectCategory(categories.last.id);

          final CatalogEntity catalog = container.read(catalogProvider).value!;
          expect(catalog.selectedId, categories.last.id);
          expect(catalog.products, productsB);
        },
      );

      test(
        'Retorna sin lanzar excepción cuando categorías está en estado de error',
        () async {
          when(() => mockGetCategories.call()).thenAnswer(
            (_) async =>
                const Failure<List<CategoryEntity>>(NetworkError('Error')),
          );

          final ProviderContainer container = makeContainer();

          //Lleva al estado de error cuando no tiene categorías,
          //para probar el guard `if (catalog == null) return`
          await expectLater(
            container.read(catalogProvider.future),
            throwsA(anything),
          );

          await expectLater(
            container.read(catalogProvider.notifier).selectCategory('cat-1'),
            completes,
          );

          expect(
            container.read(catalogProvider),
            isA<AsyncError<CatalogEntity>>(),
          );
        },
      );
    });
  });
}
