// import 'package:flutter/material.dart';
// import 'package:mealmap/features/detail/all_reviews_view.dart';
// import 'package:mealmap/features/detail/menu_view.dart';
// import 'package:mealmap/http/restaurant_service.dart';

// class DetailView extends StatefulWidget {
//   final Map<String, dynamic> restaurant;

//   const DetailView({Key? key, required this.restaurant}) : super(key: key);

//   @override
//   _DetailViewState createState() => _DetailViewState();
// }

// class _DetailViewState extends State<DetailView> {
//   late Map<String, dynamic> _restaurant;
//   late Future<List<dynamic>> _reviewsFuture;
//   final ScrollController _scrollController = ScrollController();
//   final TextEditingController _reviewController = TextEditingController();
//   bool isLiked = false;
//   bool isSaved = false;

//   @override
//   void initState() {
//     super.initState();
//     _restaurant = widget.restaurant;
//     _reviewsFuture = _fetchReviews();
//     _checkLikedAndSavedStatus();
//   }

//   Future<void> _checkLikedAndSavedStatus() async {
//     try {
//       bool liked =
//           await RestaurantService.isRestaurantLiked(_restaurant['_id']);
//       bool saved =
//           await RestaurantService.isRestaurantSaved(_restaurant['_id']);
//       setState(() {
//         isLiked = liked;
//         isSaved = saved;
//       });
//     } catch (e) {
//       print('Error checking liked and saved status: $e');
//     }
//   }

//   Future<List<dynamic>> _fetchReviews() async {
//     return await RestaurantService.getReviews(_restaurant['_id']);
//   }

//   void _scrollLeft() {
//     _scrollController.animateTo(
//       _scrollController.offset - 150,
//       curve: Curves.easeIn,
//       duration: const Duration(milliseconds: 300),
//     );
//   }

//   void _scrollRight() {
//     _scrollController.animateTo(
//       _scrollController.offset + 150,
//       curve: Curves.easeIn,
//       duration: const Duration(milliseconds: 300),
//     );
//   }

//   void _addReview() async {
//     if (_reviewController.text.isNotEmpty) {
//       await RestaurantService.addReview(
//         _restaurant['_id'],
//         5.0, // You can make this dynamic as needed
//         _reviewController.text,
//       );
//       setState(() {
//         _reviewsFuture = _fetchReviews();
//       });
//       _reviewController.clear();
//     }
//   }

//   void _toggleLike() async {
//     if (isLiked) {
//       await RestaurantService.unlikeRestaurant(_restaurant['_id']);
//     } else {
//       await RestaurantService.likeRestaurant(_restaurant['_id']);
//     }
//     setState(() {
//       isLiked = !isLiked;
//     });
//   }

