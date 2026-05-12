import '../../product_module.dart';

class CatalogEntity {
  final List<CategoryEntity> categories;
  final List<ProductEntity> products;
  final String? selectedId;

  CatalogEntity({
    required this.categories,
    required this.products,
    required this.selectedId,
  });
}
