import 'package:ecommerce_lab/core/core.dart';
import 'package:ecommerce_lab/modules/products/product_module.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/fake_product_data.dart';
import '../mocks/mock_product_datasource.dart';

void main() {
  late MockProductDatasource mockProductDatasource;
  late ProductRepositoryImpl repository;

  setUp(() {
    mockProductDatasource = MockProductDatasource();
    repository = ProductRepositoryImpl(datasource: mockProductDatasource);
  });

  group('ProductRepositoryImpl', () {
    final List<ProductModel> productsModel = <ProductModel>[
      FakeProductData.fakeProductModel(),
    ];

    group('getProductsByCategory', () {
      test(
        'Convierte List<ProductModel> a List<ProductEntity> en Success',
        () async {
          when(
            () => mockProductDatasource.getProductsByCategory(any()),
          ).thenAnswer((_) async => Success<List<ProductModel>>(productsModel));

          final ApiResult<List<ProductEntity>> result = await repository
              .getProductsByCategory('cat-1');

          final List<ProductEntity> entities =
              (result as Success<List<ProductEntity>>).data;

          expect(result, isA<Success<List<ProductEntity>>>());
          expect(entities.length, productsModel.length);
          expect(entities.first.id, productsModel.first.id);
        },
      );

      test('Propaga el AppError sin modificarlo en Failure', () async {
        when(
          () => mockProductDatasource.getProductsByCategory(any()),
        ).thenAnswer(
          (_) async => const Failure<List<ProductModel>>(ServerError(500)),
        );

        final ApiResult<List<ProductEntity>> result = await repository
            .getProductsByCategory('cat-1');

        expect(result, isA<Failure<List<ProductEntity>>>());
        expect(
          (result as Failure<List<ProductEntity>>).error,
          const ServerError(500),
        );
      });
    });

    group('searchProducts', () {
      test('Convierte modelos a entidades correctamente', () async {
        when(
          () => mockProductDatasource.searchProducts(any()),
        ).thenAnswer((_) async => Success<List<ProductModel>>(productsModel));

        final ApiResult<List<ProductEntity>> result = await repository
            .searchProducts('zapatillas');

        expect(result, isA<Success<List<ProductEntity>>>());
      });

      test('Propaga Failure del datasource', () async {
        when(() => mockProductDatasource.searchProducts(any())).thenAnswer(
          (_) async => const Failure<List<ProductModel>>(ServerError(500)),
        );

        final ApiResult<List<ProductEntity>> result = await repository
            .searchProducts('zapatillas');

        expect(result, isA<Failure<List<ProductEntity>>>());
        expect(
          (result as Failure<List<ProductEntity>>).error,
          const ServerError(500),
        );
      });
    });
  });
}
