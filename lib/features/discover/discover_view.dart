// discover_view.dart
import 'package:flutter/material.dart';
import 'package:mealmap/config/router/app_route.dart';
import 'package:mealmap/features/discover/widgets/custom_search_bar.dart';
import 'package:mealmap/features/discover/widgets/restaurant_item.dart';
import 'package:mealmap/features/navbar/custom_bottom_nav_bar.dart';
import 'package:mealmap/http/restaurant_service.dart';

class DiscoverView extends StatefulWidget {
  const DiscoverView({Key? key}) : super(key: key);

  @override
  _DiscoverViewState createState() => _DiscoverViewState();
}

class _DiscoverViewState extends State<DiscoverView> {
  late Future<List<dynamic>> _restaurantsFuture;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _restaurantsFuture = _fetchRestaurants();
  }

  Future<List<dynamic>> _fetchRestaurants() async {
    try {
      return await RestaurantService.getRestaurants();
    } catch (e) {
      print('Error fetching restaurants: $e');
      throw Exception('Failed to load restaurants');
    }
  }

  void _searchRestaurants(String query) {
    if (query.isEmpty) {
      _refreshRestaurants();
    } else {
      setState(() {
        _isLoading = true;
        _restaurantsFuture =
            RestaurantService.searchRestaurants(query).then((value) {
          setState(() {
            _isLoading = false;
          });
          return value;
        });
      });
    }
  }

  Future<void> _refreshRestaurants() async {
    setState(() {
      _restaurantsFuture = _fetchRestaurants();
    });
  }

  void _loadMore() {
    print('See More button pressed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
              child: CustomSearchBar(
                onSearch: _searchRestaurants,
              ),
            ),
            const SizedBox(height: 1),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : RefreshIndicator(
                      onRefresh: _refreshRestaurants,
                      child: FutureBuilder<List<dynamic>>(
                        future: _restaurantsFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(
                                child: Text('No restaurants found'));
                          } else {
                            final restaurants = snapshot.data!;
                            return ListView.builder(
                              itemCount: restaurants.length + 1,
                              itemBuilder: (context, index) {
                                if (index == restaurants.length) {
                                  return Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15.0),
                                      child: Column(
                                        children: [
                                          const Icon(Icons.arrow_downward,
                                              size: 24.0),
                                          TextButton(
                                            onPressed: _loadMore,
                                            child: const Text(
                                              'See More',
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                final restaurant = restaurants[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      AppRoute.detailRoute,
                                      arguments: restaurant,
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 8.0),
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: RestaurantItem(
                                      title: restaurant['name'],
                                      subtitle: restaurant['description'],
                                      imagePath: restaurant['image'] ??
                                          'assets/images/banner.png',
                                      onTap: () {},
                                    ),
                                  ),
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
