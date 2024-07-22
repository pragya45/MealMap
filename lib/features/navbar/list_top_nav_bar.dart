// custom_top_nav_bar.dart

import 'package:flutter/material.dart';

class CustomTopNavBarLists extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;

  const CustomTopNavBarLists({
    Key? key,
    required this.title,
    required Null Function(dynamic query) onSearchQueryChanged,
    required Null Function() onSearchStop,
    required bool isSearching,
    required Null Function() onSearchStart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF29912),
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(1.0),
        child: Divider(
          height: 1.0,
          thickness: 1.0,
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
