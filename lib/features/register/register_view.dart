import 'package:flutter/material.dart';
import 'package:mealmap/features/navbar/custom_bottom_nav_bar.dart';
import 'package:mealmap/features/navbar/custom_toast.dart';
import 'package:mealmap/features/navbar/custom_top_nav_bar.dart';
import 'package:mealmap/features/register/widgets/custom_textfield_view.dart';
import 'package:mealmap/http/auth_service.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _showToast = false;
  String _toastMessage = '';

  void _register() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final fullName = _fullNameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (password != confirmPassword) {
      setState(() {
        _isLoading = false;
      });
      _showCustomToast('Passwords do not match');
      return;
    }

    try {
      bool isRegistered = await AuthService.register(fullName, email, password);
      if (isRegistered) {
        _showCustomToast('Account Registered Successfully');
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pushNamed(context, '/login');
        });
      }
    } catch (e) {
      _showCustomToast('Registration Failed: $e');
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _showCustomToast(String message) {
    setState(() {
      _toastMessage = message;
      _showToast = true;
    });
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _showToast = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomTopNavBar(title: 'Your Profile'),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(25),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _fullNameController,
                      hintText: 'Full Name',
                      iconPath: 'assets/icons/fullname.png',
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            RegExp(r'^\d+$').hasMatch(value)) {
                          return 'Please enter a valid name';
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      controller: _emailController,
                      hintText: 'Email',
                      iconPath: 'assets/icons/email.png',
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      controller: _passwordController,
                      hintText: 'Create your password',
                      iconPath: 'assets/icons/password.png',
                      obscureText: true,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 8) {
                          return 'Password must be at least 8 characters long';
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      controller: _confirmPasswordController,
                      hintText: 'Confirm your password',
                      iconPath: 'assets/icons/password.png',
                      obscureText: true,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 18),
                    _isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: _register,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFFF29912).withOpacity(0.8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 60, vertical: 15),
                              minimumSize: const Size(190, 48),
                            ),
                            child: const Text(
                              'Register',
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
                        const Text("Already have an account? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/login');
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
                      icon: Image.asset('assets/icons/google_icons.png',
                          height: 24),
                      label: const Text(
                        'Register with Google',
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
                            horizontal: 90, vertical: 12),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      icon: Image.asset('assets/icons/facebook_icon.png',
                          height: 24),
                      label: const Text(
                        'Register with Facebook',
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
                            horizontal: 90, vertical: 12),
                      ),
                    ),
                    if (_showToast)
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: CustomToast(message: _toastMessage),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
