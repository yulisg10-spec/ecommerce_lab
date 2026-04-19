import 'dart:io';

import '../core.dart';

class ErrorHandler {
  static ApiResult<T> handle<T>(Object error) {
    if (error is SocketException) {
      return Failure<T>(const NetworkError());
    } else if (error is HttpException) {
      return Failure<T>(const NetworkError('Error HTTP inesperado'));
    } else if (error is FormatException) {
      return Failure<T>(const ParseError());
    } else {
      return Failure<T>(UnknownError('Error desconocido: ${error.toString()}'));
    }
  }
}
