import 'package:ecommerce_lab/core/config/config.dart';

class ApiEndpoints {
  const ApiEndpoints._();

  static const String _bucketIcons = 'icons';
  static const String _bucketProducts = 'products';

  static const String storageUrl =
      '${AppConfig.baseUrl}/storage/v1/object/public';

  static const String categories =
      '${AppConfig.baseUrl}/rest/v1/rpc/categories';

  static const String productsByCategory =
      '${AppConfig.baseUrl}/rest/v1/rpc/products-by-category';

  static const String searchProducts =
      '${AppConfig.baseUrl}/rest/v1/rpc/search-products';

  static String buildCategoryIconUrl(String path) =>
      '$storageUrl/$_bucketIcons/$path';

  static String buildProductImageUrl(String path) =>
      '$storageUrl/$_bucketProducts/$path';
}
