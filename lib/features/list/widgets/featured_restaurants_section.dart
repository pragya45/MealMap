import 'package:flutter/material.dart';
import 'package:mealmap/http/auth_service.dart';

class FeaturedRestaurantsSection extends StatefulWidget {
  final String searchQuery;

  const FeaturedRestaurantsSection({Key? key, required this.searchQuery})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FeaturedRestaurantsSectionState createState() =>
      _FeaturedRestaurantsSectionState();
}

class _FeaturedRestaurantsSectionState
    extends State<FeaturedRestaurantsSection> {
  final ScrollController _scrollController = ScrollController();
  late Future<List<dynamic>> _restaurantsFuture;

  @override
  void initState() {
    super.initState();
    _restaurantsFuture = AuthService.getFeaturedRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Featured Restaurants',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 220,
          child: FutureBuilder<List<dynamic>>(
            future: _restaurantsFuture,
            builder: (context, snapshot) {
              print("Snapshot connection state: ${snapshot.connectionState}");
              print("Snapshot data: ${snapshot.data}");
              print("Snapshot error: ${snapshot.error}");

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                    child: Text('No featured restaurants found'));
              } else {
                final filteredRestaurants = snapshot.data!.where((restaurant) {
                  return restaurant['name']
                          .toLowerCase()
                          .contains(widget.searchQuery.toLowerCase()) ||
                      restaurant['place']
                          .toLowerCase()
                          .contains(widget.searchQuery.toLowerCase());
                }).toList();

                return ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: filteredRestaurants.length,
                  itemBuilder: (context, index) {
                    final restaurant = filteredRestaurants[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              restaurant['image'] ?? 'assets/images/banner.png',
                              height: 140,
                              width: 180,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              restaurant['name'],
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              restaurant['place'] ?? 'Location not available',
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
