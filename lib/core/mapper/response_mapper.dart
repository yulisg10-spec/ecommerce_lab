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
        401 => const Failure(UnauthorizedError()),
        404 => const Failure(NotFoundError()),
        >= 500 => Failure(ServerError(response.statusCode)),
        _ => Failure(ServerError(response.statusCode, 'Error inesperado')),
      };
    } on FormatException {
      return const Failure(ParseError());
    }
  }
}
