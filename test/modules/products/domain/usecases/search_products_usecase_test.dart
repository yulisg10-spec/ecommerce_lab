import 'package:ecommerce_lab/core/core.dart';
import 'package:ecommerce_lab/modules/products/product_module.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../ui/helpers/fake_catalog_data.dart';
import '../mocks/mock_product_repository.dart';

void main() {
  late MockProductRepository mockRepository;
  late SearchProductsUsecase usecase;

  setUp(() {
    mockRepository = MockProductRepository();
    usecase = SearchProductsUsecase(repository: mockRepository);
  });

  group('SearchProductsUsecase', () {
    test('Retorna productos cuando el repositorio tiene éxito', () async {
      final List<ProductEntity> products = FakeCatalogData.fakeProductsEntity();

      when(
        () => mockRepository.searchProducts('camisa'),
      ).thenAnswer((_) async => Success<List<ProductEntity>>(products));

      final ApiResult<List<ProductEntity>> result = await usecase.call(
        'camisa',
      );

      expect(result, isA<Success<List<ProductEntity>>>());
      expect((result as Success<List<ProductEntity>>).data, products);
      verify(() => mockRepository.searchProducts('camisa')).called(1);
    });

    test('Retorna failure cuando el repositorio falla', () async {
      when(() => mockRepository.searchProducts('camisa')).thenAnswer(
        (_) async =>
            const Failure<List<ProductEntity>>(NetworkError('Sin conexión')),
      );

      final ApiResult<List<ProductEntity>> result = await usecase.call(
        'camisa',
      );

      expect(result, isA<Failure<List<ProductEntity>>>());
      verify(() => mockRepository.searchProducts('camisa')).called(1);
    });

    test('Pasa el query correcto al repositorio', () async {
      when(() => mockRepository.searchProducts(any())).thenAnswer(
        (_) async => const Success<List<ProductEntity>>(<ProductEntity>[]),
      );

      await usecase.call('vestido');

      verify(() => mockRepository.searchProducts('vestido')).called(1);
      verifyNever(() => mockRepository.searchProducts('camisa'));
    });
  });
}
