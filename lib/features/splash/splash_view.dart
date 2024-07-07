// import 'dart:async';

// import 'package:flutter/material.dart';

// class SplashView extends StatefulWidget {
//   const SplashView({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _SplashViewState createState() => _SplashViewState();
// }

// class _SplashViewState extends State<SplashView> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(const Duration(seconds: 3), () {
//       Navigator.of(context).pushReplacementNamed('/location');
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 14),
//           child: Center(
//             child: Image.asset(
//               'assets/images/logo.png',
//               fit: BoxFit.contain,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mealmap/config/router/app_route.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _navigateToInitialRoute();
  }

  Future<void> _navigateToInitialRoute() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.containsKey('token');

    String initialRoute = isLoggedIn ? AppRoute.homeRoute : AppRoute.locationRoute;
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed(initialRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 14),
          child: Center(
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
