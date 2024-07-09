import 'package:flutter/material.dart';
import 'package:mealmap/features/list/widgets/featured_restaurants_section.dart';
import 'package:mealmap/features/list/widgets/liked_places_section.dart';
import 'package:mealmap/features/list/widgets/saved_places_section.dart';
import 'package:mealmap/features/navbar/custom_bottom_nav_bar.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage({Key? key}) : super(key: key);

  @override
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  final String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lists'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Show search dialog or navigate to a search page
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FeaturedRestaurantsSection(searchQuery: _searchQuery),
            const SizedBox(height: 16.0),
            SavedPlacesSection(searchQuery: _searchQuery),
            const SizedBox(height: 16.0),
            LikedPlacesSection(searchQuery: _searchQuery),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
