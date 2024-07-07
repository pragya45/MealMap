import 'package:flutter/material.dart';

class EditProfileDropdownField extends StatelessWidget {
  final String iconPath;
  final String label;
  final String? dropdownValue;
  final ValueChanged<String?>? onDropdownChanged;

  const EditProfileDropdownField({
    Key? key,
    required this.iconPath,
    required this.label,
    this.dropdownValue,
    this.onDropdownChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
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
        value: _validateDropdownValue(dropdownValue),
        items: const [
          DropdownMenuItem(value: 'Male', child: Text('Male')),
          DropdownMenuItem(value: 'Female', child: Text('Female')),
          DropdownMenuItem(value: 'Other', child: Text('Other')),
        ],
        onChanged: onDropdownChanged,
      ),
    );
  }

  String? _validateDropdownValue(String? value) {
    const validValues = ['Male', 'Female', 'Other'];
    return validValues.contains(value) ? value : null;
  }
}
