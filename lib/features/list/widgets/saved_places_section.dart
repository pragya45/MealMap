import 'package:flutter/material.dart';
import 'package:mealmap/http/auth_service.dart';
import 'package:mealmap/http/restaurant_service.dart';

class SavedPlacesSection extends StatefulWidget {
  final String searchQuery;

  const SavedPlacesSection({Key? key, required this.searchQuery})
      : super(key: key);

  @override
  _SavedPlacesSectionState createState() => _SavedPlacesSectionState();
}

class _SavedPlacesSectionState extends State<SavedPlacesSection> {
  final ScrollController _scrollController = ScrollController();
  late Future<List<dynamic>> _placesFuture;

  @override
  void initState() {
    super.initState();
    _placesFuture = _fetchSavedPlaces();
  }

  Future<List<dynamic>> _fetchSavedPlaces() async {
    try {
      final token = await AuthService.getToken();
      if (token == null) {
        throw Exception('User not logged in');
      }
      return await RestaurantService.getSavedRestaurants();
    } catch (error) {
      print('Error fetching saved places: $error');
      rethrow;
    }
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
          return const Center(child: Text('No saved places found'));
        } else {
          final filteredPlaces = snapshot.data!.where((place) {
            return place['name']
                    .toLowerCase()
                    .contains(widget.searchQuery.toLowerCase()) ||
                place['place']
                    .toLowerCase()
                    .contains(widget.searchQuery.toLowerCase());
          }).toList();

          return ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: filteredPlaces.length,
            itemBuilder: (context, index) {
              final place = filteredPlaces[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        place['image'] ?? 'assets/images/banner.png',
                        height: 140,
                        width: 180,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        place['name'],
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        place['place'] ?? 'Location not available',
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
    );
  }
}
