// saved_places_section.dart
import 'package:flutter/material.dart';
import 'package:mealmap/http/restaurant_service.dart';
import 'package:mealmap/model/restaurant_model.dart';

class SavedPlacesView extends StatefulWidget {
  const SavedPlacesView({super.key});

  @override
  _SavedPlacesViewState createState() => _SavedPlacesViewState();
}

class _SavedPlacesViewState extends State<SavedPlacesView> {
  Future<List<Restaurant>>? _savedRestaurantsFuture;

  @override
  void initState() {
    super.initState();
    _savedRestaurantsFuture = fetchSavedRestaurants();
  }

  Future<List<Restaurant>> fetchSavedRestaurants() async {
    try {
      List<dynamic> data = await RestaurantService.getSavedRestaurants();
      List<Restaurant> restaurants =
          data.map((item) => Restaurant.fromJson(item)).toList();
      return restaurants;
    } catch (e) {
      print('Failed to fetch saved restaurants: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Restaurant>>(
      future: _savedRestaurantsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No saved places found'));
        } else {
          return SizedBox(
            height: 220, // Ensure a fixed height for the list
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Restaurant restaurant = snapshot.data![index];
                return YourHorizontalItemWidget(restaurant: restaurant);
              },
            ),
          );
        }
      },
    );
  }
}

class YourHorizontalItemWidget extends StatelessWidget {
  final Restaurant restaurant;

  const YourHorizontalItemWidget({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      width: 160, // Fixed width for each item
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            restaurant
                .image, // Assuming you have an image URL in your restaurant model
            width: 160,
            height: 120,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 8.0),
          Text(
            restaurant.name,
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          Text(
            restaurant.place,
            style: const TextStyle(fontSize: 14.0, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
