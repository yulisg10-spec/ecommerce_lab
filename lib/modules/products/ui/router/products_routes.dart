import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../product_module.dart';

class ProductsRoutes {
  static const String home = '/';
  static const String searchProducts = '/search-products';

  static List<GoRoute> get routes => <GoRoute>[
    GoRoute(
      path: ProductsRoutes.home,
      builder: (BuildContext context, GoRouterState state) {
        return const ProductsScreen();
      },
    ),
    GoRoute(
      path: ProductsRoutes.searchProducts,
      builder: (BuildContext context, GoRouterState state) {
        return const SearchProductsScreen();
      },
    ),
  ];
}
