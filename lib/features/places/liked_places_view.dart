import 'package:flutter/material.dart';
import 'package:mealmap/config/router/app_route.dart';
import 'package:mealmap/features/home/widgets/nearby_restaurants_map_page.dart';
import 'package:mealmap/http/restaurant_service.dart';

class LikedPlacesPage extends StatefulWidget {
  const LikedPlacesPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LikedPlacesPageState createState() => _LikedPlacesPageState();
}

class _LikedPlacesPageState extends State<LikedPlacesPage> {
  late Future<List<dynamic>> _likedRestaurantsFuture;

  @override
  void initState() {
    super.initState();
    _likedRestaurantsFuture = _fetchLikedRestaurants();
  }

  Future<List<dynamic>> _fetchLikedRestaurants() async {
    try {
      return await RestaurantService.getLikedRestaurants();
    } catch (e) {
      print('Error fetching liked restaurants: $e');
      throw Exception('Failed to load liked restaurants');
    }
  }

  void _removeFromLiked(String restaurantId) async {
    try {
      await RestaurantService.unlikeRestaurant(restaurantId);
      setState(() {
        _likedRestaurantsFuture = _fetchLikedRestaurants();
      });
    } catch (e) {
      print('Error removing restaurant from liked: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Liked Places'),
        backgroundColor: const Color(0xFFF29912),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _likedRestaurantsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No liked places to show'));
          } else {
            final likedRestaurants = snapshot.data!;
            return ListView.builder(
              itemCount: likedRestaurants.length,
              itemBuilder: (context, index) {
                final restaurant = likedRestaurants[index];
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
                                icon: Image.asset(
                                  'assets/icons/love.png',
                                  color: Colors.red,
                                  height: 20,
                                ),
                                onPressed: () =>
                                    _removeFromLiked(restaurant['_id']),
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
                                      _removeFromLiked(restaurant['_id']),
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
