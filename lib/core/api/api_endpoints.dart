import 'package:ecommerce_lab/config/config.dart';

class ApiEndpoints {
  static const String categories = '${AppConfig.baseUrl}/rest/v1/categories';

  static const String categoryProducts =
      '${AppConfig.baseUrl}/rest/v1/rpc/category_products';

  static String searchProducts(String query) =>
      '${AppConfig.baseUrl}/products/search?q=$query';
}
