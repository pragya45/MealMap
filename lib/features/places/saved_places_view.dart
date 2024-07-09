import 'package:flutter/material.dart';
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
                            icon: const Icon(Icons.bookmark, color: Colors.red),
                            onPressed: () =>
                                _removeFromSaved(restaurant['_id']),
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
                                  _removeFromSaved(restaurant['_id']),
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
