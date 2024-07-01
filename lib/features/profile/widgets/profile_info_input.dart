// import 'package:flutter/material.dart';

// class ProfileInfoInput extends StatelessWidget {
//   final String iconPath;
//   final String label;
//   final bool isDropdown;
//   final String? dropdownValue;
//   final ValueChanged<String>? onChanged;
//   final ValueChanged<String?>? onDropdownChanged;
//   final String? initialValue;

//   const ProfileInfoInput({
//     Key? key,
//     required this.iconPath,
//     required this.label,
//     this.isDropdown = false,
//     this.dropdownValue,
//     this.onChanged,
//     this.onDropdownChanged,
//     this.initialValue,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Image.asset(iconPath, width: 24, height: 24),
//         const SizedBox(width: 10),
//         Expanded(
//           child: isDropdown
//               ? DropdownButtonFormField<String>(
//                   decoration: InputDecoration(
//                     labelText: label,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   value: dropdownValue,
//                   items: const [
//                     DropdownMenuItem(value: 'Male', child: Text('Male')),
//                     DropdownMenuItem(value: 'Female', child: Text('Female')),
//                     DropdownMenuItem(value: 'Other', child: Text('Other')),
//                   ],
//                   onChanged: onDropdownChanged,
//                 )
//               : TextFormField(
//                   initialValue: initialValue,
//                   decoration: InputDecoration(
//                     labelText: label,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   onChanged: onChanged,
//                 ),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';

class ProfileInfoInput extends StatelessWidget {
  final String iconPath;
  final String label;
  final bool isDropdown;
  final String? dropdownValue;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String?>? onDropdownChanged;
  final String? initialValue;

  const ProfileInfoInput({
    Key? key,
    required this.iconPath,
    required this.label,
    this.isDropdown = false,
    this.dropdownValue,
    this.onChanged,
    this.onDropdownChanged,
    this.initialValue,
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
