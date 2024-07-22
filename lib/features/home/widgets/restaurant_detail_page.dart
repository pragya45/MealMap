// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:mealmap/http/restaurant_service.dart';

// class RestaurantDetailPage extends StatefulWidget {
//   static const routeName = '/restaurant-detail';

//   const RestaurantDetailPage({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _RestaurantDetailPageState createState() => _RestaurantDetailPageState();
// }

// class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
//   late Map<String, dynamic> restaurant;
//   List<dynamic> popularItems = [];

//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration.zero, () {
//       restaurant =
//           ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
//       _fetchPopularItems();
//     });
//   }

//   Future<void> _fetchPopularItems() async {
//     try {
//       final items = await RestaurantService.getPopularItems(restaurant['_id']);
//       setState(() {
//         popularItems = items;
//       });
//     } catch (e) {
//       print('Error fetching popular items: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(restaurant['name']),
//         backgroundColor: Colors.orange,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             flex: 2,
//             child: GoogleMap(
//               initialCameraPosition: CameraPosition(
//                 target: LatLng(
//                   restaurant['latitude'],
//                   restaurant['longitude'],
//                 ),
//                 zoom: 14,
//               ),
//               markers: {
//                 Marker(
//                   markerId: MarkerId(restaurant['_id']),
//                   position: LatLng(
//                     restaurant['latitude'],
//                     restaurant['longitude'],
//                   ),
//                   infoWindow: InfoWindow(
//                     title: restaurant['name'],
//                     snippet: restaurant['place'],
//                   ),
//                 ),
//               },
//             ),
//           ),
//           Expanded(
//             flex: 3,
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     restaurant['name'],
//                     style: const TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     restaurant['description'],
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     restaurant['place'],
//                     style: const TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Rating: ${restaurant['rating']}/5',
//                     style: const TextStyle(
//                       fontSize: 16,
//                       color: Colors.red,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Opens at ${restaurant['opening_time']} and closes at ${restaurant['closing_time']}',
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                   const SizedBox(height: 8),
//                   const Text(
//                     "What's Popular Here",
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   popularItems.isNotEmpty
//                       ? Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: popularItems.map((item) {
//                             return Column(
//                               children: [
//                                 Image.network(
//                                   item['image'],
//                                   width: 150,
//                                   height: 100,
//                                   fit: BoxFit.cover,
//                                 ),
//                                 const SizedBox(height: 8),
//                                 Text(item['name']),
//                               ],
//                             );
//                           }).toList(),
//                         )
//                       : const Text('No popular items available'),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mealmap/http/restaurant_service.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/restaurant-detail';

  const RestaurantDetailPage({super.key});

  @override
  _RestaurantDetailPageState createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  late Future<Map<String, dynamic>> _restaurantFuture;
  List<dynamic> popularItems = [];

  @override
  void initState() {
    super.initState();
    _restaurantFuture = Future.delayed(Duration.zero, () {
      return ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    }).then((restaurant) {
      _fetchPopularItems(restaurant['_id']);
      return restaurant;
    });
  }

  Future<void> _fetchPopularItems(String restaurantId) async {
    try {
      final items = await RestaurantService.getPopularItems(restaurantId);
      setState(() {
        popularItems = items;
      });
    } catch (e) {
      print('Error fetching popular items: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _restaurantFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data available'));
          } else {
            final restaurant = snapshot.data!;
            return Column(
              children: [
                Expanded(
                  flex: 2,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        restaurant['latitude'],
                        restaurant['longitude'],
                      ),
                      zoom: 14,
                    ),
                    markers: {
                      Marker(
                        markerId: MarkerId(restaurant['_id']),
                        position: LatLng(
                          restaurant['latitude'],
                          restaurant['longitude'],
                        ),
                        infoWindow: InfoWindow(
                          title: restaurant['name'],
                          snippet: restaurant['place'],
                        ),
                      ),
                    },
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant['name'],
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          restaurant['description'],
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          restaurant['place'],
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Rating: ${restaurant['rating']}/5',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Opens at ${restaurant['opening_time']} and closes at ${restaurant['closing_time']}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "What's Popular Here",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        popularItems.isNotEmpty
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: popularItems.map((item) {
                                  return Column(
                                    children: [
                                      Image.network(
                                        item['image'],
                                        width: 150,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(item['name']),
                                    ],
                                  );
                                }).toList(),
                              )
                            : const Text('No popular items available'),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
