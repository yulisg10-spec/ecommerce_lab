import 'package:ecommerce_lab/core/api/api_client.dart';
import 'package:ecommerce_lab/modules/product/di/product_di.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

class DependencyInjection {
  DependencyInjection._();

  static final GetIt _getIt = GetIt.instance;

  static void setup() {
    _registerApiClient(_getIt);
    _registerHttpClient(_getIt);
    _registerModules(_getIt);
  }

  static void _registerApiClient(GetIt getIt) {
    getIt.registerLazySingleton<ApiClient>(() => ApiClient());
  }

  static void _registerHttpClient(GetIt getIt) {
    getIt.registerLazySingleton<http.Client>(() => http.Client());
  }

  static void _registerModules(GetIt getIt) {
    ProductDI.register(getIt);
  }
}
