import 'package:flutter/material.dart';
import 'package:mealmap/features/home/widgets/category_tile.dart';
import 'package:mealmap/features/navbar/custom_bottom_nav_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Meal Map', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SearchBar(),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                CategoryTile(
                    title: "Breakfast",
                    imagePath: "assets/icons/Breakfast.png"),
                CategoryTile(
                    title: "Lunch", imagePath: "assets/icons/lunch.png"),
                CategoryTile(
                    title: "Dinner", imagePath: "assets/icons/dinner.png"),
                CategoryTile(
                    title: "Drinks", imagePath: "assets/icons/Drinks.png"),
                CategoryTile(
                    title: "Sweets", imagePath: "assets/icons/Sweets.png"),
                CategoryTile(
                    title: "Things to do",
                    imagePath: "assets/icons/thingstodo.png"),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
