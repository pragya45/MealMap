import 'package:flutter/material.dart';
import 'package:mealmap/http/restaurant_service.dart';

class MenuView extends StatelessWidget {
  final String restaurantId;

  const MenuView({Key? key, required this.restaurantId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        backgroundColor:
            const Color.fromARGB(255, 255, 153, 0).withOpacity(0.8),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: RestaurantService.getMenuItems(restaurantId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No menu items found'));
          } else {
            final items = snapshot.data!;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  leading: Image.network(item['image'],
                      width: 50, height: 50, fit: BoxFit.cover),
                  title: Text(item['name']),
                  subtitle: Text('\$${item['price']}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
