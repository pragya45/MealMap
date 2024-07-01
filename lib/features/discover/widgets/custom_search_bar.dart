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
        color: Colors.white,
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
                hintStyle: TextStyle(fontSize: 16, color: Colors.black),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.only(bottom: 9.0),
              ),
              style: const TextStyle(fontSize: 15, color: Colors.black),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search, size: 30),
            onPressed: () {
              onSearch(controller.text);
            },
          ),
        ],
      ),
    );
  }
}
