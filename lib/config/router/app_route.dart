
import 'package:mealmap/features/splash/splash_view.dart';

class AppRoute {
  AppRoute._();

  static const String splashRoute = '/';
  static const String onboardingRoute = '/onboarding';


  static getApplicationRoute() {
    return {
      splashRoute: (context) => const SplashView(),
     
    };
  }
}
