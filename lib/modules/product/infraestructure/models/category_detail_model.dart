import '../../product_module.dart';

class CategoryDetailModel {
  final String id;
  final String name;
  final List<ProductModel> products;

  const CategoryDetailModel({
    required this.id,
    required this.name,
    required this.products,
  });

  factory CategoryDetailModel.fromJson(Map<String, dynamic> json) {
    return CategoryDetailModel(
      id: json['id'] as String,
      name: json['name'] as String,
      products: (json['products'] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map((Map<String, dynamic> data) => ProductModel.fromJson(data))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'products': products
          .map((ProductModel product) => product.toJson())
          .toList(),
    };
  }

  CategoryDetailEntity toEntity() {
    return CategoryDetailEntity(
      id: id,
      name: name,
      products: products
          .map((ProductModel product) => product.toEntity())
          .toList(),
    );
  }
}
