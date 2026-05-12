import 'dart:async';

import 'package:ecommerce_lab/core/core.dart';
import 'package:ecommerce_lab/modules/products/product_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../domain/mocks/mock_get_categories_usecase.dart';
import '../../domain/mocks/mock_get_products_by_category_usecase.dart';
import '../../domain/mocks/mock_search_products_usecase.dart';
import '../helpers/fake_catalog_data.dart';
import '../helpers/fake_products_router.dart';

void main() {
  late MockGetCategoriesUsecase mockGetCategories;
  late MockGetProductsByCategoryUsecase mockGetProductsByCategory;
  late MockSearchProductsUsecase mockSearchProducts;

  setUp(() {
    mockGetCategories = MockGetCategoriesUsecase();
    mockGetProductsByCategory = MockGetProductsByCategoryUsecase();
    mockSearchProducts = MockSearchProductsUsecase();
  });

  // Para tests de lógica de UI — sin router
  Widget buildSubject() {
    return ProviderScope(
      overrides: <Override>[
        searchProductsUsecaseProvider.overrideWithValue(mockSearchProducts),
      ],
      child: const MaterialApp(home: SearchProductsScreen()),
    );
  }

  // Para tests de navegación — con router desde /
  Widget buildSubjectWithRouter() {
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

  group('SearchProductsScreen', () {
    group('Lógica de UI', () {
      testWidgets(
        'Estado inicial: no muestra resultados cuando query está vacío',
        (WidgetTester tester) async {
          await tester.pumpWidget(buildSubject());
          await tester.pump();

          expect(find.byType(CircularProgressIndicator), findsNothing);
          expect(find.byType(GridView), findsNothing);
          expect(find.byType(TextFormField), findsOneWidget);
        },
      );

      testWidgets('Muestra CircularProgressIndicator mientras busca', (
        WidgetTester tester,
      ) async {
        final Completer<ApiResult<List<ProductEntity>>> completer =
            Completer<ApiResult<List<ProductEntity>>>();

        when(
          () => mockSearchProducts.call('Camisa'),
        ).thenAnswer((_) => completer.future);

        await tester.pumpWidget(buildSubject());
        await tester.pump();

        await tester.enterText(find.byType(TextFormField), 'Camisa');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pump();

        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        completer.complete(
          const Success<List<ProductEntity>>(<ProductEntity>[]),
        );
        await tester.pumpAndSettle();
      });

      testWidgets('Muestra productos cuando la búsqueda es exitosa', (
        WidgetTester tester,
      ) async {
        final List<ProductEntity> products =
            FakeCatalogData.fakeProductsEntity();

        when(
          () => mockSearchProducts.call('Camisa'),
        ).thenAnswer((_) async => Success<List<ProductEntity>>(products));

        await tester.pumpWidget(buildSubject());
        await tester.pump();

        await tester.enterText(find.byType(TextFormField), 'Camisa');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle();

        expect(
          find.descendant(
            of: find.byType(GridView),
            matching: find.text('Camisa'),
          ),
          findsOneWidget,
        );
      });

      testWidgets('Muestra mensaje de error cuando la búsqueda falla', (
        WidgetTester tester,
      ) async {
        when(() => mockSearchProducts.call('Camisa')).thenAnswer(
          (_) async =>
              const Failure<List<ProductEntity>>(NetworkError('Error de red')),
        );

        await tester.pumpWidget(buildSubject());
        await tester.pump();

        await tester.enterText(find.byType(TextFormField), 'Camisa');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle();

        expect(find.textContaining('Error'), findsOneWidget);
      });
    });
  });

  group('Navegación', () {
    testWidgets('Busca productos al hacer tap en el ícono search del input', (
      WidgetTester tester,
    ) async {
      final List<ProductEntity> products = FakeCatalogData.fakeProductsEntity();

      when(
        () => mockSearchProducts.call('Camisa'),
      ).thenAnswer((_) async => Success<List<ProductEntity>>(products));

      when(() => mockGetCategories.call()).thenAnswer(
        (_) async => const Success<List<CategoryEntity>>(<CategoryEntity>[]),
      );
      when(() => mockGetProductsByCategory.call(any())).thenAnswer(
        (_) async => const Success<List<ProductEntity>>(<ProductEntity>[]),
      );

      await tester.pumpWidget(buildSubjectWithRouter());
      await tester.pumpAndSettle();

      await tester.tap(find.byType(TextFormField));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField), 'Camisa');
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      expect(
        find.descendant(
          of: find.byType(GridView),
          matching: find.text('Camisa'),
        ),
        findsOneWidget,
      );
    });

    testWidgets('Navega hacia atrás al hacer tap en el ícono arrow_back', (
      WidgetTester tester,
    ) async {
      when(() => mockGetCategories.call()).thenAnswer(
        (_) async => const Success<List<CategoryEntity>>(<CategoryEntity>[]),
      );
      when(() => mockGetProductsByCategory.call(any())).thenAnswer(
        (_) async => const Success<List<ProductEntity>>(<ProductEntity>[]),
      );

      await tester.pumpWidget(buildSubjectWithRouter());
      await tester.pumpAndSettle();

      await tester.tap(find.byType(TextFormField));
      await tester.pumpAndSettle();

      expect(find.byType(SearchProductsScreen), findsOneWidget);

      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      expect(find.byType(ProductsScreen), findsOneWidget);
      expect(find.byType(SearchProductsScreen), findsNothing);
    });
  });
}
