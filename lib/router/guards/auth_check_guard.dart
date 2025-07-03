import 'package:auto_route/auto_route.dart';
import 'package:beauty_tracker/services/auth_service/auth_service.dart';
import 'package:get_it/get_it.dart';

final di = GetIt.instance;

class AuthCheckGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    final isAuthenticated = checkAuthentication();

    if (isAuthenticated) {
      resolver.next(true);
    } else {
      router.pushPath('/login');
    }
  }

  bool checkAuthentication() {
    return di.get<AuthService>().isLoggedIn;
  }
}
