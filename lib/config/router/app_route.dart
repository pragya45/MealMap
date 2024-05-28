import 'package:mealmap/features/location/location_permission_view.dart';
import 'package:mealmap/features/splash/splash_view.dart';

class AppRoute {
  AppRoute._();

  static const String splashRoute = '/';
  static const String locationRoute = '/location';

  static getApplicationRoute() {
    return {
      splashRoute: (context) => const SplashView(),
      locationRoute: (context) => const LocationPermissionView(),
    };
  }
}
