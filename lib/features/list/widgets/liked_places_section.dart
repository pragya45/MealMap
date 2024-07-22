import 'package:flutter/material.dart';
import 'package:mealmap/config/router/app_route.dart';
import 'package:mealmap/http/restaurant_service.dart';

class LikedPlacesSection extends StatefulWidget {
  const LikedPlacesSection({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LikedPlacesSectionState createState() => _LikedPlacesSectionState();
}

class _LikedPlacesSectionState extends State<LikedPlacesSection> {
  late Future<List<dynamic>> _placesFuture;

  @override
  void initState() {
    super.initState();
    _placesFuture = RestaurantService.getLikedRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _placesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No liked places found'));
        } else {
          return SizedBox(
            height: 220, // Ensure a fixed height for the list
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final place = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      AppRoute.detailRoute,
                      arguments: place,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4.0), // Reduce padding
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            place['image'] ?? 'https://via.placeholder.com/150',
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
                          padding:
                              const EdgeInsets.only(top: 4.0), // Reduce padding
                          child: Text(
                            place['name'] ?? 'Place Name',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2.0), // Reduce padding
                          child: Text(
                            place['place'] ?? 'Location not available',
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
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
