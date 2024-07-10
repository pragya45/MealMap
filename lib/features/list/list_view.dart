import 'package:flutter/material.dart';
import 'package:mealmap/features/list/widgets/featured_restaurants_section.dart';
import 'package:mealmap/features/list/widgets/liked_places_section.dart';
import 'package:mealmap/features/list/widgets/saved_places_section.dart';
import 'package:mealmap/features/navbar/custom_bottom_nav_bar.dart';
import 'package:mealmap/features/navbar/list_top_nav_bar.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage({Key? key}) : super(key: key);

  @override
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
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
      body: SingleChildScrollView(
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
                    Navigator.pushNamed(context, '/saved-places');
                  },
                  child: const Text('See all'),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            const SavedPlacesView(),
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
                    Navigator.pushNamed(context, '/liked-places');
                  },
                  child: const Text('See all'),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            const LikedPlacesSection(),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
