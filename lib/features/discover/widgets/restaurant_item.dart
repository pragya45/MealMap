import 'package:flutter/material.dart';

class RestaurantItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final VoidCallback onTap;

  const RestaurantItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: Image.network(
                imagePath,
                width: MediaQuery.of(context).size.width - 40, // Adjusted width
                height: 150, // Adjusted height
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/banner.png',
                    width: MediaQuery.of(context).size.width - 40,
                    height: 130,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16, // Adjusted font size
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 142, 17, 9),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 14, // Adjusted font size
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
