import 'dart:convert';

import 'package:ecommerce_lab/core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  http.Response makeResponse(int statusCode, Map<String, dynamic> body) {
    return http.Response(jsonEncode(body), statusCode);
  }

  group('ResponseMapper', () {
    group('Códigos de éxito', () {
      test('200 retorna Success con el objeto mapeado', () {
        final http.Response response = makeResponse(200, <String, dynamic>{
          'id': '1',
          'name': 'Camisa',
        });

        final ApiResult<Map<String, dynamic>> result = ResponseMapper.map(
          response,
          (Map<String, dynamic> json) => json,
        );

        expect(result, isA<Success<Map<String, dynamic>>>());
        expect(
          (result as Success<Map<String, dynamic>>).data,
          <String, dynamic>{'id': '1', 'name': 'Camisa'},
        );
      });

      test('201 retorna Success', () {
        final http.Response response = makeResponse(201, <String, dynamic>{
          'id': '2',
        });

        final ApiResult<Map<String, dynamic>> result = ResponseMapper.map(
          response,
          (Map<String, dynamic> json) => json,
        );

        expect(result, isA<Success<Map<String, dynamic>>>());
      });
    });

    group('Códigos de error', () {
      test('401 retorna Failure con UnauthorizedError', () {
        final http.Response response = makeResponse(401, <String, dynamic>{
          'error': 'Unauthorized',
        });

        final ApiResult<Map<String, dynamic>> result = ResponseMapper.map(
          response,
          (Map<String, dynamic> json) => json,
        );

        expect(result, isA<Failure<Map<String, dynamic>>>());
        expect(
          (result as Failure<Map<String, dynamic>>).error,
          isA<UnauthorizedError>(),
        );
      });

      test('404 retorna Failure con NotFoundError', () {
        final http.Response response = makeResponse(404, <String, dynamic>{
          'error': 'Not found',
        });

        final ApiResult<Map<String, dynamic>> result = ResponseMapper.map(
          response,
          (Map<String, dynamic> json) => json,
        );

        expect(result, isA<Failure<Map<String, dynamic>>>());
        expect(
          (result as Failure<Map<String, dynamic>>).error,
          isA<NotFoundError>(),
        );
      });

      test('500 retorna Failure con ServerError y el statusCode correcto', () {
        final http.Response response = makeResponse(500, <String, dynamic>{
          'error': 'Internal server error',
        });

        final ApiResult<Map<String, dynamic>> result = ResponseMapper.map(
          response,
          (Map<String, dynamic> json) => json,
        );

        expect(result, isA<Failure<Map<String, dynamic>>>());
        final AppError error = (result as Failure<Map<String, dynamic>>).error;
        expect(error, isA<ServerError>());
        expect((error as ServerError).statusCode, 500);
      });

      test(
        'Código no manejado retorna Failure con ServerError y mensaje personalizado',
        () {
          final http.Response response = makeResponse(422, <String, dynamic>{
            'error': 'Unprocessable entity',
          });

          final ApiResult<Map<String, dynamic>> result = ResponseMapper.map(
            response,
            (Map<String, dynamic> json) => json,
          );

          expect(result, isA<Failure<Map<String, dynamic>>>());
          final AppError error =
              (result as Failure<Map<String, dynamic>>).error;
          expect(error, isA<ServerError>());
          expect(error.message, 'Error inesperado');
        },
      );
    });

    group('Errores de parsing', () {
      test('Body inválido retorna Failure con ParseError (JSON inválido)', () {
        final http.Response response = http.Response('not a json', 200);

        final ApiResult<Map<String, dynamic>> result = ResponseMapper.map(
          response,
          (Map<String, dynamic> json) => json,
        );

        expect(result, isA<Failure<Map<String, dynamic>>>());
        expect(
          (result as Failure<Map<String, dynamic>>).error,
          isA<ParseError>(),
        );
      });

      test('fromJson lanza excepción retorna Failure con ParseError', () {
        final http.Response response = makeResponse(200, <String, dynamic>{
          'unexpected': 'structure',
        });

        final ApiResult<String> result = ResponseMapper.map(
          response,
          (Map<String, dynamic> json) =>
              throw const FormatException('Campo requerido faltante'),
        );

        expect(result, isA<Failure<String>>());
        expect((result as Failure<String>).error, isA<ParseError>());
      });
    });
  });
}
