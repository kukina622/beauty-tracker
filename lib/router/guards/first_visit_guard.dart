import 'package:auto_route/auto_route.dart';
import 'package:beauty_tracker/services/local_storage_service/local_storage_keys.dart';
import 'package:beauty_tracker/services/local_storage_service/local_storage_service.dart';
import 'package:watch_it/watch_it.dart';

class FirstVisitGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    final isFirstVisit = await checkFirstVisit();

    if (isFirstVisit) {
      router.pushPath('/onboarding');
    } else {
      resolver.next(true);
    }
  }

  Future<bool> checkFirstVisit() async {
    final isFirstVisit = await di.get<LocalStorageService>().getBool(LocalStorageKeys.isFirstVisit);
    return isFirstVisit ?? true; // Placeholder for first visit logic
  }
}
