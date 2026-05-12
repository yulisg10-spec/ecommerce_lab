import 'package:ecommerce_lab/modules/products/product_module.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/fake_product_data.dart';

void main() {
  group('ProductModel', () {
    group('fromJson', () {
      test('Parsea todos los campos correctamente', () {
        final ProductModel model = ProductModel.fromJson(
          FakeProductData.fakeProductJson(),
        );

        expect(model.id, '1');
        expect(model.name, 'Camisa');
        expect(model.price, 9.99);
        expect(model.stock, 10);
        expect(model.active, true);
      });

      test('Lanza TypeError si falta un campo requerido', () {
        final Map<String, dynamic> badJson = FakeProductData.fakeProductJson()
          ..remove('id');

        expect(() => ProductModel.fromJson(badJson), throwsA(isA<TypeError>()));
      });
    });

    group('toJson', () {
      test('Serializa todos los campos al mapa correcto', () {
        final ProductModel model = FakeProductData.fakeProductModel();
        final Map<String, dynamic> json = model.toJson();

        expect(json['id'], model.id);
        expect(json['price'], model.price);
        expect(json['active'], model.active);
        expect(ProductModel.fromJson(json).toJson(), equals(json));
      });
    });

    group('toEntity', () {
      test('Convierte correctamente a ProductEntity', () {
        final ProductModel model = FakeProductData.fakeProductModel();
        final ProductEntity entity = model.toEntity();

        expect(entity, isA<ProductEntity>());
        expect(entity.id, model.id);
        expect(entity.name, model.name);
        expect(entity.price, model.price);
      });
    });
  });
}
