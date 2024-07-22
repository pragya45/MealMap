import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mealmap/features/home/widgets/restaurant_detail_page.dart';
import 'package:mealmap/http/restaurant_service.dart';

class NearbyRestaurantsMapPage extends StatefulWidget {
  const NearbyRestaurantsMapPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NearbyRestaurantsMapPageState createState() =>
      _NearbyRestaurantsMapPageState();
}

class _NearbyRestaurantsMapPageState extends State<NearbyRestaurantsMapPage> {
  late Position _currentPosition = Position(
    latitude: 0.0,
    longitude: 0.0,
    timestamp: DateTime.now(),
    accuracy: 0.0,
    altitude: 0.0,
    heading: 0.0,
    speed: 0.0,
    speedAccuracy: 0.0,
    altitudeAccuracy: 0.0,
    headingAccuracy: 0.0,
  );
  List<dynamic> _restaurants = [];
  Set<Marker> _markers = {};
  late GoogleMapController _mapController;

  @override
  void initState() {
    super.initState();
    _fetchRestaurants();
  }

  Future<void> _fetchRestaurants() async {
    try {
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = position;
      });

      final restaurants = await RestaurantService.getRestaurants();
      restaurants.sort((a, b) {
        double distanceA = Geolocator.distanceBetween(
          _currentPosition.latitude,
          _currentPosition.longitude,
          a['latitude'],
          a['longitude'],
        );
        double distanceB = Geolocator.distanceBetween(
          _currentPosition.latitude,
          _currentPosition.longitude,
          b['latitude'],
          b['longitude'],
        );
        return distanceA.compareTo(distanceB);
      });

      setState(() {
        _restaurants = restaurants;
        _markers = restaurants.map((restaurant) {
          return Marker(
            markerId: MarkerId(restaurant['_id']),
            position: LatLng(restaurant['latitude'], restaurant['longitude']),
            infoWindow: InfoWindow(
                title: restaurant['name'], snippet: restaurant['place']),
          );
        }).toSet();

        // Move the camera to the nearest restaurant
        if (restaurants.isNotEmpty) {
          _mapController.animateCamera(CameraUpdate.newLatLngZoom(
            LatLng(restaurants[0]['latitude'], restaurants[0]['longitude']),
            14,
          ));
        }
      });
    } catch (e) {
      print('Error fetching restaurants: $e');
    }
  }

  String calculateTravelTime(double distance) {
    // Assuming average walking speed is 5 km/h (83.33 m/min)
    double averageWalkingSpeed = 83.33;
    double travelTimeMinutes = distance / averageWalkingSpeed;
    int minTime = (travelTimeMinutes * 0.9).round();
    int maxTime = (travelTimeMinutes * 1.1).round();
    return '$minTime-$maxTime min';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(80.0), // Adjust the height as needed
        child: _CustomAppBar(),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3, // Increase the height of the map
            child: GoogleMap(
              onMapCreated: (controller) {
                _mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  _currentPosition.latitude,
                  _currentPosition.longitude,
                ),
                zoom: 14,
              ),
              markers: Set<Marker>.of(_markers),
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: _restaurants.length,
              itemBuilder: (context, index) {
                final restaurant = _restaurants[index];
                double distance = Geolocator.distanceBetween(
                  _currentPosition.latitude,
                  _currentPosition.longitude,
                  restaurant['latitude'],
                  restaurant['longitude'],
                );
                String travelTime = calculateTravelTime(distance);
                return ListTile(
                  leading: Image.network(
                    restaurant['image'],
                    width: 70,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    restaurant['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    restaurant['place'],
                    style: const TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${restaurant['rating']}/5',
                        style: const TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        travelTime,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RestaurantDetailPage.routeName,
                      arguments: restaurant,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          top: 50,
          left: 10,
          right: 10,
          bottom: 10), // Increase bottom padding for height
      color: const Color(0xFFF29912),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search Places Nearby',
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
