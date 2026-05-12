import 'package:ecommerce_lab/modules/products/product_module.dart';

class FakeCatalogData {
  static CategoryEntity fakeCategoryEntity({
    String id = 'cat-1',
    String name = 'Ropa',
    String iconPath = '',
  }) {
    return CategoryEntity(id: id, name: name, iconPath: iconPath);
  }

  static ProductEntity fakeProductEntity({
    String id = '1',
    String name = 'Camisa',
    String description = 'Description',
    double price = 9.99,
    int stock = 10,
    bool active = true,
    String imagePath = '',
  }) {
    return ProductEntity(
      id: id,
      name: name,
      description: description,
      price: price,
      stock: stock,
      active: active,
      imagePath: imagePath,
    );
  }

  static List<CategoryEntity> fakeCategoriesEntity() {
    return <CategoryEntity>[
      fakeCategoryEntity(id: 'cat-1', name: 'Ropa'),
      fakeCategoryEntity(id: 'cat-2', name: 'Hogar'),
    ];
  }

  static List<ProductEntity> fakeProductsEntity() {
    return <ProductEntity>[
      fakeProductEntity(id: '1', name: 'Camisa', price: 9.99),
      fakeProductEntity(id: '2', name: 'Vestido', price: 20.99),
    ];
  }
}
