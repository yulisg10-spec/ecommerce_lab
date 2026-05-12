import 'dart:io';

import 'package:ecommerce_lab/core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ErrorHandler', () {
    test('SocketException retorna Failure con NetworkError por defecto', () {
      final ApiResult<String> result = ErrorHandler.handle<String>(
        const SocketException('Sin conexión'),
      );

      expect(result, isA<Failure<String>>());
      expect((result as Failure<String>).error, isA<NetworkError>());
      expect(result.error.message, 'Sin conexión a internet');
    });

    test(
      'HttpException retorna Failure con NetworkError con mensaje personalizado',
      () {
        final ApiResult<String> result = ErrorHandler.handle<String>(
          const HttpException('Error HTTP inesperado'),
        );

        expect(result, isA<Failure<String>>());
        expect((result as Failure<String>).error, isA<NetworkError>());
        expect(result.error.message, 'Error HTTP inesperado');
      },
    );

    test('FormatException retorna Failure con ParseError', () {
      final ApiResult<String> result = ErrorHandler.handle<String>(
        const FormatException('JSON inválido'),
      );

      expect(result, isA<Failure<String>>());
      expect((result as Failure<String>).error, isA<ParseError>());
    });

    test('Error desconocido retorna Failure con UnknownError', () {
      final ApiResult<String> result = ErrorHandler.handle<String>(
        Exception('Algo inesperado'),
      );

      expect(result, isA<Failure<String>>());
      final AppError error = (result as Failure<String>).error;
      expect(error, isA<UnknownError>());
      expect(error.message, contains('Error desconocido'));
    });
  });
}
