import 'package:beauty_tracker/hooks/use_provider_listener.dart';
import 'package:beauty_tracker/providers/brand_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void useBrandRefreshListener(VoidCallback onRefresh) {
  final provider = useProviderListener<BrandProvider>();
  final shouldRefresh = provider.shouldRefresh;
  final refreshId = provider.refreshId;
  final lastRefreshId = useRef<int>(0);

  useEffect(() {
    if (shouldRefresh && refreshId != lastRefreshId.value) {
      onRefresh();
      lastRefreshId.value = refreshId;
    }
    return null;
  }, [shouldRefresh, refreshId]);
}
