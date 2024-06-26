import 'package:flutter/material.dart';
import 'package:mealmap/features/home/widgets/category_tile.dart';
import 'package:mealmap/features/home/widgets/custom_search_bar.dart';
import 'package:mealmap/features/navbar/custom_bottom_nav_bar.dart';
import 'package:mealmap/http/category_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<List<dynamic>> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = CategoryService.getCategories();
  }

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
          elevation: 0,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
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
                height: MediaQuery.of(context).size.height * 0.55,
                child: FutureBuilder<List<dynamic>>(
                  future: _categoriesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No categories found'));
                    } else {
                      final categories = snapshot.data!;
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 1,
                          mainAxisSpacing: 1,
                          childAspectRatio: 3 / 4,
                        ),
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          return Stack(
                            children: [
                              CategoryTile(
                                title: category['name'],
                                imagePath:
                                    'assets/icons/${category['name'].toLowerCase()}.png',
                                onTap: () =>
                                    _navigateToPage(context, category['name']),
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
                      );
                    }
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
