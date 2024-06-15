import 'package:flutter/material.dart';
import 'package:mealmap/features/home/widgets/category_tile.dart';
import 'package:mealmap/features/home/widgets/custom_search_bar.dart';
import 'package:mealmap/features/home/widgets/grid_line_painter.dart';
import 'package:mealmap/features/navbar/custom_bottom_nav_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20), // Add space above the banner
            Center(
              child: Image.asset(
                'assets/images/banner.png',
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.9,
              ),
            ),
            const SizedBox(height: 10),
            const CustomSearchBar(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1.0),
              child: CustomPaint(
                painter: GridLinePainter(),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    childAspectRatio: 3 / 4,
                  ),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return CategoryTile(
                      title: [
                        "Breakfast",
                        "Lunch",
                        "Dinner",
                        "Drinks",
                        "Sweets",
                        "Things to do"
                      ][index],
                      imagePath: [
                        "assets/icons/breakfast.png",
                        "assets/icons/lunch.png",
                        "assets/icons/dinner.png",
                        "assets/icons/drinks.png",
                        "assets/icons/sweets.png",
                        "assets/icons/thingstodo.png"
                      ][index],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
