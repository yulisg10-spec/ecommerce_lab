import 'package:ecommerce_lab/modules/products/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../cart_module.dart';

class ProductDetailScreen extends ConsumerWidget {
  const ProductDetailScreen({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int quantity = ref.watch(productDetailProvider);
    final int cartCount = ref.watch(cartProvider).itemCount;
    final ProductDetailNotifier productDetailNotifier =
        ref.read(productDetailProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        scrolledUnderElevation: 1.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF24389C)),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Detalle del producto',
          style: TextStyle(
            color: Color(0xFF24389C),
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            icon: Badge.count(
              count: cartCount,
              isLabelVisible: cartCount > 0,
              child: const Icon(
                Icons.shopping_cart_outlined,
                color: Color(0xFF24389C),
              ),
            ),
            onPressed: () => context.go(CartRoutes.cart),
          ),
          const SizedBox(width: 8.0),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ProductImageSection(imagePath: product.imagePath),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          product.name,
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF191C1D),
                            height: 1.4,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF24389C),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  const StarRatingWidget(rating: 5, reviewCount: 0),
                  const SizedBox(height: 24.0),
                  const Text(
                    'Descripción',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF191C1D),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    product.description,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Color(0xFF454652),
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 24.0),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomActionBar(
        product: product,
        quantity: quantity,
        onDecrement: productDetailNotifier.decrement,
        onIncrement: productDetailNotifier.increment,
        onAddToCart: () {
          productDetailNotifier.addToCart(product);
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  children: <Widget>[
                    const Icon(
                      Icons.check_circle_rounded,
                      color: Colors.white,
                      size: 20.0,
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            '¡Agregado al carrito!',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.green[700],
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            );
        },
      ),
    );
  }
}
