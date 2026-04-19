import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../config/app_config.dart';
import '../core.dart';

class ApiClient {
  final Map<String, String> defaultHeaders;

  ApiClient({
    this.defaultHeaders = const <String, String>{
      'Content-Type': 'application/json',
      'apikey': AppConfig.apiKey,
      'Authorization': 'Bearer ${AppConfig.apiKey}',
    },
  });

  Future<ApiResult<T>> get<T>({
    required String url,
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, String>? headers,
  }) async {
    return _sendRequest(
      request: () => http.get(
        Uri.parse(url),
        headers: <String, String>{...defaultHeaders, ...?headers},
      ),
      fromJson: fromJson,
    );
  }

  Future<ApiResult<T>> post<T>({
    required String url,
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    return _sendRequest(
      request: () => http.post(
        Uri.parse(url),
        headers: <String, String>{...defaultHeaders, ...?headers},
        body: body != null ? jsonEncode(body) : null,
      ),
      fromJson: fromJson,
    );
  }

  Future<ApiResult<T>> _sendRequest<T>({
    required Future<http.Response> Function() request,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final http.Response response = await request();
      return ResponseMapper.map(response, fromJson);
    } catch (e) {
      return ErrorHandler.handle(e);
    }
  }
}
