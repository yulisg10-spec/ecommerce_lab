import '../../product_module.dart';

class CategoryDetailEntity {
  final String id;
  final String name;
  final List<ProductEntity> products;

  CategoryDetailEntity({
    required this.id,
    required this.name,
    required this.products,
  });
}
