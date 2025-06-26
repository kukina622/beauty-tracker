import 'package:beauty_tracker/errors/app_error.dart';
import 'package:beauty_tracker/errors/result.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

typedef Fetcher<T> = Future<Result<T>> Function();

class ServiceDataResult<T> {
  const ServiceDataResult({
    required this.data,
    required this.loading,
    this.error,
    required this.refresh,
    required this.mutate,
  });

  final T? data;
  final bool loading;
  final String? error;
  final Future<void> Function() refresh;
  final void Function(T? newData) mutate;

  bool get hasData => data != null;

  bool get hasError => error != null;
}

ServiceDataResult<T> useServiceData<T>(
  Fetcher<T> fetcher, {
  bool enabled = true,
  bool refreshOnMount = true,
}) {
  final loading = useState<bool>(false);
  final data = useState<T?>(null);
  final error = useState<String?>(null);

  final fetcherRef = useRef<Fetcher<T>>(fetcher);
  fetcherRef.value = fetcher;

  final fetchData = useCallback(() async {
    if (!enabled) {
      return;
    }

    loading.value = true;
    error.value = null;
    data.value = null;

    try {
      final result = await fetcherRef.value();
      switch (result) {
        case Ok(value: final T value):
          data.value = value;
          error.value = null;
        case Err(error: final AppError appError):
          data.value = null;
          error.value = appError.message;
      }
    } catch (e) {
      data.value = null;
      error.value = e.toString();
    } finally {
      loading.value = false;
    }
  }, [enabled]);

  // ignore: avoid_types_on_closure_parameters
  final mutate = useCallback((T? newData) {
    data.value = newData;
    error.value = null;
  }, []);

  useEffect(() {
    if (!enabled || !refreshOnMount) {
      return null;
    }

    fetchData();
    return null;
  }, []);

  return ServiceDataResult<T>(
    data: data.value,
    loading: loading.value,
    error: error.value,
    refresh: fetchData,
    mutate: mutate,
  );
}
