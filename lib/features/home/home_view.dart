import 'package:flutter/material.dart';
import 'package:mealmap/features/home/widgets/category_tile.dart';
import 'package:mealmap/features/home/widgets/custom_search_bar.dart';
import 'package:mealmap/features/navbar/custom_bottom_nav_bar.dart';
import 'package:mealmap/http/category_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<List<dynamic>> _categoriesFuture;
  List<dynamic> _categories = [];
  List<dynamic> _filteredCategories = [];
  bool _isSearching = false;
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _categoriesFuture = _fetchCategories();
  }

  Future<List<dynamic>> _fetchCategories() async {
    try {
      final categories = await CategoryService.getCategories();
      setState(() {
        _categories = categories;
        _filteredCategories = categories;
      });
      return categories;
    } catch (e) {
      throw Exception('Failed to fetch categories');
    }
  }

  void _performSearch(String query) {
    setState(() {
      _isSearching = true;
      _searchText = query;
      if (_searchText.isEmpty) {
        _filteredCategories = _categories;
      } else {
        _filteredCategories = _categories
            .where((category) => category['name']
                .toLowerCase()
                .contains(_searchText.toLowerCase()))
            .toList();
        if (_filteredCategories.isNotEmpty) {
          final matchedCategory = _filteredCategories.firstWhere(
              (category) => category['name']
                  .toLowerCase()
                  .contains(_searchText.toLowerCase()),
              orElse: () => null);
          if (matchedCategory != null) {
            _filteredCategories.remove(matchedCategory);
            _filteredCategories.insert(0, matchedCategory);
          }
        }
      }
      _isSearching = false;
    });
  }

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
            CustomSearchBar(onSearch: _performSearch),
            FutureBuilder<List<dynamic>>(
              future: _categoriesFuture,
              builder: (context, snapshot) {
                if (_isSearching) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No categories found'));
                } else {
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
                    itemCount: _filteredCategories.length,
                    itemBuilder: (context, index) {
                      final category = _filteredCategories[index];
                      return Stack(
                        children: [
                          CategoryTile(
                            title: category['name'],
                            imagePath:
                                'assets/icons/${category['name'].toLowerCase()}.png',
                            onTap: () {},
                            highlight: category['name']
                                .toLowerCase()
                                .contains(_searchText.toLowerCase()),
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
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
