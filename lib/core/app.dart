import 'package:flutter/material.dart';
import 'package:mealmap/config/router/app_route.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MealMap',
      theme: ThemeData(
        fontFamily: 'Inika', // Setting Inika as the default font for the app
        // You can add other theme settings such as primaryColor, accentColor, etc.
      ),
      initialRoute: AppRoute.splashRoute,
      routes: AppRoute.getApplicationRoute(),
    );
  }
}
