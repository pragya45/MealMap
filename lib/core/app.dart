import 'package:flutter/material.dart';
import 'package:mealmap/config/router/app_route.dart';

// Define a global navigator key
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'MealMap',
      theme: ThemeData(
        fontFamily: 'Inika',
        textTheme: const TextTheme(
          headlineSmall: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          titleMedium: TextStyle(fontSize: 16.0),
        ),
      ),
      initialRoute: AppRoute.registerRoute,
      routes: AppRoute.getApplicationRoute(),
    );
  }
}
