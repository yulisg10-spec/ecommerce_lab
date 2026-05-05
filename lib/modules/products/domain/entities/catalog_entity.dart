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

  CatalogEntity copyWith({
    List<CategoryEntity>? categories,
    List<ProductEntity>? products,
    String? selectedId,
  }) {
    return CatalogEntity(
      categories: categories ?? this.categories,
      products: products ?? this.products,
      selectedId: selectedId ?? this.selectedId,
    );
  }
}
