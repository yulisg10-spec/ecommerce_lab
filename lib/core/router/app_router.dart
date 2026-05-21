import 'package:ecommerce_lab/modules/cart/cart_module.dart';
import 'package:ecommerce_lab/modules/products/product_module.dart';
import 'package:ecommerce_lab/modules/profile/ui/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'bottom_navigation_shell.dart';

class AppRouter {
  static const String _profile = '/profile';

  static final GoRouter router = GoRouter(
    initialLocation: ProductsRoutes.home,
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        builder: (
          BuildContext context,
          GoRouterState state,
          StatefulNavigationShell navigationShell,
        ) =>
            BottomNavigationShell(navigationShell: navigationShell),
        branches: <StatefulShellBranch>[
          // Rama 0 — Inicio
          StatefulShellBranch(
            routes: <GoRoute>[
              GoRoute(
                path: ProductsRoutes.home,
                builder: (BuildContext context, GoRouterState state) =>
                    const ProductsScreen(),
              ),
            ],
          ),
          // Rama 1 — Carrito
          StatefulShellBranch(
            routes: <GoRoute>[
              GoRoute(
                path: CartRoutes.cart,
                builder: (BuildContext context, GoRouterState state) =>
                    const CartScreen(),
              ),
            ],
          ),
          // Rama 2 — Perfil
          StatefulShellBranch(
            routes: <GoRoute>[
              GoRoute(
                path: _profile,
                builder: (BuildContext context, GoRouterState state) =>
                    const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      // Pantallas fuera del shell (sin bottom navigation):
      GoRoute(
        path: ProductsRoutes.searchProducts,
        builder: (BuildContext context, GoRouterState state) =>
            const SearchProductsScreen(),
      ),
      GoRoute(
        path: CartRoutes.productDetail,
        builder: (BuildContext context, GoRouterState state) {
          final ProductEntity product = state.extra! as ProductEntity;
          return ProductDetailScreen(product: product);
        },
      ),
    ],
  );
}
