import 'package:flutter/material.dart';

class LocationPermissionView extends StatelessWidget {
  const LocationPermissionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Enable Location',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                'Enable your location to find the best dining spots nearby. Whether you\'re looking for a quick bite or a fine dining experience, see the best your area has to offer right at your fingertips.',
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
            TextButton(
              onPressed: () {
                // Logic to enable location
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.orange, // Button background color
                padding: const EdgeInsets.symmetric(
                    horizontal: 50, vertical: 15), // Button padding
              ),
              child: const Text('Ok, I understand'),
            ),
          ],
        ),
      ),
    );
  }
}
