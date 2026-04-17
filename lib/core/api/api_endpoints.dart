class ApiEndpoints {
  static const String baseUrl = 'https://dummyjson.com';
  static const String products = '$baseUrl/products';
  static const String categories = '$baseUrl/products/category-list';

  static String searchProducts(String query) =>
      '$baseUrl/products/search?q=$query';

  static String productByCategory(String category) =>
      '$baseUrl/products/category/$category';
}
