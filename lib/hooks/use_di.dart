import 'package:get_it/get_it.dart';

final di = GetIt.instance;

T useDi<T extends Object>() {
  return di.get<T>();
}
