import '../../product_module.dart';

class ProductModel {
  final String id;
  final String name;
  final String description;
  final num price;
  final int stock;
  final bool active;
  final String imagePath;

  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.active,
    required this.imagePath,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: json['price'] as num,
      stock: json['stock'] as int,
      active: json['active'] as bool,
      imagePath: json['imagePath'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'stock': stock,
      'active': active,
      'imagePath': imagePath,
    };
  }

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      name: name,
      description: description,
      price: price,
      active: active,
      stock: stock,
      imagePath: imagePath,
    );
  }
}
