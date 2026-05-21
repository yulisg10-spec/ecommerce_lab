class CartItemEntity {
  final String productId;
  final String name;
  final String imagePath;
  final num price;
  final int quantity;

  const CartItemEntity({
    required this.productId,
    required this.name,
    required this.imagePath,
    required this.price,
    required this.quantity,
  });

  CartItemEntity copyWith({int? quantity}) {
    return CartItemEntity(
      productId: productId,
      name: name,
      imagePath: imagePath,
      price: price,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItemEntity &&
          productId == other.productId &&
          name == other.name &&
          imagePath == other.imagePath &&
          price == other.price &&
          quantity == other.quantity;

  @override
  int get hashCode => Object.hash(productId, name, imagePath, price, quantity);
}
