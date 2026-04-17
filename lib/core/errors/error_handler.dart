import 'dart:io';

import '../core.dart';

class ErrorHandler {
  static ApiResult<T> handle<T>(Object error) {
    if (error is SocketException) {
      return Failure(const NetworkError());
    } else if (error is HttpException) {
      return Failure(const NetworkError('Error HTTP inesperado'));
    } else if (error is FormatException) {
      return Failure(const ParseError());
    } else {
      return Failure(UnknownError(error.toString()));
    }
  }
}
