import 'package:ecommerce_lab/core/core.dart';
import 'package:ecommerce_lab/modules/products/product_module.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../ui/helpers/fake_catalog_data.dart';
import '../mocks/mock_product_repository.dart';

void main() {
  late MockProductRepository mockRepository;
  late GetProductsByCategoryUsecase usecase;

  setUp(() {
    mockRepository = MockProductRepository();
    usecase = GetProductsByCategoryUsecase(repository: mockRepository);
  });

  group('GetProductsByCategoryUsecase', () {
    test('Retorna productos cuando el repositorio tiene éxito', () async {
      final List<ProductEntity> products = FakeCatalogData.fakeProductsEntity();

      when(
        () => mockRepository.getProductsByCategory('cat-1'),
      ).thenAnswer((_) async => Success<List<ProductEntity>>(products));

      final ApiResult<List<ProductEntity>> result = await usecase.call('cat-1');

      expect(result, isA<Success<List<ProductEntity>>>());
      expect((result as Success<List<ProductEntity>>).data, products);
      verify(() => mockRepository.getProductsByCategory('cat-1')).called(1);
    });

    test('Retorna failure cuando el repositorio falla', () async {
      when(() => mockRepository.getProductsByCategory('cat-1')).thenAnswer(
        (_) async => const Failure<List<ProductEntity>>(UnknownError()),
      );

      final ApiResult<List<ProductEntity>> result = await usecase.call('cat-1');
      final AppError error = (result as Failure<List<ProductEntity>>).error;

      expect(result, isA<Failure<List<ProductEntity>>>());
      expect(error, isA<UnknownError>());
      verify(() => mockRepository.getProductsByCategory('cat-1')).called(1);
    });

    test('Pasa el categoryId correcto al repositorio', () async {
      when(() => mockRepository.getProductsByCategory(any())).thenAnswer(
        (_) async => const Success<List<ProductEntity>>(<ProductEntity>[]),
      );

      await usecase.call('cat-99');

      verify(() => mockRepository.getProductsByCategory('cat-99')).called(1);
      verifyNever(() => mockRepository.getProductsByCategory('cat-1'));
    });
  });
}