//   void _toggleSave() async {
//     if (isSaved) {
//       await RestaurantService.unsaveRestaurant(_restaurant['_id']);
//     } else {
//       await RestaurantService.saveRestaurant(_restaurant['_id']);
//     }
//     setState(() {
//       isSaved = !isSaved;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(_restaurant['name']),
//         backgroundColor:
//             const Color.fromARGB(255, 255, 153, 0).withOpacity(0.8),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(19.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Image.network(
//                 _restaurant['image'],
//                 width: MediaQuery.of(context).size.width,
//                 height: 180,
//                 fit: BoxFit.cover,
//               ),
//               const SizedBox(height: 9),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: Text(
//                       _restaurant['description'],
//                       style: const TextStyle(fontSize: 18),
//                     ),
//                   ),
//                   IconButton(
//                     icon: Image.asset(
//                         isLiked
//                             ? 'assets/icons/love.png'
//                             : 'assets/icons/liked.png',
//                         width: 24,
//                         height: 30),
//                     onPressed: _toggleLike,
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 5),
//               Text(
//                 'opens at ${_restaurant['opening_time']} and closes at ${_restaurant['closing_time']}',
//                 style: const TextStyle(fontSize: 14, color: Colors.red),
//               ),
//               const SizedBox(height: 1),
//               Row(
//                 children: [
//                   const Icon(Icons.star, color: Colors.orange, size: 24),
//                   const Icon(Icons.star, color: Colors.orange, size: 24),
//                   const Icon(Icons.star, color: Colors.orange, size: 24),
//                   const Icon(Icons.star, color: Colors.orange, size: 24),
//                   const Icon(Icons.star_border, color: Colors.orange, size: 24),
//                   const SizedBox(width: 8),
//                   IconButton(
//                     icon: Image.asset(
//                         isSaved
//                             ? 'assets/icons/saved.png'
//                             : 'assets/icons/bookmark.png',
//                         width: 28,
//                         height: 28),
//                     onPressed: _toggleSave,
//                   ),
//                   IconButton(
//                     icon: Image.asset('assets/icons/map.png',
//                         width: 28, height: 28),
//                     onPressed: () {},
//                   ),
//                   const Spacer(),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               MenuView(restaurantId: _restaurant['_id']),
//                         ),
//                       );
//                     },
//                     child: const Text(
//                       'See Menu',
//                       style: TextStyle(
//                         decoration: TextDecoration.underline,
//                         color: Color.fromARGB(255, 40, 116, 246),
//                         fontSize: 18,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               const Text(
//                 "What's Popular Here",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
//               ),
//               const SizedBox(height: 7),
//               Row(
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.arrow_back_ios),
//                     onPressed: _scrollLeft,
//                   ),
//                   Expanded(
//                     child: SizedBox(
//                       height: 150,
//                       child: ListView(
//                         controller: _scrollController,
//                         scrollDirection: Axis.horizontal,
//                         children: [
//                           _buildPopularItem('Momo', 'assets/images/momo.png'),
//                           _buildPopularItem('Pizza', 'assets/images/pizza.png'),
//                         ],
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.arrow_forward_ios),
//                     onPressed: _scrollRight,
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 3),
//               const Text(
//                 'Reviews',
//                 style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.green),
//               ),
//               const SizedBox(height: 8),
//               FutureBuilder<List<dynamic>>(
//                 future: _reviewsFuture,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     return Center(child: Text('Error: ${snapshot.error}'));
//                   } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                     return const Center(child: Text('No reviews found'));
//                   } else {
//                     final reviews = snapshot.data!;
//                     return Column(
//                       children: reviews.take(2).map((review) {
//                         return _buildReview(
//                           review['comment'],
//                           review['user']['fullName'][0],
//                         );
//                       }).toList(),
//                     );
//                   }
//                 },
//               ),
//               const SizedBox(height: 8),
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) =>
//                           AllReviewsView(restaurantId: _restaurant['_id']),
//                     ),
//                   );
//                 },
//                 child: const Text('See All Reviews'),
//               ),
//               const SizedBox(height: 5),
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: _reviewController,
//                       decoration: const InputDecoration(
//                         hintText: 'Add review.',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   ElevatedButton(
//                     onPressed: _addReview,
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: const Color.fromARGB(255, 0, 0, 0),
//                       backgroundColor: const Color.fromARGB(255, 255, 204, 2),
//                       side:
//                           const BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
//                     ),
//                     child: const Text(
//                       'Add',
//                       style: TextStyle(color: Colors.black),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPopularItem(String name, String imagePath) {
//     return Container(
//       width: 120,
//       margin: const EdgeInsets.symmetric(horizontal: 9.0),
//       child: Column(
//         children: [
//           Image.asset(
//             imagePath,
//             width: 120,
//             height: 100,
//             fit: BoxFit.cover,
//           ),
//           const SizedBox(height: 8),
//           Text(
//             name,
//             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildReview(String review, String initial) {
//     return Row(
//       children: [
//         CircleAvatar(
//           child: Text(initial),
//         ),
//         const SizedBox(width: 8),
//         Text(review),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:mealmap/features/detail/all_reviews_view.dart';
import 'package:mealmap/features/detail/menu_view.dart';
import 'package:mealmap/http/restaurant_service.dart';

class DetailView extends StatefulWidget {
  final Map<String, dynamic> restaurant;

  const DetailView({Key? key, required this.restaurant}) : super(key: key);

  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  late Map<String, dynamic> _restaurant;
  late Future<List<dynamic>> _reviewsFuture;
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
    _checkLikedAndSavedStatus();
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

  void _scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset - 150,
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 300),
    );
  }

  void _scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset + 150,
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 300),
    );
  }

  void _addReview() async {
    if (_reviewController.text.isNotEmpty) {
      await RestaurantService.addReview(
        _restaurant['_id'],
        userRating, // Send the user's rating
        _reviewController.text,
      );
      setState(() {
        _reviewsFuture = _fetchReviews();
      });
      _reviewController.clear();
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
    return GestureDetector(
      onTap: () {
        setState(() {
          userRating = index + 1.0;
        });
      },
      child: Icon(
        index < userRating ? Icons.star : Icons.star_border,
        color: Colors.orange,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_restaurant['name']),
        backgroundColor:
            const Color.fromARGB(255, 255, 153, 0).withOpacity(0.8),
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
                        width: 24,
                        height: 30),
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
                        width: 28,
                        height: 28),
                    onPressed: _toggleSave,
                  ),
                  IconButton(
                    icon: Image.asset('assets/icons/map.png',
                        width: 28, height: 28),
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
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: _scrollLeft,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 150,
                      child: ListView(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildPopularItem('Momo', 'assets/images/momo.png'),
                          _buildPopularItem('Pizza', 'assets/images/pizza.png'),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: _scrollRight,
                  ),
                ],
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
                        return _buildReview(
                          review['comment'],
                          review['user']['fullName'][0],
                        );
                      }).toList(),
                    );
                  }
                },
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          AllReviewsView(restaurantId: _restaurant['_id']),
                    ),
                  );
                },
                child: const Text('See All Reviews'),
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
                      backgroundColor: const Color.fromARGB(255, 255, 204, 2),
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
      width: 120,
      margin: const EdgeInsets.symmetric(horizontal: 9.0),
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: 120,
            height: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
