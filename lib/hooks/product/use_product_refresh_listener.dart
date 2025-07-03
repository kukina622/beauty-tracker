import 'package:beauty_tracker/hooks/use_provider_listener.dart';
import 'package:beauty_tracker/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void useProductRefreshListener(VoidCallback onRefresh) {
  final provider = useProviderListener<ProductProvider>();
  final shouldRefresh = provider.shouldRefresh;

  useEffect(() {
    if (shouldRefresh) {
      onRefresh();
      provider.resetRefresh();
    }
    return null;
  }, [shouldRefresh]);
}
