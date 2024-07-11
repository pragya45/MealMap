import 'package:flutter/material.dart';
import 'package:mealmap/features/list/widgets/saved_places_section.dart';
import 'package:mealmap/features/places/liked_places_view.dart';
import 'package:mealmap/http/category_service.dart';
import 'package:mealmap/http/restaurant_service.dart';
import 'package:mealmap/http/sort_service.dart';

import 'filter_dialog.dart';

class CategoryDetailPage extends StatefulWidget {
  final String categoryId;

  const CategoryDetailPage({Key? key, required this.categoryId})
      : super(key: key);

  @override
  _CategoryDetailPageState createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  late Future<String> _categoryNameFuture;
  late Future<List<dynamic>> _restaurantsFuture;
  List<dynamic> _filteredRestaurants = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _categoryNameFuture = _fetchCategoryName();
    _restaurantsFuture = _fetchRestaurants();
  }

  Future<String> _fetchCategoryName() async {
    try {
      final category = await CategoryService.getCategoryById(widget.categoryId);
      return category['name'];
    } catch (e) {
      print('Error fetching category name: $e');
      throw Exception('Failed to load category name');
    }
  }

  Future<List<dynamic>> _fetchRestaurants() async {
    try {
      final restaurants =
          await RestaurantService.getRestaurantsByCategory(widget.categoryId);
      setState(() {
        _filteredRestaurants = restaurants;
      });
      return restaurants;
    } catch (e) {
      print('Error fetching restaurants: $e');
      throw Exception('Failed to load restaurants');
    }
  }

  void _performSearch(String query) async {
    setState(() {
      _isSearching = true;
    });

    try {
      final results = await RestaurantService.searchRestaurantsByCategory(
          widget.categoryId, query);
      setState(() {
        _filteredRestaurants = results;
      });
    } catch (e) {
      print('Error searching restaurants: $e');
      setState(() {
        _filteredRestaurants = [];
      });
    } finally {
      setState(() {
        _isSearching = false;
      });
    }
  }

  void _filterByDistance() async {
    try {
      final results = await SortService.sortByDistance(widget.categoryId);
      setState(() {
        _filteredRestaurants = results;
      });
    } catch (e) {
      print('Error filtering by distance: $e');
    }
  }

  void _filterByRating() async {
    final selectedRating = await showDialog<double>(
      context: context,
      builder: (BuildContext context) {
        return const FilterDialog();
      },
    );

    if (selectedRating != null) {
      try {
        print(
            'Filtering by rating with categoryId: ${widget.categoryId}, rating: $selectedRating');
        final results =
            await SortService.sortByRatings(widget.categoryId, selectedRating);

        // Separate the restaurants with the exact specified rating
        List<dynamic> exactRatingRestaurants = results
            .where((restaurant) => restaurant['rating'] == selectedRating)
            .toList();
        List<dynamic> otherRestaurants = results
            .where((restaurant) => restaurant['rating'] != selectedRating)
            .toList();

        // Combine the lists with exactRatingRestaurants first
        List<dynamic> sortedResults = [
          ...exactRatingRestaurants,
          ...otherRestaurants
        ];

        setState(() {
          _filteredRestaurants = sortedResults;
          print('Filtered Restaurants: $_filteredRestaurants'); // Debug print
        });
      } catch (e) {
        print('Error filtering by rating: $e');
      }
    }
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Sort by',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _filterByDistance();
                    },
                    child: const Text('Distance'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _filterByRating();
                    },
                    child: const Text('Ratings'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150.0),
        child: AppBar(
          backgroundColor: const Color(0xFFF29912).withOpacity(0.8),
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FutureBuilder<String>(
                  future: _categoryNameFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(
                          child: Text('Error loading category name'));
                    } else {
                      return Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: TextField(
                                onChanged: _performSearch,
                                decoration: InputDecoration(
                                  hintText: snapshot.data!,
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.black),
                                  ),
                                  prefixIcon: IconButton(
                                    icon: const Icon(Icons.arrow_back,
                                        color: Colors.black),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ),
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
                const SizedBox(height: 8),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.black),
                        SizedBox(width: 4),
                        Text('Near Me',
                            style:
                                TextStyle(color: Colors.black, fontSize: 16)),
                      ],
                    ),
                    Icon(Icons.map, color: Colors.black),
                  ],
                ),
                const Divider(color: Colors.black, thickness: 1),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: const Color(0xFFF29912).withOpacity(0.8),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.filter_list, color: Colors.black),
                      label: const Text('Filters'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                      ),
                      onPressed: _showFilterBottomSheet,
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.favorite, color: Colors.black),
                      label: const Text('Liked'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LikedPlacesPage()),
                        );
                      },
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.bookmark, color: Colors.black),
                      label: const Text('Saved'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SavedPlacesView()),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: _restaurantsFuture,
              builder: (context, snapshot) {
                if (_isSearching) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No restaurants found'));
                } else {
                  return ListView.builder(
                    itemCount: _filteredRestaurants.length,
                    itemBuilder: (context, index) {
                      final restaurant = _filteredRestaurants[index];
                      return Column(
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
                              '${index + 1}. ${restaurant['name'] ?? 'Unknown'}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  restaurant['place'] ?? 'Unknown',
                                  style: const TextStyle(color: Colors.red),
                                ),
                                Text(
                                  restaurant['description'] ?? '',
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                            trailing: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                restaurant['rating']?.toString() ?? 'N/A',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const Divider(),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
