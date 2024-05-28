import 'package:mealmap/features/location/location_permission_view.dart';
import 'package:mealmap/features/login/login_view.dart';
import 'package:mealmap/features/splash/splash_view.dart';

class AppRoute {
  AppRoute._();

  static const String splashRoute = '/';
  static const String locationRoute = '/location';
  static const String loginRoute = '/login';

  static getApplicationRoute() {
    return {
      splashRoute: (context) => const SplashView(),
      locationRoute: (context) => const LocationPermissionView(),
      loginRoute: (context) => const LoginView(),
    };
  }
}
