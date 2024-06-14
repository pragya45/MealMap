// lib/features/home/views/home_view.dart
import 'package:flutter/material.dart';
import 'package:mealmap/features/home/widgets/category_tile.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const SearchBar(),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              padding: const EdgeInsets.all(16),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: const <Widget>[
                CategoryTile(icon: Icons.coffee, label: 'Breakfast'),
                CategoryTile(icon: Icons.lunch_dining, label: 'Lunch'),
                CategoryTile(icon: Icons.dinner_dining, label: 'Dinner'),
                CategoryTile(icon: Icons.local_bar, label: 'Drinks'),
                CategoryTile(icon: Icons.cake, label: 'Sweets'),
                CategoryTile(
                    icon: Icons.lightbulb_outline, label: 'Things to do'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
