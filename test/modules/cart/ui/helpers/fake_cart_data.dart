import 'package:ecommerce_lab/modules/cart/cart_module.dart';
import 'package:ecommerce_lab/modules/products/domain/entities/product_entity.dart';

class FakeCartData {
  static ProductEntity fakeProduct({
    String id = 'p1',
    String name = 'Test Product',
    num price = 25.0,
    String imagePath = '',
    String description = 'A test product description.',
    int stock = 10,
    bool active = true,
  }) =>
      ProductEntity(
        id: id,
        name: name,
        price: price,
        imagePath: imagePath,
        description: description,
        stock: stock,
        active: active,
      );

  static CartItemEntity fakeItem({
    String productId = 'p1',
    String name = 'Test Product',
    String imagePath = '',
    num price = 25.0,
    int quantity = 1,
  }) =>
      CartItemEntity(
        productId: productId,
        name: name,
        imagePath: imagePath,
        price: price,
        quantity: quantity,
      );
}
