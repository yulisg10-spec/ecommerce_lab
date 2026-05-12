import 'package:ecommerce_lab/modules/products/product_module.dart';

class FakeCategoryData {
  static Map<String, dynamic> fakeCategoryJson({
    String id = 'cat-1',
    String name = 'Ropa',
    String iconPath = '',
  }) {
    return <String, dynamic>{'id': id, 'name': name, 'iconPath': iconPath};
  }

  static CategoryModel fakeCategoryModel() {
    return CategoryModel.fromJson(fakeCategoryJson());
  }
}
