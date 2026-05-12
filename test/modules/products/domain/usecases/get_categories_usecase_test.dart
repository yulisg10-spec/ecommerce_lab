import 'package:ecommerce_lab/core/core.dart';
import 'package:ecommerce_lab/modules/products/product_module.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../ui/helpers/fake_catalog_data.dart';
import '../mocks/mock_category_repository.dart';

void main() {
  late MockCategoryRepository mockRepository;
  late GetCategoriesUsecase usecase;

  setUp(() {
    mockRepository = MockCategoryRepository();
    usecase = GetCategoriesUsecase(repository: mockRepository);
  });

  group('GetCategoriesUsecase', () {
    test('Retorna categorías cuando el repositorio tiene éxito', () async {
      final List<CategoryEntity> categories =
          FakeCatalogData.fakeCategoriesEntity();

      when(
        () => mockRepository.getCategories(),
      ).thenAnswer((_) async => Success<List<CategoryEntity>>(categories));

      final ApiResult<List<CategoryEntity>> result = await usecase.call();

      expect(result, isA<Success<List<CategoryEntity>>>());
      expect((result as Success<List<CategoryEntity>>).data, categories);
      verify(() => mockRepository.getCategories()).called(1);
    });

    test('Retorna failure cuando el repositorio falla', () async {
      when(() => mockRepository.getCategories()).thenAnswer(
        (_) async => const Failure<List<CategoryEntity>>(ServerError(500)),
      );

      final ApiResult<List<CategoryEntity>> result = await usecase.call();
      final AppError error = (result as Failure<List<CategoryEntity>>).error;

      expect(result, isA<Failure<List<CategoryEntity>>>());
      expect(error, isA<ServerError>());
      expect((error as ServerError).statusCode, 500);
      verify(() => mockRepository.getCategories()).called(1);
    });
  });
}
