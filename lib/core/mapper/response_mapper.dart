import 'dart:convert';
import 'package:http/http.dart' as http;

import '../core.dart';

class ResponseMapper {
  static ApiResult<T> map<T>(
    http.Response response,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    try {
      final body = jsonDecode(response.body) as Map<String, dynamic>;

      return switch (response.statusCode) {
        >= 200 && < 300 => Success(fromJson(body)),
        401 => Failure(const UnauthorizedError()),
        404 => Failure(const NotFoundError()),
        >= 500 => Failure(ServerError(response.statusCode)),
        _ => Failure(ServerError(response.statusCode, 'Error inesperado')),
      };
    } on FormatException {
      return Failure(const ParseError());
    }
  }
}
