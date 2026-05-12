import 'package:ecommerce_lab/core/core.dart';
import 'package:ecommerce_lab/modules/products/product_module.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/mock_api_client.dart';
import '../helpers/fake_product_data.dart';

void main() {
  late MockApiClient mockApiClient;
  late ProductDatasourceImpl datasource;
  late Map<String, dynamic> fakeApiResponse;

  setUp(() {
    mockApiClient = MockApiClient();
    datasource = ProductDatasourceImpl(apiClient: mockApiClient);
    fakeApiResponse = <String, dynamic>{
      'data': <Map<String, dynamic>>[FakeProductData.fakeProductJson()],
    };
  });

  group('getProductsByCategory', () {
    test(
      'Retorna Success con la lista de productos y parsea correctamente la respuesta de la API',
      () async {
        when(
          () => mockApiClient.post<List<ProductModel>>(
            url: any(named: 'url'),
            body: any(named: 'body'),
            fromJson: any(named: 'fromJson'),
          ),
        ).thenAnswer((Invocation invocation) async {
          final List<ProductModel> Function(Map<String, dynamic>) fromJson =
              invocation.namedArguments[#fromJson]
                  as List<ProductModel> Function(Map<String, dynamic>);

          final List<ProductModel> productsModel = fromJson(fakeApiResponse);

          return Success<List<ProductModel>>(productsModel);
        });

        final ApiResult<List<ProductModel>> result = await datasource
            .getProductsByCategory('cat-1');

        final List<ProductModel> resultData =
            (result as Success<List<ProductModel>>).data;
        final ProductModel expected = FakeProductData.fakeProductModel();

        expect(result, isA<Success<List<ProductModel>>>());
        expect(resultData.length, 1);
        expect(resultData.first.id, expected.id);
        expect(resultData.first.name, expected.name);
        expect(resultData.first.price, expected.price);
      },
    );

    test('Retorna Failure cuando ApiClient falla', () async {
      when(
        () => mockApiClient.post<List<ProductModel>>(
          url: any(named: 'url'),
          body: any(named: 'body'),
          fromJson: any(named: 'fromJson'),
        ),
      ).thenAnswer((_) async {
        return const Failure<List<ProductModel>>(NetworkError('Sin conexión'));
      });

      final ApiResult<List<ProductModel>> result = await datasource
          .getProductsByCategory('cat-1');

      expect(result, isA<Failure<List<ProductModel>>>());
    });
  });

  group('searchProducts', () {
    test('Se realiza la búsqueda de producto con el query correcto', () async {
      when(
        () => mockApiClient.post<List<ProductModel>>(
          url: any(named: 'url'),
          body: any(named: 'body'),
          fromJson: any(named: 'fromJson'),
        ),
      ).thenAnswer((Invocation invocation) async {
        final List<ProductModel> Function(Map<String, dynamic>) fromJson =
            invocation.namedArguments[#fromJson]
                as List<ProductModel> Function(Map<String, dynamic>);

        final List<ProductModel> productsModel = fromJson(fakeApiResponse);
        return Success<List<ProductModel>>(productsModel);
      });

      final ApiResult<List<ProductModel>> result = await datasource
          .searchProducts('zapatillas');

      expect(result, isA<Success<List<ProductModel>>>());
    });

    test('Retorna Failure en caso de error en la búsqueda', () async {
      when(
        () => mockApiClient.post<List<ProductModel>>(
          url: any(named: 'url'),
          body: any(named: 'body'),
          fromJson: any(named: 'fromJson'),
        ),
      ).thenAnswer((_) async {
        return const Failure<List<ProductModel>>(NetworkError('Sin conexión'));
      });

      final ApiResult<List<ProductModel>> result = await datasource
          .searchProducts('zapatillas');

      expect(result, isA<Failure<List<ProductModel>>>());
    });
  });
}
