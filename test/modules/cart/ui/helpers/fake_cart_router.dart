import 'package:ecommerce_lab/modules/cart/ui/router/cart_routes.dart';
import 'package:ecommerce_lab/modules/cart/ui/screens/product_detail_screen.dart';
import 'package:ecommerce_lab/modules/products/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FakeCartRouter {
  static GoRouter build(ProductEntity product) => GoRouter(
        initialLocation: CartRoutes.productDetail,
        routes: <GoRoute>[
          GoRoute(
            path: CartRoutes.productDetail,
            builder: (BuildContext context, GoRouterState state) =>
                ProductDetailScreen(product: product),
          ),
        ],
      );
}
