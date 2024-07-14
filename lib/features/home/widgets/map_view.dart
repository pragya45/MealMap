import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mealmap/http/rapidapi_service.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  GoogleMapController? mapController;
  final LatLng _initialPosition =
      const LatLng(27.72058, 85.32885); // Default location
  final Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _fetchNearbyRestaurants();
  }

  Future<void> _fetchNearbyRestaurants() async {
    try {
      final Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      final List<dynamic> restaurants =
          await RapidApiService.fetchNearbyRestaurants(
              position.latitude, position.longitude);

      setState(() {
        _markers.clear();
        for (var restaurant in restaurants) {
          final marker = Marker(
            markerId: MarkerId(restaurant['id'].toString()),
            position: LatLng(restaurant['location']['latitude'],
                restaurant['location']['longitude']),
            infoWindow: InfoWindow(
              title: restaurant['name'],
              snippet: restaurant['description'],
            ),
          );
          _markers.add(marker);
        }
      });
    } catch (e) {
      print('Error fetching nearby restaurants: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nearby Restaurants')),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 13.0,
        ),
        markers: _markers,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
