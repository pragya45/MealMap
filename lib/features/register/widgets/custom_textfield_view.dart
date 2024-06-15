import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final String iconPath;
  final String? suffixIconPath;

  const CustomTextField({
    Key? key,
    required this.hintText,
    this.obscureText = false,
    required this.iconPath,
    this.suffixIconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0), // Adjust padding as needed
            child: Image.asset(iconPath, height: 16, width: 16),
          ),
          suffixIcon: suffixIconPath != null
              ? GestureDetector(
                  onTap: () {
                    // Handle toggle visibility
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.all(8.0), // Adjust padding as needed
                    child: Image.asset(suffixIconPath!, height: 16, width: 16),
                  ),
                )
              : null,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
