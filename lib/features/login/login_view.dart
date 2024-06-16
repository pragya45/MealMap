import 'package:flutter/material.dart';
import 'package:mealmap/features/navbar/custom_bottom_nav_bar.dart';
import 'package:mealmap/features/navbar/custom_top_nav_bar.dart';
import 'package:mealmap/features/register/widgets/custom_textfield_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomTopNavBar(title: 'Meal Map'),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomTextField(
                hintText: 'Email',
                iconPath: 'assets/icons/email.png',
              ),
              const CustomTextField(
                hintText: 'Password',
                iconPath: 'assets/icons/password.png',
                obscureText: true,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Add your onPressed code here!
                  },
                  child: const Text(
                    'Forgot Your Password?',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/home'); // N
                  // Handle login logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF29912).withOpacity(0.8),
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
                  'Login',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, '/register'); // Navigate to register page
                    },
                    child: const Text(
                      'Register',
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
                label: const Text(
                  'Login with Google',
                  style: TextStyle(color: Colors.black),
                ),
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
                label: const Text(
                  'Login with facebook',
                  style: TextStyle(color: Colors.black),
                ),
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
