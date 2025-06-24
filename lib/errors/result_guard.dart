import 'package:beauty_tracker/errors/app_error.dart';
import 'package:beauty_tracker/errors/result.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<Result<T>> resultGuard<T>(
  Future<T> Function() action, {
  AppError Function(Object error)? mapError,
}) async {
  try {
    final value = await action();
    return Ok(value);
  } catch (e) {
    if (mapError case final fn?) {
      return Err(fn(e));
    }

    // supbase auth error
    if (e is AuthException) {
      return Err(AuthError(e.message, code: e.code?.toString()));
    }

    if (e is PostgrestException) {
      return Err(NetworkError(e.message));
    }

    if (e is AppError) {
      return Err(e);
    }

    return Err(UnknownError(e.toString()));
  }
}
