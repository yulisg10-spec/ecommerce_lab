import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../products/product_module.dart';
import '../../cart_module.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  static const double _deliveryRate = 0.0975;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CartEntity cart = ref.watch(cartProvider);
    final CartNotifier cartNotifier = ref.read(cartProvider.notifier);
    final num deliveryFee = cart.total * _deliveryRate;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF24389C)),
          onPressed: () => context.go(ProductsRoutes.home),
        ),
        title: const Text(
          'Carrito de compras',
          style: TextStyle(
            color: Color(0xFF24389C),
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: cart.isEmpty
          ? const _EmptyCartView()
          : Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    children: <Widget>[
                      const SizedBox(height: 8.0),
                      ...cart.items.map(
                        (CartItemEntity item) => Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: CartItemWidget(
                            item: item,
                            onRemove: () =>
                                cartNotifier.removeItem(item.productId),
                            onDecrement: () {
                              if (item.quantity > 1) {
                                cartNotifier.updateQuantity(
                                  item.productId,
                                  item.quantity - 1,
                                );
                              }
                            },
                            onIncrement: () => cartNotifier.updateQuantity(
                              item.productId,
                              item.quantity + 1,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      const Divider(color: Color(0xFFE1E3E4)),
                      const SizedBox(height: 12.0),
                      OrderSummaryWidget(
                        subtotal: cart.total,
                        deliveryFee: deliveryFee,
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  ),
                ),
                _CheckoutBar(total: cart.total + deliveryFee),
              ],
            ),
    );
  }
}

class _CheckoutBar extends StatelessWidget {
  const _CheckoutBar({required this.total});

  final num total;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 12.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 64.0,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3F51B5),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
            onPressed: () {},
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Finalizar compra',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyCartView extends StatelessWidget {
  const _EmptyCartView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.shopping_cart_outlined,
            size: 80.0,
            color: Color(0xFFC5C5D4),
          ),
          SizedBox(height: 16.0),
          Text(
            'Tu carrito está vacío',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: Color(0xFF454652),
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Agrega productos para comenzar',
            style: TextStyle(
              fontSize: 14.0,
              color: Color(0xFF757684),
            ),
          ),
        ],
      ),
    );
  }
}
