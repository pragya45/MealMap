import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mealmap/http/restaurant_service.dart';

class AllReviewsView extends StatelessWidget {
  final String restaurantId;

  const AllReviewsView({Key? key, required this.restaurantId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Reviews'),
        backgroundColor: const Color(0xFFF29912),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: RestaurantService.getReviews(restaurantId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No reviews found'));
          } else {
            final reviews = snapshot.data!;
            final Map<String, Color> userColors = {};
            final Random random = Random();

            Color getUserColor(String userId) {
              if (!userColors.containsKey(userId)) {
                userColors[userId] = Color.fromARGB(
                  255,
                  random.nextInt(256),
                  random.nextInt(256),
                  random.nextInt(256),
                );
              }
              return userColors[userId]!;
            }

            return ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final review = reviews[index];
                final user = review['user'];
                final userId = user != null ? user['_id'] : 'unknown';
                final userColor = getUserColor(userId);
                final userFullName = user != null && user['fullName'] != null
                    ? user['fullName']
                    : 'Anonymous';
                final userRating = review['rating'] ??
                    0; // Assuming 'rating' is a field in the review data

                return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 235, 230, 135)
                            .withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: userColor,
                        child: Text(
                          userFullName[0],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: List.generate(5, (starIndex) {
                                return Icon(
                                  starIndex < userRating
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Colors.orange,
                                  size: 20,
                                );
                              }),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              review['comment'] ?? '',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
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
    );
  }
}
