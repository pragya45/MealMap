import 'package:flutter/material.dart';

class LocationPermissionView extends StatelessWidget {
  const LocationPermissionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Enable Location',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 9),
            const Text(
              'Enable your location to find the best dining spots nearby. Whether you\'re looking for a quick bite or a fine dining experience, see the best your area has to offer right at your fingertips.',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 15,
                color: Color.fromARGB(255, 107, 104, 104),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Image.asset(
                  'assets/images/location.png'), // Ensure your image asset path is correct
            ),
            const SizedBox(height: 60),
            Center(
              child: OutlinedButton(
                onPressed: () {
                  // Navigate to the onboarding screen
                  Navigator.pushNamed(context, '/onboarding');
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: const Color.fromARGB(
                      255, 246, 184, 90), // Background color
                  side: const BorderSide(
                      color: Colors.black, width: 2), // Border color and width
                  padding: const EdgeInsets.symmetric(
                      horizontal: 80, vertical: 18), // Padding for button size
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Corner roundness
                  ),
                ),
                child: const Text(
                  'Ok, I understand',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
