// import 'package:flutter/material.dart';
// import 'package:mealmap/features/discover/widgets/custom_search_bar.dart';
// import 'package:mealmap/features/discover/widgets/restaurant_item.dart';
// import 'package:mealmap/features/navbar/custom_bottom_nav_bar.dart';
// import 'package:mealmap/http/auth_service.dart';

// class DiscoverView extends StatefulWidget {
//   const DiscoverView({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _DiscoverViewState createState() => _DiscoverViewState();
// }

// class _DiscoverViewState extends State<DiscoverView> {
//   late Future<List<dynamic>> _restaurantsFuture;
//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _restaurantsFuture = AuthService.getRestaurants();
//   }

//   void _searchRestaurants(String query) {
//     if (query.isEmpty) {
//       // If the search query is cleared, reset to the initial state
//       _refreshRestaurants();
//     } else {
//       setState(() {
//         _isLoading = true;
//         _restaurantsFuture = AuthService.searchRestaurants(query).then((value) {
//           setState(() {
//             _isLoading = false;
//           });
//           return value;
//         });
//       });
//     }
//   }

//   Future<void> _refreshRestaurants() async {
//     setState(() {
//       _restaurantsFuture = AuthService.getRestaurants();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.only(
//                 top: MediaQuery.of(context).padding.top + 20.0,
//                 left: 15.0,
//                 right: 15.0),
//             child: CustomSearchBar(
//               onSearch: _searchRestaurants,
//             ),
//           ),
//           Expanded(
//             child: _isLoading
//                 ? const Center(child: CircularProgressIndicator())
//                 : RefreshIndicator(
//                     onRefresh: _refreshRestaurants,
//                     child: FutureBuilder<List<dynamic>>(
//                       future: _restaurantsFuture,
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return const Center(
//                               child: CircularProgressIndicator());
//                         } else if (snapshot.hasError) {
//                           return Center(
//                               child: Text('Error: ${snapshot.error}'));
//                         } else if (!snapshot.hasData ||
//                             snapshot.data!.isEmpty) {
//                           return const Center(
//                               child: Text('No restaurants found'));
//                         } else {
//                           final restaurants = snapshot.data!;
//                           return ListView.builder(
//                             itemCount: restaurants.length,
//                             itemBuilder: (context, index) {
//                               final restaurant = restaurants[index];
//                               return RestaurantItem(
//                                 title: restaurant['name'],
//                                 subtitle: restaurant['description'],
//                                 imagePath: restaurant['image'] ??
//                                     'assets/images/banner.png',
//                               );
//                             },
//                           );
//                         }
//                       },
//                     ),
//                   ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: const CustomBottomNavBar(),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:mealmap/features/discover/widgets/custom_search_bar.dart';
import 'package:mealmap/features/discover/widgets/restaurant_item.dart';
import 'package:mealmap/features/navbar/custom_bottom_nav_bar.dart';
import 'package:mealmap/http/auth_service.dart';

class DiscoverView extends StatefulWidget {
  const DiscoverView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DiscoverViewState createState() => _DiscoverViewState();
}

class _DiscoverViewState extends State<DiscoverView> {
  late Future<List<dynamic>> _restaurantsFuture;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _restaurantsFuture = AuthService.getRestaurants();
  }

  void _searchRestaurants(String query) {
    if (query.isEmpty) {
      _refreshRestaurants();
    } else {
      setState(() {
        _isLoading = true;
        _restaurantsFuture = AuthService.searchRestaurants(query).then((value) {
          setState(() {
            _isLoading = false;
          });
          return value;
        });
      });
    }
  }

  Future<void> _refreshRestaurants() async {
    setState(() {
      _restaurantsFuture = AuthService.getRestaurants();
    });
  }

  void _loadMore() {
    // Handle "See More" button functionality here
    // For now, we'll just print a message to the console
    print('See More button pressed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 20.0,
              left: 15.0,
              right: 15.0,
              bottom: 0.0, // Reduced bottom padding to 0.0
            ),
            child: CustomSearchBar(
              onSearch: _searchRestaurants,
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: _refreshRestaurants,
                    child: FutureBuilder<List<dynamic>>(
                      future: _restaurantsFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text('No restaurants found'));
                        } else {
                          final restaurants = snapshot.data!;
                          return ListView.builder(
                            itemCount: restaurants.length +
                                1, // Add 1 for the "See More" button
                            itemBuilder: (context, index) {
                              if (index == restaurants.length) {
                                return Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                    child: Column(
                                      children: [
                                        const Icon(Icons.arrow_downward,
                                            size: 24.0),
                                        TextButton(
                                          onPressed: _loadMore,
                                          child: const Text(
                                            'See More',
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                              final restaurant = restaurants[index];
                              return RestaurantItem(
                                title: restaurant['name'],
                                subtitle: restaurant['description'],
                                imagePath: restaurant['image'] ??
                                    'assets/images/banner.png',
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
