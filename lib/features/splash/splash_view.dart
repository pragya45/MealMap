import 'dart:async';

import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/location');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width *
              1.0, // 80% of the screen width
          height: MediaQuery.of(context).size.height *
              0.4, // 40% of the screen height
          child: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit
                .contain, // This ensures that the aspect ratio of the image is maintained
          ),
        ),
      ),
    );
  }
}
