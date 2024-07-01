import 'package:flutter/material.dart';

class ProfileInfoInput extends StatelessWidget {
  final String iconPath;
  final String label;
  final bool isDropdown;
  final String? dropdownValue;
  final ValueChanged<String?>? onDropdownChanged;

  const ProfileInfoInput({
    Key? key,
    required this.iconPath,
    required this.label,
    this.isDropdown = false,
    this.dropdownValue,
    this.onDropdownChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Image.asset(iconPath, height: 24, width: 24),
            const SizedBox(width: 20),
            Expanded(
              child: isDropdown
                  ? DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: dropdownValue,
                        hint: Text(label,
                            style: const TextStyle(color: Colors.black)),
                        items: <String>['Male', 'Female', 'Other']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                style: const TextStyle(color: Colors.black)),
                          );
                        }).toList(),
                        onChanged: onDropdownChanged,
                        style: const TextStyle(color: Colors.black),
                      ),
                    )
                  : TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: label,
                        hintStyle: const TextStyle(color: Colors.black),
                      ),
                      style: const TextStyle(color: Colors.black),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
