sealed class AppError implements Exception {
  const AppError(this.message, {this.code});
  final String message;
  final String? code;
}

final class AuthError extends AppError {
  const AuthError(super.message, {super.code});
}

final class NetworkError extends AppError {
  const NetworkError(super.message, {super.code});
}

final class UnknownError extends AppError {
  const UnknownError(super.message, {super.code});
}
