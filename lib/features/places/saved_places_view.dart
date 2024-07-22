import 'package:flutter/material.dart';
import 'package:mealmap/config/router/app_route.dart';
import 'package:mealmap/features/home/widgets/nearby_restaurants_map_page.dart';
import 'package:mealmap/http/restaurant_service.dart';

class SavedPlacesView extends StatefulWidget {
  const SavedPlacesView({Key? key}) : super(key: key);

  @override
  _SavedPlacesViewState createState() => _SavedPlacesViewState();
}

class _SavedPlacesViewState extends State<SavedPlacesView> {
  late Future<List<dynamic>> _savedRestaurantsFuture;

  @override
  void initState() {
    super.initState();
    _savedRestaurantsFuture = _fetchSavedRestaurants();
  }

  Future<List<dynamic>> _fetchSavedRestaurants() async {
    try {
      return await RestaurantService.getSavedRestaurants();
    } catch (e) {
      print('Error fetching saved restaurants: $e');
      throw Exception('Failed to load saved restaurants');
    }
  }

  void _removeFromSaved(String restaurantId) async {
    try {
      await RestaurantService.unsaveRestaurant(restaurantId);
      setState(() {
        _savedRestaurantsFuture = _fetchSavedRestaurants();
      });
    } catch (e) {
      print('Error removing restaurant from saved: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Saved Places'),
        backgroundColor: const Color(0xFFF29912),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _savedRestaurantsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No saved places to show'));
          } else {
            final savedRestaurants = snapshot.data!;
            return ListView.builder(
              itemCount: savedRestaurants.length,
              itemBuilder: (context, index) {
                final restaurant = savedRestaurants[index];
                return Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Card(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    elevation: 0,
                    margin: const EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                restaurant['image'] ??
                                    'https://via.placeholder.com/50',
                                width: 100,
                                height: 90,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${index + 1}. ${restaurant['name'] ?? 'Unknown'}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      restaurant['place'] ?? 'Unknown',
                                      style: const TextStyle(color: Colors.red),
                                    ),
                                    Text(
                                      restaurant['description'] ?? '',
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.bookmark,
                                    color: Colors.red),
                                onPressed: () =>
                                    _removeFromSaved(restaurant['_id']),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                      AppRoute.detailRoute,
                                      arguments: restaurant,
                                    );
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side:
                                        const BorderSide(color: Colors.orange),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                  ),
                                  child: const Text(
                                    'View Details',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const NearbyRestaurantsMapPage(),
                                      ),
                                    );
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side:
                                        const BorderSide(color: Colors.orange),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        'See Map',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                      const SizedBox(width: 5),
                                      Image.asset(
                                        'assets/icons/map.png',
                                        width: 20,
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () =>
                                      _removeFromSaved(restaurant['_id']),
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: Colors.red),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                  ),
                                  child: const Text(
                                    'Remove',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
