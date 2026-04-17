import 'dart:io';

import '../core.dart';

class ErrorHandler {
  static ApiResult<T> handle<T>(Object error) {
    if (error is SocketException) {
      return const Failure(NetworkError());
    } else if (error is HttpException) {
      return const Failure(NetworkError('Error HTTP inesperado'));
    } else if (error is FormatException) {
      return const Failure(ParseError());
    } else {
      return const Failure(UnknownError('Error desconocido'));
    }
  }
}
