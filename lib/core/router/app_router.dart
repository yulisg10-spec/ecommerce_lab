import 'package:go_router/go_router.dart';

import '../../modules/products/product_module.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: ProductsRoutes.home,
    routes: <GoRoute>[...ProductsRoutes.routes],
  );
}
