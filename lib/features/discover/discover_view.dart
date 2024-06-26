import 'package:flutter/material.dart';
import 'package:mealmap/features/navbar/custom_bottom_nav_bar.dart';

import 'widgets/custom_search_bar.dart';
import 'widgets/restaurant_item.dart';

class DiscoverView extends StatelessWidget {
  const DiscoverView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 17.0,
                left: 15.0,
                right: 16.0),
            child: const CustomSearchBar(),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const RestaurantItem(
                      title: 'Spicy Dragon',
                      subtitle: 'Bold flavours of Asia in every dish.',
                      imagePath: 'assets/images/banner.png',
                    ),
                    const RestaurantItem(
                      title: 'The Vegan Bistro',
                      subtitle: 'Fresh, plant-based fare in a vibrant setting.',
                      imagePath: 'assets/images/banner.png',
                    ),
                    const RestaurantItem(
                      title: 'Gusto\'s Grill',
                      subtitle:
                          'Cozy spot for classic grills and new delights.',
                      imagePath: 'assets/images/banner.png',
                    ),
                    const SizedBox(height: 1),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle "See More" button press
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                        child: const Text(
                          'See More',
                          style:
                              TextStyle(color: Color.fromARGB(255, 6, 89, 242)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
