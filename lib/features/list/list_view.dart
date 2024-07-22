import 'package:flutter/material.dart';
import 'package:mealmap/config/router/app_route.dart';
import 'package:mealmap/features/list/widgets/featured_restaurants_section.dart';
import 'package:mealmap/features/list/widgets/liked_places_section.dart';
import 'package:mealmap/features/list/widgets/saved_places_section.dart';
import 'package:mealmap/features/navbar/custom_bottom_nav_bar.dart';
import 'package:mealmap/features/navbar/list_top_nav_bar.dart';
import 'package:mealmap/http/auth_service.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  bool _isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  void _checkAuthentication() async {
    _isAuthenticated = await AuthService.isLoggedIn();
    if (!_isAuthenticated) {
      _showLoginDialog();
    } else {
      setState(() {});
    }
  }

  void _showLoginDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Please Login'),
        content: const Text('You need to login to access this page.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AppRoute.loginRoute);
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopNavBarLists(
        title: 'Lists',
        isSearching: false,
        onSearchStart: () {},
        onSearchStop: () {},
        onSearchQueryChanged: (query) {},
      ),
      body: _isAuthenticated
          ? SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Featured Restaurants',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  const FeaturedRestaurantsSection(),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Your Places',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'My Saved Places',
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoute.savedRoute);
                        },
                        child: const Text(
                          'See all',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                  const SavedPlacesSection(),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'My Liked Places',
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoute.likedRoute);
                        },
                        child: const Text(
                          'See all',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                  const LikedPlacesSection(),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
