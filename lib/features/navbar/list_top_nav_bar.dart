import 'package:flutter/material.dart';

class CustomTopNavBarLists extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final bool isSearching;
  final VoidCallback onSearchStart;
  final VoidCallback onSearchStop;
  final ValueChanged<String> onSearchQueryChanged;

  const CustomTopNavBarLists({
    Key? key,
    required this.title,
    required this.isSearching,
    required this.onSearchStart,
    required this.onSearchStop,
    required this.onSearchQueryChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF29912).withOpacity(0.8),
      elevation: 0,
      automaticallyImplyLeading: false,
      title: isSearching
          ? TextField(
              decoration: const InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
              ),
              autofocus: true,
              onChanged: onSearchQueryChanged,
            )
          : Row(
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
                IconButton(
                  icon: Image.asset(
                    'assets/icons/search.png',
                    height: 24,
                    color: Colors.black,
                  ),
                  onPressed: onSearchStart,
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
      actions: isSearching
          ? [
              IconButton(
                icon: const Icon(Icons.close, color: Colors.black),
                onPressed: onSearchStop,
              ),
            ]
          : [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
