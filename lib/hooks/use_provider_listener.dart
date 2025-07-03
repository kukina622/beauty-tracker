import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

T useProviderListener<T>() {
  final context = useContext();
  return context.watch<T>();
}
