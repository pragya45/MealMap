import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationPermissionView extends StatelessWidget {
  const LocationPermissionView({super.key});

  Future<void> _handleLocationPermission(BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Location permissions are denied'),
          ),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions. Please enable them from the settings.'),
        ),
      );
      Geolocator.openAppSettings();
      return;
    }

    // Permissions granted, proceed with the location request
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print('Location: ${position.latitude}, ${position.longitude}');

    // Navigate to the onboarding screen after getting the location
    Navigator.pushNamed(context, '/onboarding');
  }

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
            const SizedBox(height: 20),
            const Text(
              'Enable your location to find the best dining spots nearby. Whether you\'re looking for a quick bite or a fine dining experience, see the best your area has to offer right at your fingertips.',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 15,
                color: Color.fromARGB(255, 45, 45, 45),
              ),
            ),
            const SizedBox(height: 100),
            Center(
              child: Image.asset(
                'assets/images/location.png',
                height: MediaQuery.of(context).size.height *
                    0.4, // Adjust height as needed
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: OutlinedButton(
                onPressed: () {
                  _handleLocationPermission(context);
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: const Color.fromARGB(255, 252, 155, 8)
                      .withOpacity(0.8), // Updated Background color
                  side: const BorderSide(
                      color: Colors.black, width: 2), // Border color and width
                  padding: const EdgeInsets.symmetric(
                      horizontal: 100, vertical: 16), // Padding for button size
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
