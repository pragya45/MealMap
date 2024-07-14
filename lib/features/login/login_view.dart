// import 'package:flutter/material.dart';
// import 'package:mealmap/features/home/home_view.dart';
// import 'package:mealmap/features/navbar/custom_bottom_nav_bar.dart';
// import 'package:mealmap/features/navbar/custom_toast.dart';
// import 'package:mealmap/features/navbar/custom_top_nav_bar.dart';
// import 'package:mealmap/features/register/widgets/custom_textfield_view.dart';
// import 'package:mealmap/http/auth_service.dart';

// class LoginView extends StatefulWidget {
//   const LoginView({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _LoginViewState createState() => _LoginViewState();
// }

// class _LoginViewState extends State<LoginView> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool _isLoading = false;
//   bool _showToast = false;
//   String _toastMessage = '';

//   void _login() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//     });

//     final email = _emailController.text;
//     final password = _passwordController.text;

//     try {
//       bool isLoggedIn = await AuthService.login(email, password);
//       if (isLoggedIn) {
//         _showCustomToast('Login Successful');
//         Future.delayed(const Duration(seconds: 3), () {
//           Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute(builder: (context) => const HomeView()),
//             (route) => false,
//           );
//         });
//       }
//     } catch (e) {
//       _showCustomToast('Login Failed: $e');
//     }

//     setState(() {
//       _isLoading = false;
//     });
//   }

//   void _showCustomToast(String message) {
//     setState(() {
//       _toastMessage = message;
//       _showToast = true;
//     });
//     Future.delayed(const Duration(seconds: 3), () {
//       setState(() {
//         _showToast = false;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const CustomTopNavBar(title: 'Meal Map'),
//       body: Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(25),
//             child: SingleChildScrollView(
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     CustomTextField(
//                       controller: _emailController,
//                       hintText: 'Email',
//                       iconPath: 'assets/icons/email.png',
//                       validator: (value) {
//                         if (value == null ||
//                             value.isEmpty ||
//                             !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//                           return 'Please enter a valid email';
//                         }
//                         return null;
//                       },
//                     ),
//                     CustomTextField(
//                       controller: _passwordController,
//                       hintText: 'Password',
//                       iconPath: 'assets/icons/password.png',
//                       obscureText: true,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your password';
//                         }
//                         return null;
//                       },
//                     ),
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: TextButton(
//                         onPressed: () {
//                           // Add your onPressed code here!
//                         },
//                         child: const Text(
//                           'Forgot Your Password?',
//                           style: TextStyle(color: Colors.blue),
//                         ),
//                       ),
//                     ),
//                     _isLoading
//                         ? const CircularProgressIndicator()
//                         : ElevatedButton(
//                             onPressed: _login,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor:
//                                   const Color(0xFFF29912).withOpacity(0.8),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 60, vertical: 15),
//                               minimumSize: const Size(190, 48),
//                             ),
//                             child: const Text(
//                               'Login',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.normal,
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ),
//                     const SizedBox(height: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text("Don't have an account? "),
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.pushNamed(context, '/register');
//                           },
//                           child: const Text(
//                             'Register',
//                             style: TextStyle(
//                               color: Color.fromARGB(255, 6, 130, 232),
//                               decoration: TextDecoration.underline,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 20),
//                     ElevatedButton.icon(
//                       icon: Image.asset('assets/icons/google_icons.png',
//                           height: 24),
//                       label: const Text(
//                         'Login with Google',
//                         style: TextStyle(color: Colors.black),
//                       ),
//                       onPressed: () {},
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.white,
//                         side: const BorderSide(color: Colors.black),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 90, vertical: 12),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     ElevatedButton.icon(
//                       icon: Image.asset('assets/icons/facebook_icon.png',
//                           height: 24),
//                       label: const Text(
//                         'Login with Facebook',
//                         style: TextStyle(color: Colors.black),
//                       ),
//                       onPressed: () {},
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.white,
//                         side: const BorderSide(color: Colors.black),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 90, vertical: 12),
//                       ),
//                     ),
//                     if (_showToast)
//                       Padding(
//                         padding: const EdgeInsets.only(top: 20),
//                         child: CustomToast(message: _toastMessage),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: const CustomBottomNavBar(),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:mealmap/config/router/app_route.dart';
import 'package:mealmap/features/home/home_view.dart';
import 'package:mealmap/features/navbar/custom_bottom_nav_bar.dart';
import 'package:mealmap/features/navbar/custom_toast.dart';
import 'package:mealmap/features/navbar/custom_top_nav_bar.dart';
import 'package:mealmap/features/register/widgets/custom_textfield_view.dart';
import 'package:mealmap/http/auth_service.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _showToast = false;
  String _toastMessage = '';

  void _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      bool isLoggedIn = await AuthService.login(email, password);
      if (isLoggedIn) {
        _showCustomToast('Login Successful');
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeView()),
            (route) => false,
          );
        });
      } else {
        _showCustomToast('Login Failed');
      }
    } catch (e) {
      _showCustomToast('Login Failed: $e');
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
      appBar: const CustomTopNavBar(title: 'Meal Map'),
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
                      hintText: 'Password',
                      iconPath: 'assets/icons/password.png',
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, AppRoute.forgotPasswordRoute);
                        },
                        child: const Text(
                          'Forgot Your Password?',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                    _isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: _login,
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
                            Navigator.pushNamed(context, '/register');
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
                      icon: Image.asset('assets/icons/google_icons.png',
                          height: 24),
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
                            horizontal: 90, vertical: 12),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      icon: Image.asset('assets/icons/facebook_icon.png',
                          height: 24),
                      label: const Text(
                        'Login with Facebook',
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
