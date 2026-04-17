import 'dart:convert';
import 'package:http/http.dart' as http;

import '../core.dart';

class ApiClient {
  final Map<String, String> defaultHeaders;

  ApiClient({this.defaultHeaders = const {'Content-Type': 'application/json'}});

  Future<ApiResult<T>> get<T>({
    required String url,
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, String>? headers,
  }) async {
    return _sendRequest(
      request: () =>
          http.get(Uri.parse(url), headers: {...defaultHeaders, ...?headers}),
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
        headers: {...defaultHeaders, ...?headers},
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
      final response = await request();
      return ResponseMapper.map(response, fromJson);
    } catch (e) {
      return ErrorHandler.handle(e);
    }
  }
}
