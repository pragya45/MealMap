import 'package:flutter/material.dart';
import 'package:mealmap/features/list/widgets/featured_restaurants_section.dart';
import 'package:mealmap/features/list/widgets/saved_places_section.dart';
import 'package:mealmap/features/navbar/custom_bottom_nav_bar.dart';
import 'package:mealmap/features/navbar/list_top_nav_bar.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  bool _isSearching = false;
  String _searchQuery = "";

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearch() {
    setState(() {
      _isSearching = false;
      _searchQuery = "";
    });
  }

  void _updateSearchQuery(String newQuery) {
    setState(() {
      _searchQuery = newQuery;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopNavBarLists(
        title: 'Lists',
        isSearching: _isSearching,
        onSearchStart: _startSearch,
        onSearchStop: _stopSearch,
        onSearchQueryChanged: _updateSearchQuery,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FeaturedRestaurantsSection(searchQuery: _searchQuery),
            const SizedBox(height: 16),
            SavedPlacesSection(searchQuery: _searchQuery),
            // Add other sections if needed
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
