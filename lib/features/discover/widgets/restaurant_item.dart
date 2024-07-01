import 'package:flutter/material.dart';

class RestaurantItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;

  const RestaurantItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(0), // Rounded corners
              child: Image.network(
                imagePath,
                width: MediaQuery.of(context).size.width - 60, // Smaller width
                height: 150, // Adjust height
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/banner.png', // Fallback image asset
                    width:
                        MediaQuery.of(context).size.width - 60, // Smaller width
                    height: 150,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 20), // Adjusted horizontal padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17, // Adjust font size
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 142, 17, 9), // Adjust color
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 15, // Adjust font size
                    color: Colors.black, // Adjust color
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
