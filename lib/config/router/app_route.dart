import 'package:mealmap/features/discover/discover_view.dart';
import 'package:mealmap/features/home/home_view.dart';
import 'package:mealmap/features/list/list_view.dart';
import 'package:mealmap/features/location/location_permission_view.dart';
import 'package:mealmap/features/login/login_view.dart';
import 'package:mealmap/features/onboarding/onboarding_view.dart';
import 'package:mealmap/features/profile/profile_view.dart';
import 'package:mealmap/features/register/register_view.dart';
import 'package:mealmap/features/splash/splash_view.dart';

class AppRoute {
  AppRoute._();

  static const String splashRoute = '/';
  static const String locationRoute = '/location';
  static const String onboardingRoute = '/onboarding';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String homeRoute = '/home';
  static const String listRoute = '/list';
  static const String discoverRoute = '/discover';
  static const String profileRoute = '/profile';

  static getApplicationRoute() {
    return {
      splashRoute: (context) => const SplashView(),
      locationRoute: (context) => const LocationPermissionView(),
      onboardingRoute: (context) => const OnboardingView(),
      loginRoute: (context) => const LoginView(),
      registerRoute: (context) => const RegisterView(),
      homeRoute: (context) => const HomeView(),
      listRoute: (context) => const ListViewPage(),
      discoverRoute: (context) => const DiscoverView(),
      profileRoute: (context) => const ProfileView(),
    };
  }
}
