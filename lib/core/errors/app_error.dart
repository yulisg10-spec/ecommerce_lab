sealed class AppError {
  final String message;
  final String code;
  const AppError(this.message, this.code);
}

final class NetworkError extends AppError {
  const NetworkError([
    super.message = 'Sin conexión a internet',
    super.code = 'NETWORK_ERROR',
  ]);
}

final class ServerError extends AppError {
  final int statusCode;
  const ServerError(
    this.statusCode, [
    super.message = 'Error del servidor',
    super.code = 'SERVER_ERROR',
  ]);
}

final class UnauthorizedError extends AppError {
  const UnauthorizedError([
    super.message = 'No autorizado',
    super.code = 'UNAUTHORIZED',
  ]);
}

final class NotFoundError extends AppError {
  const NotFoundError([
    super.message = 'Recurso no encontrado',
    super.code = 'NOT_FOUND',
  ]);
}

final class ParseError extends AppError {
  const ParseError([
    super.message = 'Error al procesar la respuesta',
    super.code = 'PARSE_ERROR',
  ]);
}

final class UnknownError extends AppError {
  const UnknownError([
    super.message = 'Error desconocido',
    super.code = 'UNKNOWN_ERROR',
  ]);
}
