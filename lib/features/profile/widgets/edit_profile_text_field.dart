import 'package:flutter/material.dart';

class EditProfileTextField extends StatelessWidget {
  final String iconPath;
  final String label;
  final String? initialValue;
  final ValueChanged<String>? onChanged;

  const EditProfileTextField({
    Key? key,
    required this.iconPath,
    required this.label,
    this.initialValue,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(iconPath, width: 24, height: 24),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
