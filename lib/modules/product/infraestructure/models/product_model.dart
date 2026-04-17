import '../../product_module.dart';

class ProductModel {
  final int id;
  final String title;
  final String description;
  final CategoryModel category;
  final num price;
  final num discountPercentage;
  final num rating;
  final int stock;
  final List<String> images;

  const ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.images,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      category: CategoryModel.fromJson(json['category'] as String),
      price: json['price'] as num,
      discountPercentage: json['discountPercentage'] as num,
      rating: json['rating'] as num,
      stock: json['stock'] as int,
      images: List<String>.from(
        (json['images'] as List<dynamic>).cast<String>(),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'stock': stock,
      'images': images,
    };
  }

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      title: title,
      description: description,
      category: category.toEntity(),
      price: price,
      discountPercentage: discountPercentage,
      rating: rating,
      stock: stock,
      images: images,
    );
  }
}
