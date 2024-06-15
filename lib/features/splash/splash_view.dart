import 'dart:async';

import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
          width: 900, // Set the desired width
          height: 900, // Set the desired height
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
