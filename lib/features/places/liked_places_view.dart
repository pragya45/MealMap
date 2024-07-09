import 'package:flutter/material.dart';
import 'package:mealmap/http/restaurant_service.dart';

class LikedPlacesPage extends StatefulWidget {
  const LikedPlacesPage({Key? key}) : super(key: key);

  @override
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
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: Image.network(
                            restaurant['image'] ??
                                'https://via.placeholder.com/50',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            restaurant['name'] ?? 'Unknown',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          subtitle: Text(
                            restaurant['place'] ?? 'Unknown',
                            style: const TextStyle(color: Colors.red),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.favorite, color: Colors.red),
                            onPressed: () =>
                                _removeFromLiked(restaurant['_id']),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          restaurant['description'] ?? '',
                          style: const TextStyle(color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Navigate to details page
                              },
                              child: const Text('View Details'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Show map
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.orange, // Background color
                              ),
                              child: const Text('See Map'),
                            ),
                            OutlinedButton(
                              onPressed: () =>
                                  _removeFromLiked(restaurant['_id']),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.red),
                              ),
                              child: const Text(
                                'Remove',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ],
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
