//featured_restaurants
import 'package:flutter/material.dart';
import 'package:mealmap/http/restaurant_service.dart';

class FeaturedRestaurantsSection extends StatefulWidget {
  const FeaturedRestaurantsSection({Key? key}) : super(key: key);

  @override
  _FeaturedRestaurantsSectionState createState() =>
      _FeaturedRestaurantsSectionState();
}

class _FeaturedRestaurantsSectionState
    extends State<FeaturedRestaurantsSection> {
  late Future<List<dynamic>> _restaurantsFuture;

  @override
  void initState() {
    super.initState();
    _restaurantsFuture = RestaurantService.getFeaturedRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _restaurantsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No featured restaurants found'));
        } else {
          return SizedBox(
            height: 220, // Ensure a fixed height for the list
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final restaurant = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          restaurant['image'] ??
                              'https://via.placeholder.com/150',
                          height: 140,
                          width: 180,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.network(
                              'https://via.placeholder.com/150',
                              height: 140,
                              width: 180,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          restaurant['name'] ?? 'Restaurant Name',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
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
            ),
          );
        }
      },
    );
  }
}
