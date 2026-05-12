import 'dart:async';

import 'package:ecommerce_lab/core/core.dart';
import 'package:ecommerce_lab/modules/products/product_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/fake_catalog_data.dart';
import '../helpers/fake_products_router.dart';
import '../../domain/mocks/mock_get_categories_usecase.dart';
import '../../domain/mocks/mock_get_products_by_category_usecase.dart';
import '../../domain/mocks/mock_search_products_usecase.dart';

void main() {
  late MockGetCategoriesUsecase mockGetCategories;
  late MockGetProductsByCategoryUsecase mockGetProductsByCategory;
  late MockSearchProductsUsecase mockSearchProducts;

  setUp(() {
    mockGetCategories = MockGetCategoriesUsecase();
    mockGetProductsByCategory = MockGetProductsByCategoryUsecase();
    mockSearchProducts = MockSearchProductsUsecase();
  });

  Widget buildSubject() {
    return ProviderScope(
      overrides: <Override>[
        getCategoriesUsecaseProvider.overrideWithValue(mockGetCategories),
        getProductsByCategoryUsecaseProvider.overrideWithValue(
          mockGetProductsByCategory,
        ),
        searchProductsUsecaseProvider.overrideWithValue(mockSearchProducts),
      ],
      child: MaterialApp.router(routerConfig: FakeProductsRouter.build()),
    );
  }

  group('ProductsScreen', () {
    testWidgets('Muestra CircularProgressIndicator mientras carga', (
      WidgetTester tester,
    ) async {
      final Completer<ApiResult<List<CategoryEntity>>> completer =
          Completer<ApiResult<List<CategoryEntity>>>();

      when(() => mockGetCategories.call()).thenAnswer((_) async {
        return completer.future; // Future que nunca resuelve en este test
      });

      await tester.pumpWidget(buildSubject());
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      completer.complete(
        const Success<List<CategoryEntity>>(<CategoryEntity>[]),
      );
      await tester.pumpAndSettle();
    });

    testWidgets('Muestra error cuando el usecase de categorías falla', (
      WidgetTester tester,
    ) async {
      when(() => mockGetCategories.call()).thenAnswer(
        (_) async =>
            const Failure<List<CategoryEntity>>(NetworkError('Error de red')),
      );

      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      expect(find.textContaining('Error:'), findsOneWidget);
    });

    testWidgets('Muestra categorías y productos cuando carga exitosamente', (
      WidgetTester tester,
    ) async {
      final List<CategoryEntity> categories =
          FakeCatalogData.fakeCategoriesEntity();

      final List<ProductEntity> products = FakeCatalogData.fakeProductsEntity();

      when(
        () => mockGetCategories.call(),
      ).thenAnswer((_) async => Success<List<CategoryEntity>>(categories));
      when(
        () => mockGetProductsByCategory.call('cat-1'),
      ).thenAnswer((_) async => Success<List<ProductEntity>>(products));

      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      expect(find.text('Ropa'), findsOneWidget);
      expect(find.text('Camisa'), findsOneWidget);
    });

    testWidgets(
      'Navega a SearchProductsScreen al hacer tap en el campo de búsqueda',
      (WidgetTester tester) async {
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

        await tester.pumpWidget(buildSubject());
        await tester.pumpAndSettle();

        await tester.tap(find.byType(TextFormField));
        await tester.pumpAndSettle();

        expect(find.byType(SearchProductsScreen), findsOneWidget);
      },
    );

    testWidgets('Carga productos de otra categoría al hacer tap en ella', (
      WidgetTester tester,
    ) async {
      final List<CategoryEntity> categories = <CategoryEntity>[
        FakeCatalogData.fakeCategoryEntity(id: 'cat-1', name: 'Ropa'),
        FakeCatalogData.fakeCategoryEntity(id: 'cat-2', name: 'Hogar'),
      ];
      final List<ProductEntity> productsCat1 = <ProductEntity>[
        FakeCatalogData.fakeProductEntity(name: 'Camisa'),
      ];
      final List<ProductEntity> productsCat2 = <ProductEntity>[
        FakeCatalogData.fakeProductEntity(id: '2', name: 'Sofá'),
      ];

      when(
        () => mockGetCategories.call(),
      ).thenAnswer((_) async => Success<List<CategoryEntity>>(categories));
      when(
        () => mockGetProductsByCategory.call('cat-1'),
      ).thenAnswer((_) async => Success<List<ProductEntity>>(productsCat1));
      when(
        () => mockGetProductsByCategory.call('cat-2'),
      ).thenAnswer((_) async => Success<List<ProductEntity>>(productsCat2));

      await tester.pumpWidget(buildSubject());
      await tester.pumpAndSettle();

      expect(
        find.descendant(
          of: find.byType(CustomScrollView),
          matching: find.text('Camisa'),
        ),
        findsOneWidget,
      );

      await tester.tap(find.text('Hogar'));
      await tester.pumpAndSettle();

      expect(
        find.descendant(
          of: find.byType(CustomScrollView),
          matching: find.text('Sofá'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(CustomScrollView),
          matching: find.text('Camisa'),
        ),
        findsNothing,
      );
    });
  });
}
