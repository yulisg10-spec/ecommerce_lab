import 'package:ecommerce_lab/modules/products/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/cart_screen.dart';
import '../screens/product_detail_screen.dart';

class CartRoutes {
  CartRoutes._();

  static const String cart = '/cart';
  static const String productDetail = '/cart/product-detail';

  static List<GoRoute> get routes => <GoRoute>[
    GoRoute(
      path: CartRoutes.cart,
      builder: (BuildContext context, GoRouterState state) =>
          const CartScreen(),
    ),
    GoRoute(
      path: CartRoutes.productDetail,
      builder: (BuildContext context, GoRouterState state) {
        final ProductEntity product = state.extra! as ProductEntity;
        return ProductDetailScreen(product: product);
      },
    ),
  ];
}
