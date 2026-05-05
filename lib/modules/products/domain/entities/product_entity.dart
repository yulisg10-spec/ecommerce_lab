class ProductEntity {
  final String id;
  final String name;
  final String description;
  final num price;
  final int stock;
  final bool active;
  final String imagePath;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.active,
    required this.imagePath,
  });
}
