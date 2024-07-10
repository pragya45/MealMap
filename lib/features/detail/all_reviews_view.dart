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
        backgroundColor:
            const Color.fromARGB(255, 255, 153, 0).withOpacity(0.8),
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
            return ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final review = reviews[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(review['user']['fullName'][0]),
                  ),
                  title: Text(review['comment']),
                );
              },
            );
          }
        },
      ),
    );
  }
}
