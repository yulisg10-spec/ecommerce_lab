import '../core.dart';

sealed class ApiResult<T> {
  const ApiResult();

  R when<R>({
    required R Function(T data) success,
    required R Function(AppError error) failure,
  }) {
    return switch (this) {
      Success<T>(:final T data) => success(data),
      Failure<T>(:final AppError error) => failure(error),
    };
  }
}

final class Success<T> extends ApiResult<T> {
  final T data;
  const Success(this.data);
}

final class Failure<T> extends ApiResult<T> {
  final AppError error;
  const Failure(this.error);
}
