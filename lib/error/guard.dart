import 'package:beauty_tracker/error/app_error.dart';
import 'package:beauty_tracker/error/result.dart';

typedef AsyncBlock<T> = Future<T> Function();

Future<Result<T>> guard<T>(AsyncBlock<T> block, {AppError Function(Object e)? map}) async {
  try {
    return Result.ok(await block());
  } catch (e) {
    return Result.err(map?.call(e));
  }
}
