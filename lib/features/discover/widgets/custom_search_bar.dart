import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search your places',
                border: InputBorder.none,
                isDense: true,
              ),
              style: TextStyle(fontSize: 16),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search, size: 20),
            onPressed: () {
              // Handle search action
            },
          ),
        ],
      ),
    );
  }
}
