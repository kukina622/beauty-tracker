import 'package:flutter/foundation.dart';

class BrandProvider extends ChangeNotifier {
  bool _shouldRefresh = false;
  int _refreshId = 0;

  bool get shouldRefresh => _shouldRefresh;
  int get refreshId => _refreshId;

  void triggerRefresh() {
    _shouldRefresh = true;
    _refreshId++;
    notifyListeners();
  }

  void resetRefresh() {
    _shouldRefresh = false;
  }
}
