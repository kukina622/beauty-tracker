import 'package:beauty_tracker/error/app_error.dart';

sealed class Result<T> {
  const Result();
  factory Result.ok(T value) = Ok._;
  factory Result.err(AppError? err) = Err._;
}

final class Ok<T> extends Result<T> {
  const Ok._(this.value);
  final T value;
}

final class Err<T> extends Result<T> {
  const Err._(this.error);
  final AppError? error;
}
