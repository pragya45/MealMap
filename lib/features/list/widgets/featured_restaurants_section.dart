import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mealmap/config/router/app_route.dart';
import 'package:mealmap/http/restaurant_service.dart';

class FeaturedRestaurantsSection extends StatefulWidget {
  const FeaturedRestaurantsSection({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FeaturedRestaurantsSectionState createState() =>
      _FeaturedRestaurantsSectionState();
}

class _FeaturedRestaurantsSectionState
    extends State<FeaturedRestaurantsSection> {
  late Future<List<dynamic>> _restaurantsFuture;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _restaurantsFuture = RestaurantService.getFeaturedRestaurants();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_scrollController.hasClients) {
        double maxScrollExtent = _scrollController.position.maxScrollExtent;
        double currentScrollPosition = _scrollController.position.pixels;
        double newScrollPosition = currentScrollPosition + 200.0;

        if (newScrollPosition >= maxScrollExtent) {
          newScrollPosition = 0.0;
        }

        _scrollController.animateTo(
          newScrollPosition,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _restaurantsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No featured restaurants found'));
        } else {
          final restaurants = snapshot.data!;
          return SizedBox(
            height: 220,
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                final restaurant = restaurants[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      AppRoute.detailRoute,
                      arguments: restaurant,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            restaurant['image'] ??
                                'https://via.placeholder.com/150',
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
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            restaurant['name'] ?? 'Restaurant Name',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(
                            restaurant['place'] ?? 'Location not available',
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
