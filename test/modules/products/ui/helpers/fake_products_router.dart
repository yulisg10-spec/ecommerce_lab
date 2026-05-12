import 'package:ecommerce_lab/modules/products/product_module.dart';
import 'package:go_router/go_router.dart';

class FakeProductsRouter {
  static GoRouter build() {
    return GoRouter(
      initialLocation: ProductsRoutes.home,
      routes: <GoRoute>[...ProductsRoutes.routes],
    );
  }
}
