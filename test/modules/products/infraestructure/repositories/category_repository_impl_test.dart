import 'package:ecommerce_lab/core/core.dart';
import 'package:ecommerce_lab/modules/products/product_module.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/fake_category_data.dart';
import '../mocks/mock_category_datasource.dart';

void main() {
  late MockCategoryDatasource mockCategoryDatasource;
  late CategoryRepositoryImpl repository;

  setUp(() {
    mockCategoryDatasource = MockCategoryDatasource();
    repository = CategoryRepositoryImpl(datasource: mockCategoryDatasource);
  });

  group('ProductRepositoryImpl', () {
    final List<CategoryModel> categoriesModel = <CategoryModel>[
      FakeCategoryData.fakeCategoryModel(),
    ];

    group('getProductsByCategory', () {
      test(
        'Convierte List<CategoryModel> a List<CategoryEntity> en Success',
        () async {
          when(() => mockCategoryDatasource.getCategories()).thenAnswer(
            (_) async => Success<List<CategoryModel>>(categoriesModel),
          );

          final ApiResult<List<CategoryEntity>> result = await repository
              .getCategories();

          final List<CategoryEntity> entities =
              (result as Success<List<CategoryEntity>>).data;

          expect(result, isA<Success<List<CategoryEntity>>>());
          expect(entities.length, categoriesModel.length);
          expect(entities.first.id, categoriesModel.first.id);
        },
      );

      test('Propaga el AppError sin modificarlo en Failure', () async {
        when(() => mockCategoryDatasource.getCategories()).thenAnswer(
          (_) async => const Failure<List<CategoryModel>>(ServerError(500)),
        );

        final ApiResult<List<CategoryEntity>> result = await repository
            .getCategories();

        expect(result, isA<Failure<List<CategoryEntity>>>());
        expect(
          (result as Failure<List<CategoryEntity>>).error,
          const ServerError(500),
        );
      });
    });
  });
}
