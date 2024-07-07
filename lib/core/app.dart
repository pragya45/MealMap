// import 'package:flutter/material.dart';
// import 'package:mealmap/config/router/app_route.dart';

// class App extends StatelessWidget {
//   const App({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'MealMap',
//       theme: ThemeData(
//         fontFamily: 'Inika',
//       ),
//       initialRoute: AppRoute.splashRoute,
//       routes: AppRoute.getApplicationRoute(),
//     );
//   }
// }

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
