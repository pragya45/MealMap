import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mealmap/config/router/app_route.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  SplashViewState createState() => SplashViewState();
}

class SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // Wait for 2 seconds and then navigate
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, AppRoute.onboardingRoute);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 7, 41, 83),
      body: Center(
        child: Image.asset(
          'assets/images/logo1.png',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
