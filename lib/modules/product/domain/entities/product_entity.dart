import 'package:ecommerce_lab/modules/product/product_module.dart';

class ProductEntity {
  final int id;
  final String title;
  final String description;
  final CategoryEntity category;
  final num price;
  final num discountPercentage;
  final num rating;
  final int stock;
  final List<String> images;

  const ProductEntity({
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
}
