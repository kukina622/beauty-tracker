import 'package:watch_it/watch_it.dart';

T useDi<T extends Object>() {
  return di.get<T>();
}
