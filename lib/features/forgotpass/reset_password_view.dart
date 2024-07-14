import 'package:flutter/material.dart';
import 'package:mealmap/features/forgotpass/password_reset_sucess_view.dart';
import 'package:mealmap/features/login/widgets/custom_textfield_view.dart';
import 'package:mealmap/features/navbar/custom_toast.dart';
import 'package:mealmap/http/auth_service.dart';

class ResetPasswordView extends StatefulWidget {
  final String userId;
  final String token;

  const ResetPasswordView({
    Key? key,
    required this.userId,
    required this.token,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ResetPasswordViewState createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _showToast = false;
  String _toastMessage = '';

  void _resetPassword() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    try {
      await AuthService.resetPassword(
          widget.userId, widget.token, password, confirmPassword);
      print('Password reset successful. Navigating to success view...');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const PasswordResetSuccessView()),
      );
    } catch (e) {
      print('Error: $e');
      _showCustomToast('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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
      appBar: AppBar(
        title: const Text('Reset Password'),
        backgroundColor: const Color(0xFFF29912).withOpacity(0.8),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(25),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Please enter your new password',
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller: _passwordController,
                      hintText: 'New Password',
                      iconPath: 'assets/icons/password.png',
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your new password';
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      controller: _confirmPasswordController,
                      hintText: 'Confirm Password',
                      iconPath: 'assets/icons/password.png',
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your new password';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                            onPressed: _resetPassword,
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
                              'Reset Password',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
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
    );
  }
}
