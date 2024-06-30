import 'package:flutter/material.dart';
import 'package:mealmap/features/discover/widgets/custom_search_bar.dart';
import 'package:mealmap/features/discover/widgets/restaurant_item.dart';
import 'package:mealmap/features/navbar/custom_bottom_nav_bar.dart';
import 'package:mealmap/http/auth_service.dart';

class DiscoverView extends StatefulWidget {
  const DiscoverView({Key? key}) : super(key: key);

  @override
  _DiscoverViewState createState() => _DiscoverViewState();
}

class _DiscoverViewState extends State<DiscoverView> {
  late Future<List<dynamic>> _restaurantsFuture;

  @override
  void initState() {
    super.initState();
    _restaurantsFuture = AuthService.getRestaurants();
  }

  void _searchRestaurants(String query) {
    setState(() {
      _restaurantsFuture = AuthService.searchRestaurants(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 17.0,
                left: 15.0,
                right: 16.0),
            child: CustomSearchBar(
              onSearch: _searchRestaurants,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: _restaurantsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No restaurants found'));
                } else {
                  final restaurants = snapshot.data!;
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: restaurants.map((restaurant) {
                          return RestaurantItem(
                            title: restaurant['name'],
                            subtitle: restaurant['description'],
                            imagePath: restaurant['image'] ??
                                'assets/images/banner.png',
                          );
                        }).toList(),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
