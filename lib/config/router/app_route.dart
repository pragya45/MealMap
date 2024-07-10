import 'package:flutter/material.dart';
import 'package:mealmap/features/changepassword/change_password_view.dart';
import 'package:mealmap/features/detail/detail_view.dart';
import 'package:mealmap/features/discover/discover_view.dart';
import 'package:mealmap/features/home/home_view.dart';
import 'package:mealmap/features/home/widgets/category_detail_view.dart';
import 'package:mealmap/features/list/list_view.dart';
import 'package:mealmap/features/location/location_permission_view.dart';
import 'package:mealmap/features/login/login_view.dart';
import 'package:mealmap/features/onboarding/onboarding_view.dart';
import 'package:mealmap/features/places/liked_places_view.dart';
import 'package:mealmap/features/places/saved_places_view.dart';
import 'package:mealmap/features/profile/edit_profile_view.dart';
import 'package:mealmap/features/profile/profile_view.dart';
import 'package:mealmap/features/register/register_view.dart';
import 'package:mealmap/features/splash/splash_view.dart';

class AppRoute {
  AppRoute._();

  static const String splashRoute = '/splash';
  static const String locationRoute = '/location';
  static const String onboardingRoute = '/onboarding';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String homeRoute = '/home';
  static const String listRoute = '/list';
  static const String discoverRoute = '/discover';
  static const String profileRoute = '/profile';
  static const String editRoute = '/edit-profile';
  static const String detailRoute = '/detail';
  static const String changepasswordRoute = '/change-password';
  static const String categoryDetailRoute = '/category-detail';
  static const String likedRoute = '/liked';
  static const String savedRoute = '/saved';

  static Map<String, WidgetBuilder> getApplicationRoute() {
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
      editRoute: (context) => const EditProfileView(),
      changepasswordRoute: (context) => const ChangePasswordView(),
      categoryDetailRoute: (context) => CategoryDetailPage(
          categoryId: ModalRoute.of(context)!.settings.arguments as String),
      likedRoute: (context) => const LikedPlacesPage(),
      savedRoute: (context) => const SavedPlacesView(),
      detailRoute: (context) => DetailView(
          restaurant: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
    };
  }
}
