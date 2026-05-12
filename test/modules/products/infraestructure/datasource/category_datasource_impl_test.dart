import 'package:ecommerce_lab/core/core.dart';
import 'package:ecommerce_lab/modules/products/product_module.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/mock_api_client.dart';
import '../helpers/fake_category_data.dart';

void main() {
  late MockApiClient mockApiClient;
  late CategoryDatasourceImpl datasource;
  late Map<String, dynamic> fakeApiResponse;

  setUp(() {
    mockApiClient = MockApiClient();
    datasource = CategoryDatasourceImpl(apiClient: mockApiClient);
    fakeApiResponse = <String, dynamic>{
      'data': <Map<String, dynamic>>[FakeCategoryData.fakeCategoryJson()],
    };
  });

  group('getCategories', () {
    test(
      'Retorna Success con la lista de categorías y parsea correctamente la respuesta de la API',
      () async {
        when(
          () => mockApiClient.get<List<CategoryModel>>(
            url: any(named: 'url'),
            fromJson: any(named: 'fromJson'),
          ),
        ).thenAnswer((Invocation invocation) async {
          final List<CategoryModel> Function(Map<String, dynamic>) fromJson =
              invocation.namedArguments[#fromJson]
                  as List<CategoryModel> Function(Map<String, dynamic>);

          final List<CategoryModel> categoriesModel = fromJson(fakeApiResponse);

          return Success<List<CategoryModel>>(categoriesModel);
        });

        final ApiResult<List<CategoryModel>> result = await datasource
            .getCategories();

        final List<CategoryModel> resultData =
            (result as Success<List<CategoryModel>>).data;
        final CategoryModel expected = FakeCategoryData.fakeCategoryModel();

        expect(result, isA<Success<List<CategoryModel>>>());
        expect(resultData.length, 1);
        expect(resultData.first.id, expected.id);
        expect(resultData.first.name, expected.name);
        expect(resultData.first.iconPath, expected.iconPath);
      },
    );

    test('Retorna Failure cuando ApiClient falla', () async {
      when(
        () => mockApiClient.get<List<CategoryModel>>(
          url: any(named: 'url'),
          fromJson: any(named: 'fromJson'),
        ),
      ).thenAnswer((_) async {
        return const Failure<List<CategoryModel>>(NetworkError('Sin conexión'));
      });

      final ApiResult<List<CategoryModel>> result = await datasource
          .getCategories();

      expect(result, isA<Failure<List<CategoryModel>>>());
    });
  });
}
