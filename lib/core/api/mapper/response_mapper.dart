import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../core.dart';

class ResponseMapper {
  static ApiResult<T> map<T>(
    http.Response response,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    try {
      final Map<String, dynamic> body =
          jsonDecode(response.body) as Map<String, dynamic>;

      return switch (response.statusCode) {
        >= 200 && < 300 => Success<T>(fromJson(body)),
        401 => Failure<T>(const UnauthorizedError()),
        404 => Failure<T>(const NotFoundError()),
        >= 500 => Failure<T>(ServerError(response.statusCode)),
        _ => Failure<T>(ServerError(response.statusCode, 'Error inesperado')),
      };
    } on FormatException {
      return Failure<T>(const ParseError());
    }
  }
}
