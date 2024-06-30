import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final Function(String) onSearch;

  const CustomSearchBar({Key? key, required this.onSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Search your places',
                border: InputBorder.none,
                isDense: true,
              ),
              style: const TextStyle(fontSize: 16),
              onSubmitted: onSearch,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search, size: 20),
            onPressed: () {
              onSearch(controller.text);
            },
          ),
        ],
      ),
    );
  }
}
