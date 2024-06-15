import 'package:flutter/material.dart';
import 'package:mealmap/features/home/widgets/category_tile.dart';
import 'package:mealmap/features/home/widgets/custom_search_bar.dart';
import 'package:mealmap/features/navbar/custom_bottom_nav_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  void _navigateToPage(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryPage(title: title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          // backgroundColor: Colors.transparent,
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
              child: SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.55, // Adjust height as needed
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
                    final titles = [
                      "Breakfast",
                      "Lunch",
                      "Dinner",
                      "Drinks",
                      "Sweets",
                      "Things to do"
                    ];
                    final imagePaths = [
                      "assets/icons/breakfast.png",
                      "assets/icons/lunch.png",
                      "assets/icons/dinner.png",
                      "assets/icons/drinks.png",
                      "assets/icons/sweets.png",
                      "assets/icons/thingstodo.png"
                    ];

                    return Stack(
                      children: [
                        CategoryTile(
                          title: titles[index],
                          imagePath: imagePaths[index],
                          onTap: () => _navigateToPage(context, titles[index]),
                        ),
                        if (index < 3)
                          const Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Divider(
                              color: Colors.black,
                              height: 1,
                            ),
                          ),
                        if (index % 3 != 2)
                          const Positioned(
                            top: 0,
                            bottom: 0,
                            right: 0,
                            child: VerticalDivider(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                      ],
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

class CategoryPage extends StatelessWidget {
  final String title;

  const CategoryPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('Welcome to $title page!'),
      ),
    );
  }
}
