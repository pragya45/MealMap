import 'package:flutter/material.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({super.key});

  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  double _selectedRating = 0.0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filter by Rating'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Slider(
            value: _selectedRating,
            min: 0.0,
            max: 5.0,
            divisions: 10,
            label: _selectedRating.toString(),
            onChanged: (double value) {
              setState(() {
                _selectedRating = value;
              });
            },
          ),
          Text('Selected Rating: ${_selectedRating.toString()}'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(_selectedRating);
          },
          child: const Text('Apply'),
        ),
      ],
    );
  }
}
