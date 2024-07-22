// import 'package:flutter/material.dart';
// import 'package:mealmap/features/home/widgets/nearby_restaurants_map_page.dart';
// import 'package:mealmap/features/places/liked_places_view.dart';
// import 'package:mealmap/features/places/saved_places_view.dart';
// import 'package:mealmap/http/category_service.dart';
// import 'package:mealmap/http/restaurant_service.dart';
// import 'package:mealmap/http/sort_service.dart';

// class CategoryDetailPage extends StatefulWidget {
//   final String categoryId;

//   const CategoryDetailPage({Key? key, required this.categoryId})
//       : super(key: key);

//   @override
//   _CategoryDetailPageState createState() => _CategoryDetailPageState();
// }

// class _CategoryDetailPageState extends State<CategoryDetailPage> {
//   late Future<String> _categoryNameFuture;
//   late Future<List<dynamic>> _restaurantsFuture;
//   List<dynamic> _filteredRestaurants = [];
//   bool _isSearching = false;
//   bool _isFiltering = false;
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   void initState() {
//     super.initState();
//     _categoryNameFuture = _fetchCategoryName();
//     _restaurantsFuture = _fetchRestaurants();
//   }

//   Future<String> _fetchCategoryName() async {
//     try {
//       final category = await CategoryService.getCategoryById(widget.categoryId);
//       return category['name'];
//     } catch (e) {
//       print('Error fetching category name: $e');
//       throw Exception('Failed to load category name');
//     }
//   }

//   Future<List<dynamic>> _fetchRestaurants() async {
//     try {
//       final restaurants =
//           await RestaurantService.getRestaurantsByCategory(widget.categoryId);
//       if (mounted) {
//         setState(() {
//           _filteredRestaurants = restaurants;
//         });
//       }
//       return restaurants;
//     } catch (e) {
//       print('Error fetching restaurants: $e');
//       throw Exception('Failed to load restaurants');
//     }
//   }

//   void _performSearch(String query) async {
//     setState(() {
//       _isSearching = true;
//     });

//     try {
//       final results = await RestaurantService.searchRestaurantsByCategory(
//           widget.categoryId, query);
//       if (mounted) {
//         setState(() {
//           _filteredRestaurants = results;
//         });
//       }
//     } catch (e) {
//       print('Error searching restaurants: $e');
//       if (mounted) {
//         setState(() {
//           _filteredRestaurants = [];
//         });
//       }
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isSearching = false;
//         });
//       }
//     }
//   }

//   void _filterByDistance(String order) async {
//     setState(() {
//       _isFiltering = true;
//     });

//     try {
//       double latitude = 27.7; // Replace with actual latitude
//       double longitude = 85.3; // Replace with actual longitude
//       final results = await SortService.getRestaurantsSortedByDistance(
//           widget.categoryId, latitude, longitude, order);
//       if (mounted) {
//         setState(() {
//           _filteredRestaurants = results;
//         });
//       }
//     } catch (e) {
//       print('Error sorting by distance: $e');
//       if (mounted) {
//         setState(() {
//           _filteredRestaurants = [];
//         });
//       }
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isFiltering = false;
//         });
//       }
//     }
//   }

//   void _filterByRating(double rating) async {
//     setState(() {
//       _isFiltering = true;
//     });

//     try {
//       final results = await SortService.getRestaurantsSortedByRatings(
//           widget.categoryId, rating);
//       if (mounted) {
//         setState(() {
//           _filteredRestaurants = results;
//         });
//       }
//     } catch (e) {
//       print('Error sorting by rating: $e');
//       if (mounted) {
//         setState(() {
//           _filteredRestaurants = _filteredRestaurants
//             ..sort((a, b) {
//               final ratingA = a['rating'] ?? 0.0;
//               final ratingB = b['rating'] ?? 0.0;
//               return ratingB.compareTo(ratingA);
//             });
//         });
//       }
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isFiltering = false;
//         });
//       }
//     }
//   }

//   void _openFilterDrawer() {
//     _scaffoldKey.currentState?.openEndDrawer();
//   }

//   void _showDistanceOptions() {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return Container(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text('Sort by Distance',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                       _filterByDistance('asc'); // Nearest
//                     },
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: const Color.fromARGB(255, 255, 252, 252),
//                       backgroundColor: Colors.blue,
//                       textStyle: const TextStyle(fontSize: 16),
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 20, vertical: 10),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: const Text('Nearest'),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                       _filterByDistance('desc'); // Farthest
//                     },
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.black,
//                       backgroundColor: Colors.grey,
//                       textStyle: const TextStyle(fontSize: 16),
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 20, vertical: 10),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: const Text('Farthest'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void _showRatingInputDialog() {
//     final TextEditingController ratingController = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Enter Rating'),
//           content: TextField(
//             controller: ratingController,
//             keyboardType: TextInputType.number,
//             decoration: const InputDecoration(hintText: 'Enter rating (1-5)'),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 final rating = double.tryParse(ratingController.text);
//                 if (rating != null && rating >= 1 && rating <= 5) {
//                   Navigator.pop(context);
//                   _filterByRating(rating);
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       content:
//                           Text('Please enter a valid rating between 1 and 5.'),
//                     ),
//                   );
//                 }
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       endDrawer: _buildFilterDrawer(),
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(150.0),
//         child: AppBar(
//           backgroundColor: const Color(0xFFF29912),
//           elevation: 0,
//           iconTheme: const IconThemeData(color: Colors.white),
//           automaticallyImplyLeading: false,
//           flexibleSpace: Padding(
//             padding:
//                 const EdgeInsets.symmetric(horizontal: 14.0, vertical: 20.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 FutureBuilder<String>(
//                   future: _categoryNameFuture,
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Center(child: CircularProgressIndicator());
//                     } else if (snapshot.hasError) {
//                       return const Center(
//                           child: Text('Error loading category name'));
//                     } else {
//                       return Row(
//                         children: [
//                           Expanded(
//                             child: SizedBox(
//                               height: 70,
//                               child: TextField(
//                                 onChanged: _performSearch,
//                                 decoration: InputDecoration(
//                                   hintText: snapshot.data!,
//                                   filled: true,
//                                   fillColor: Colors.white,
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide:
//                                         const BorderSide(color: Colors.black),
//                                   ),
//                                   prefixIcon: IconButton(
//                                     icon: const Icon(Icons.arrow_back,
//                                         color: Colors.black),
//                                     onPressed: () => Navigator.pop(context),
//                                   ),
//                                 ),
//                                 style: const TextStyle(color: Colors.black),
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     }
//                   },
//                 ),
//                 const SizedBox(height: 8),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(right: 8.0),
//                           child: GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         const NearbyRestaurantsMapPage()),
//                               );
//                             },
//                             child: Row(
//                               children: [
//                                 Image.asset('assets/icons/arrow.png',
//                                     width: 20, height: 25),
//                                 const SizedBox(width: 4),
//                                 const Text('Near Me',
//                                     style: TextStyle(
//                                         color: Colors.black, fontSize: 16)),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const Spacer(),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 35.0),
//                       child: Image.asset('assets/icons/map.png',
//                           width: 20, height: 25),
//                     ),
//                   ],
//                 ),
//                 const Divider(
//                   color: Colors.black,
//                   thickness: 1,
//                   indent: 16,
//                   endIndent: 16,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           Container(
//             color: const Color(0xFFF29912),
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     ElevatedButton.icon(
//                       icon: Image.asset('assets/icons/filters.png',
//                           width: 20, height: 20),
//                       label: const Text('Filters'),
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.black,
//                         backgroundColor: Colors.white,
//                       ),
//                       onPressed: _openFilterDrawer,
//                     ),
//                     ElevatedButton.icon(
//                       icon: Image.asset('assets/icons/liked.png',
//                           width: 20, height: 20),
//                       label: const Text('Liked'),
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.black,
//                         backgroundColor: Colors.white,
//                       ),
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const LikedPlacesPage()),
//                         );
//                       },
//                     ),
//                     ElevatedButton.icon(
//                       icon: Image.asset('assets/icons/saved.png',
//                           width: 20, height: 20),
//                       label: const Text('Saved'),
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.black,
//                         backgroundColor: Colors.white,
//                       ),
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const SavedPlacesView()),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),
//               ],
//             ),
//           ),
//           Expanded(
//             child: _isFiltering
//                 ? const Center(child: CircularProgressIndicator())
//                 : FutureBuilder<List<dynamic>>(
//                     future: _restaurantsFuture,
//                     builder: (context, snapshot) {
//                       if (_isSearching) {
//                         return const Center(child: CircularProgressIndicator());
//                       } else if (snapshot.connectionState ==
//                           ConnectionState.waiting) {
//                         return const Center(child: CircularProgressIndicator());
//                       } else if (snapshot.hasError) {
//                         return Center(child: Text('Error: ${snapshot.error}'));
//                       } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                         return const Center(
//                             child: Text('No restaurants found'));
//                       } else {
//                         return ListView.builder(
//                           itemCount: _filteredRestaurants.length,
//                           itemBuilder: (context, index) {
//                             final restaurant = _filteredRestaurants[index];
//                             return Column(
//                               children: [
//                                 ListTile(
//                                   leading: ClipRRect(
//                                     borderRadius: BorderRadius.circular(8.0),
//                                     child: Image.network(
//                                       restaurant['image'] ??
//                                           'https://via.placeholder.com/150',
//                                       height: 60,
//                                       width: 60,
//                                       fit: BoxFit.cover,
//                                       errorBuilder:
//                                           (context, error, stackTrace) {
//                                         return Image.network(
//                                           'https://via.placeholder.com/150',
//                                           height: 60,
//                                           width: 60,
//                                           fit: BoxFit.cover,
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                   title: Text(
//                                     '${index + 1}. ${restaurant['name'] ?? 'Unknown'}',
//                                     style: const TextStyle(
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                   subtitle: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         restaurant['place'] ?? 'Unknown',
//                                         style:
//                                             const TextStyle(color: Colors.red),
//                                       ),
//                                       Text(
//                                         restaurant['description'] ?? '',
//                                         style: const TextStyle(
//                                             color: Colors.black),
//                                       ),
//                                     ],
//                                   ),
//                                   trailing: Container(
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: 4, horizontal: 8),
//                                     decoration: BoxDecoration(
//                                       color: const Color(0xFFE0FFD5),
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                     child: Text(
//                                       restaurant['rating']?.toString() ?? 'N/A',
//                                       style: const TextStyle(
//                                         color: Colors.red,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 const Divider(
//                                     color: Color.fromARGB(255, 255, 253, 253)),
//                               ],
//                             );
//                           },
//                         );
//                       }
//                     },
//                   ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFilterDrawer() {
//     return Drawer(
//       child: Container(
//         padding: const EdgeInsets.all(50.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Image.asset('assets/icons/sort.png', width: 20, height: 20),
//                 const SizedBox(width: 9),
//                 const Text('Sort by',
//                     style:
//                         TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               ],
//             ),
//             const Divider(),
//             const SizedBox(height: 9),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                     _showDistanceOptions();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     foregroundColor: Colors.white,
//                     backgroundColor: Colors.blue,
//                     textStyle: const TextStyle(fontSize: 16),
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 20, vertical: 10),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: const Text('Distance'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                     _showRatingInputDialog();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     foregroundColor: Colors.black,
//                     backgroundColor: Colors.white,
//                     textStyle: const TextStyle(fontSize: 16),
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 20, vertical: 10),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: const Text('Ratings'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mealmap/features/home/widgets/nearby_restaurants_map_page.dart';
import 'package:mealmap/features/places/liked_places_view.dart';
import 'package:mealmap/features/places/saved_places_view.dart';
import 'package:mealmap/http/category_service.dart';
import 'package:mealmap/http/restaurant_service.dart';
import 'package:mealmap/http/sort_service.dart';

class CategoryDetailPage extends StatefulWidget {
  final String categoryId;

  const CategoryDetailPage({Key? key, required this.categoryId})
      : super(key: key);

  @override
  _CategoryDetailPageState createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  String _categoryName = '';
  List<dynamic> _filteredRestaurants = [];
  bool _isError = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      await Future.wait([_fetchCategoryName(), _fetchRestaurants()]);
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isError = true;
        });
      }
      print('Error fetching data: $e');
    }
  }

  Future<void> _fetchCategoryName() async {
    try {
      final category = await CategoryService.getCategoryById(widget.categoryId);
      if (mounted) {
        setState(() {
          _categoryName = category['name'];
        });
      }
    } catch (e) {
      print('Error fetching category name: $e');
      throw Exception('Failed to load category name');
    }
  }

  Future<void> _fetchRestaurants() async {
    try {
      final restaurants =
          await RestaurantService.getRestaurantsByCategory(widget.categoryId);
      if (mounted) {
        setState(() {
          _filteredRestaurants = restaurants;
        });
      }
    } catch (e) {
      print('Error fetching restaurants: $e');
      throw Exception('Failed to load restaurants');
    }
  }

  void _performSearch(String query) async {
    setState(() {
    });

    try {
      final results = await RestaurantService.searchRestaurantsByCategory(
          widget.categoryId, query);
      if (mounted) {
        setState(() {
          _filteredRestaurants = results;
        });
      }
    } catch (e) {
      print('Error searching restaurants: $e');
      if (mounted) {
        setState(() {
          _filteredRestaurants = [];
        });
      }
    } finally {
      if (mounted) {
        setState(() {
        });
      }
    }
  }

  Future<void> _filterByDistance(String order) async {
    setState(() {
    });

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      double latitude = position.latitude;
      double longitude = position.longitude;

      _filteredRestaurants.sort((a, b) {
        double distanceA = Geolocator.distanceBetween(
          latitude,
          longitude,
          a['latitude'],
          a['longitude'],
        );
        double distanceB = Geolocator.distanceBetween(
          latitude,
          longitude,
          b['latitude'],
          b['longitude'],
        );

        if (order == 'asc') {
          return distanceA.compareTo(distanceB);
        } else {
          return distanceB.compareTo(distanceA);
        }
      });

      setState(() {
        _filteredRestaurants = _filteredRestaurants;
      });
    } catch (e) {
      print('Error sorting by distance: $e');
      setState(() {
        _filteredRestaurants = [];
      });
    } finally {
      if (mounted) {
        setState(() {
        });
      }
    }
  }

  void _filterByRating(double rating) async {
    setState(() {
    });

    try {
      final results = await SortService.getRestaurantsSortedByRatings(
          widget.categoryId, rating);
      if (mounted) {
        setState(() {
          _filteredRestaurants = results;
        });
      }
    } catch (e) {
      print('Error sorting by rating: $e');
      if (mounted) {
        setState(() {
          _filteredRestaurants = _filteredRestaurants
            ..sort((a, b) {
              final ratingA = a['rating'] ?? 0.0;
              final ratingB = b['rating'] ?? 0.0;
              return ratingB.compareTo(ratingA);
            });
        });
      }
    } finally {
      if (mounted) {
        setState(() {
        });
      }
    }
  }

  void _openFilterDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  void _showDistanceOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Sort by Distance',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _filterByDistance('asc'); // Nearest
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 255, 252, 252),
                      backgroundColor: Colors.blue,
                      textStyle: const TextStyle(fontSize: 16),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Nearest'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _filterByDistance('desc'); // Farthest
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.grey,
                      textStyle: const TextStyle(fontSize: 16),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Farthest'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showRatingInputDialog() {
    final TextEditingController ratingController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter Rating'),
          content: TextField(
            controller: ratingController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: 'Enter rating (1-5)'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final rating = double.tryParse(ratingController.text);
                if (rating != null && rating >= 1 && rating <= 5) {
                  Navigator.pop(context);
                  _filterByRating(rating);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Please enter a valid rating between 1 and 5.'),
                    ),
                  );
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _buildFilterDrawer(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150.0),
        child: AppBar(
          backgroundColor: const Color(0xFFF29912),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          automaticallyImplyLeading: false,
          flexibleSpace: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 14.0, vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 70,
                        child: TextField(
                          onChanged: _performSearch,
                          decoration: InputDecoration(
                            hintText: _categoryName.isEmpty
                                ? 'Loading...'
                                : _categoryName,
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.black),
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
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const NearbyRestaurantsMapPage()),
                        );
                      },
                      child: Row(
                        children: [
                          Image.asset('assets/icons/arrow.png',
                              width: 20, height: 25),
                          const SizedBox(width: 4),
                          const Text('Near Me',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16)),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(left: 35.0),
                      child: Image.asset('assets/icons/map.png',
                          width: 20, height: 25),
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.black,
                  thickness: 1,
                  indent: 16,
                  endIndent: 16,
                ),
              ],
            ),
          ),
        ),
      ),
      body: _isError
          ? const Center(child: Text('Error fetching data'))
          : Column(
              children: [
                Container(
                  color: const Color(0xFFF29912),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            icon: Image.asset('assets/icons/filters.png',
                                width: 20, height: 20),
                            label: const Text('Filters'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black,
                              backgroundColor: Colors.white,
                              alignment:
                                  Alignment.centerLeft, // Align icon with text
                            ),
                            onPressed: _openFilterDrawer,
                          ),
                          ElevatedButton.icon(
                            icon: Image.asset('assets/icons/liked.png',
                                width: 20, height: 20),
                            label: const Text('Liked'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black,
                              backgroundColor: Colors.white,
                              alignment:
                                  Alignment.centerLeft, // Align icon with text
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const LikedPlacesPage()),
                              );
                            },
                          ),
                          ElevatedButton.icon(
                            icon: Image.asset('assets/icons/saved.png',
                                width: 20, height: 20),
                            label: const Text('Saved'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black,
                              backgroundColor: Colors.white,
                              alignment:
                                  Alignment.centerLeft, // Align icon with text
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SavedPlacesView()),
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
                  child: ListView.builder(
                    itemCount: _filteredRestaurants.length,
                    itemBuilder: (context, index) {
                      final restaurant = _filteredRestaurants[index];
                      return Column(
                        children: [
                          ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                restaurant['image'] ??
                                    'https://via.placeholder.com/150',
                                height: 60,
                                width: 60,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.network(
                                    'https://via.placeholder.com/150',
                                    height: 60,
                                    width: 60,
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
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
                                color: const Color(0xFFE0FFD5),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                restaurant['rating']?.toString() ?? 'N/A',
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const Divider(
                              color: Color.fromARGB(255, 255, 253, 253)),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildFilterDrawer() {
    return Drawer(
      child: Container(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset('assets/icons/sort.png', width: 20, height: 20),
                const SizedBox(width: 9),
                const Text('Sort by',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const Divider(),
            const SizedBox(height: 9),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _showDistanceOptions();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    textStyle: const TextStyle(fontSize: 16),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Distance'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _showRatingInputDialog();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 16),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Ratings'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
