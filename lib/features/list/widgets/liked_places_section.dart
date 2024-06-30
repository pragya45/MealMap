import 'package:flutter/material.dart';
import 'package:mealmap/http/auth_service.dart';

class LikedPlacesSection extends StatefulWidget {
  final String searchQuery;

  const LikedPlacesSection({Key? key, required this.searchQuery})
      : super(key: key);

  @override
  _LikedPlacesSectionState createState() => _LikedPlacesSectionState();
}

class _LikedPlacesSectionState extends State<LikedPlacesSection> {
  final ScrollController _scrollController = ScrollController();
  late Future<List<dynamic>> _placesFuture;

  @override
  void initState() {
    super.initState();
    _placesFuture = AuthService.getLikedRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: AuthService.getToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError ||
            !snapshot.hasData ||
            snapshot.data == null) {
          return Container(); // Hide section if not logged in
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'My Liked Places',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.red),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to see all liked places
                    },
                    child: const Text('See all',
                        style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 220,
                child: FutureBuilder<List<dynamic>>(
                  future: _placesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No liked places found'));
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    place['image'] ??
                                        'assets/images/banner.png',
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
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
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
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
