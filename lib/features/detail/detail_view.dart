import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mealmap/features/detail/all_reviews_view.dart';
import 'package:mealmap/features/detail/menu_view.dart';
import 'package:mealmap/http/restaurant_service.dart';

class DetailView extends StatefulWidget {
  final Map<String, dynamic> restaurant;

  const DetailView({Key? key, required this.restaurant}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  late Map<String, dynamic> _restaurant;
  late Future<List<dynamic>> _reviewsFuture;
  late Future<List<dynamic>> _popularItemsFuture;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _reviewController = TextEditingController();
  bool isLiked = false;
  bool isSaved = false;
  double userRating = 0.0; // User's rating

  @override
  void initState() {
    super.initState();
    _restaurant = widget.restaurant;
    _reviewsFuture = _fetchReviews();
    _popularItemsFuture = _fetchPopularItems();
    _checkLikedAndSavedStatus();
    _startAutoScroll();
  }

  Future<void> _checkLikedAndSavedStatus() async {
    try {
      bool liked =
          await RestaurantService.isRestaurantLiked(_restaurant['_id']);
      bool saved =
          await RestaurantService.isRestaurantSaved(_restaurant['_id']);
      setState(() {
        isLiked = liked;
        isSaved = saved;
      });
    } catch (e) {
      print('Error checking liked and saved status: $e');
    }
  }

  Future<List<dynamic>> _fetchReviews() async {
    return await RestaurantService.getReviews(_restaurant['_id']);
  }

  Future<List<dynamic>> _fetchPopularItems() async {
    return await RestaurantService.getPopularItems(_restaurant['_id']);
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

  void _addReview() async {
    if (_reviewController.text.isNotEmpty &&
        userRating >= 1 &&
        userRating <= 5) {
      await RestaurantService.addReview(
        _restaurant['_id'],
        userRating, // Send the user's rating
        _reviewController.text,
      );
      setState(() {
        _reviewsFuture = _fetchReviews();
      });
      _reviewController.clear();
    } else {
      // Handle invalid rating scenario (e.g., show a snackbar or dialog)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a rating between 1 and 5.'),
        ),
      );
    }
  }

  void _toggleLike() async {
    if (isLiked) {
      await RestaurantService.unlikeRestaurant(_restaurant['_id']);
    } else {
      await RestaurantService.likeRestaurant(_restaurant['_id']);
    }
    setState(() {
      isLiked = !isLiked;
    });
  }

  void _toggleSave() async {
    if (isSaved) {
      await RestaurantService.unsaveRestaurant(_restaurant['_id']);
    } else {
      await RestaurantService.saveRestaurant(_restaurant['_id']);
    }
    setState(() {
      isSaved = !isSaved;
    });
  }

  Widget _buildStar(int index) {
    final int starRating = index + 1;
    return GestureDetector(
      onTap: () {
        setState(() {
          userRating = starRating.toDouble();
        });
      },
      child: Icon(
        starRating <= userRating ? Icons.star : Icons.star_border,
        color: Colors.orange,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_restaurant['name']),
        backgroundColor: const Color(0xFFF29912),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(19.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                _restaurant['image'],
                width: MediaQuery.of(context).size.width,
                height: 180,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 9),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      _restaurant['description'],
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  IconButton(
                    icon: Image.asset(
                      isLiked
                          ? 'assets/icons/love.png'
                          : 'assets/icons/liked.png',
                      width: 30,
                      height: 34,
                    ),
                    onPressed: _toggleLike,
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                'opens at ${_restaurant['opening_time']} and closes at ${_restaurant['closing_time']}',
                style: const TextStyle(fontSize: 14, color: Colors.red),
              ),
              const SizedBox(height: 1),
              Row(
                children: [
                  Row(
                    children: List.generate(5, (index) => _buildStar(index)),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: Image.asset(
                      isSaved
                          ? 'assets/icons/saved.png'
                          : 'assets/icons/bookmark.png',
                      width: 30, // Adjust the width to ensure consistency
                      height: 34, // Adjust the height to ensure consistency
                    ),
                    onPressed: _toggleSave,
                  ),
                  IconButton(
                    icon: Image.asset('assets/icons/map.png',
                        width: 30, height: 34),
                    onPressed: () {},
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              MenuView(restaurantId: _restaurant['_id']),
                        ),
                      );
                    },
                    child: const Text(
                      'See Menu',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color.fromARGB(255, 40, 116, 246),
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                "What's Popular Here",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 7),
              FutureBuilder<List<dynamic>>(
                future: _popularItemsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No popular items found'));
                  } else {
                    final popularItems = snapshot.data!;
                    return SizedBox(
                      height: 150,
                      child: ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: popularItems.length,
                        itemBuilder: (context, index) {
                          return _buildPopularItem(
                            popularItems[index]['name'],
                            popularItems[index]['image'],
                          );
                        },
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 3),
              const Text(
                'Reviews',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
              const SizedBox(height: 8),
              FutureBuilder<List<dynamic>>(
                future: _reviewsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No reviews found'));
                  } else {
                    final reviews = snapshot.data!;
                    return Column(
                      children: reviews.take(2).map((review) {
                        final userFullName = review['user'] != null &&
                                review['user']['fullName'] != null
                            ? review['user']['fullName']
                            : 'Anonymous';
                        return _buildReview(
                          review['comment'],
                          userFullName[0],
                        );
                      }).toList(),
                    );
                  }
                },
              ),
              const SizedBox(height: 8),
              Center(
                // Center the button
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            AllReviewsView(restaurantId: _restaurant['_id']),
                      ),
                    );
                  },
                  child: const Text(
                    'See All Reviews',
                    style: TextStyle(
                      color: Color.fromARGB(
                          255, 0, 124, 225), // Set the text color to blue
                      // decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _reviewController,
                      decoration: const InputDecoration(
                        hintText: 'Add review.',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _addReview,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                      backgroundColor: const Color(0xFFF29912),
                      side:
                          const BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    child: const Text(
                      'Add',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopularItem(String name, String imagePath) {
    return Container(
      width: 160, // Adjusted width to fit 2 items on screen
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        children: [
          Container(
            width: 150,
            height: 120,
            decoration: BoxDecoration(
              border:
                  Border.all(color: Colors.black, width: 1), // Black outline
            ),
            child: Image.network(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            name,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.normal,
              color: Colors.red, // Red color for the item name
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReview(String review, String initial) {
    return Row(
      children: [
        CircleAvatar(
          child: Text(initial),
        ),
        const SizedBox(width: 8),
        Text(review),
      ],
    );
  }
}
