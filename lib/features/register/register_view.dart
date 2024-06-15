import 'package:flutter/material.dart';
import 'package:mealmap/features/navbar/custom_bottom_nav_bar.dart';
import 'package:mealmap/features/navbar/custom_top_nav_bar.dart';
import 'package:mealmap/features/register/widgets/custom_textfield_view.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomTopNavBar(title: 'Your Profile'),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomTextField(
                hintText: 'Full Name',
                iconPath: 'assets/icons/fullname.png',
              ),
              const CustomTextField(
                hintText: 'Email',
                iconPath: 'assets/icons/email.png',
              ),
              const CustomTextField(
                hintText: 'Create your password',
                iconPath: 'assets/icons/password.png',
                suffixIconPath: 'assets/icons/eye.png',
                obscureText: true,
              ),
              const CustomTextField(
                hintText: 'Confirm your password',
                iconPath: 'assets/icons/password.png',
                suffixIconPath: 'assets/icons/eye.png',
                obscureText: true,
              ),
              const SizedBox(height: 18),
              ElevatedButton(
                onPressed: () {
                  // Handle registration logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF29912), // Background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 60,
                    vertical: 15,
                  ),
                  minimumSize: const Size(190, 48), // Adjust button size
                ),
                child: const Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, '/login'); // Navigate to login page
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Color.fromARGB(255, 6, 130, 232),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: Image.asset('assets/icons/google_icons.png', height: 24),
                label: const Text('Register with Google'),
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Colors.black),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 90,
                    vertical: 12,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: Image.asset('assets/icons/facebook_icon.png', height: 24),
                label: const Text('Register with Google'),
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Colors.black),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 90,
                    vertical: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
