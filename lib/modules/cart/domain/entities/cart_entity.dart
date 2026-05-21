import 'cart_item_entity.dart';

class CartEntity {
  final List<CartItemEntity> items;

  const CartEntity({required this.items});

  num get total => items.fold<num>(
      0, (num sum, CartItemEntity item) => sum + item.price * item.quantity);

  int get itemCount =>
      items.fold<int>(0, (int sum, CartItemEntity item) => sum + item.quantity);

  bool get isEmpty => items.isEmpty;
}
