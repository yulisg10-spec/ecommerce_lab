import 'package:ecommerce_lab/modules/products/product_module.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/fake_category_data.dart';

void main() {
  group('CategoryModel', () {
    group('fromJson', () {
      test('Parsea todos los campos correctamente', () {
        final CategoryModel model = CategoryModel.fromJson(
          FakeCategoryData.fakeCategoryJson(),
        );

        expect(model.id, 'cat-1');
        expect(model.name, 'Ropa');
        expect(model.iconPath, '');
      });

      test('Lanza TypeError si falta un campo requerido', () {
        final Map<String, dynamic> badJson = FakeCategoryData.fakeCategoryJson()
          ..remove('id');

        expect(
          () => CategoryModel.fromJson(badJson),
          throwsA(isA<TypeError>()),
        );
      });
    });

    group('toJson', () {
      test('Serializa todos los campos al mapa correcto', () {
        final CategoryModel model = FakeCategoryData.fakeCategoryModel();
        final Map<String, dynamic> json = model.toJson();

        expect(json['id'], model.id);
        expect(json['name'], model.name);
        expect(json['iconPath'], model.iconPath);
        expect(CategoryModel.fromJson(json).toJson(), equals(json));
      });
    });

    group('toEntity', () {
      test('Convierte correctamente a ProductEntity', () {
        final CategoryModel model = FakeCategoryData.fakeCategoryModel();
        final CategoryEntity entity = model.toEntity();

        expect(entity, isA<CategoryEntity>());
        expect(entity.id, model.id);
        expect(entity.name, model.name);
        expect(entity.iconPath, model.iconPath);
      });
    });
  });
}
