import 'package:ecommerce_lab/modules/products/product_module.dart';

class FakeProductData {
  static Map<String, dynamic> fakeProductJson({
    String id = '1',
    String name = 'Camisa',
    num price = 9.99,
    int stock = 10,
    bool active = true,
  }) {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': 'Camisa',
      'price': price,
      'stock': stock,
      'active': active,
      'imagePath': '',
    };
  }

  static ProductModel fakeProductModel() {
    return ProductModel.fromJson(fakeProductJson());
  }
}
