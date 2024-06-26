import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;
  final bool highlight;

  const CategoryTile({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.onTap,
    this.highlight = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 120, // Increase the height to make the icon larger
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: highlight
                    ? const Color.fromARGB(255, 0, 0, 0)
                    : const Color.fromARGB(255, 63, 32, 32),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
