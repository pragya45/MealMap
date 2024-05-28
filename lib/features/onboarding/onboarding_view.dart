import 'package:flutter/material.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // Navigate to another screen or dismiss the onboarding
            },
            child: const Text('Skip', style: TextStyle(color: Colors.orange)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/logo.png'), // Your app's logo
            const SizedBox(height: 20),
            const Text(
              'Welcome to Meal Map',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'your guide to the best dining experiences!',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 50),
            ElevatedButton.icon(
              icon: const Icon(Icons.g_translate, color: Colors.white),
              label: const Text('Continue with Google'),
              onPressed: () {
                // Logic to handle Google sign-in
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: const Size(double.infinity, 50), // full width
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Navigate to login screen
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white, // Text color
                minimumSize: const Size(double.infinity, 50), // full width
                side: const BorderSide(color: Colors.black), // Border color
              ),
              child: const Text('Log in'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Navigate to registration screen
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white, // Text color
                minimumSize: const Size(double.infinity, 50), // full width
                side: const BorderSide(color: Colors.black), // Border color
              ),
              child: const Text('I\'m new'),
            ),
          ],
        ),
      ),
    );
  }
}
