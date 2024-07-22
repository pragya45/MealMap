import 'package:flutter/material.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample data for notifications
    final List<Map<String, String>> notifications = [
      {
        'title': 'New Restaurant Added',
        'body': 'Check out the new restaurant near you!',
      },
      {
        'title': 'Discount Offer',
        'body': 'Get 20% off on your next meal!',
      },
      // Add more notifications here
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: const Color(0xFFF29912),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return ListTile(
            title: Text(notification['title']!),
            subtitle: Text(notification['body']!),
            leading: const Icon(Icons.notifications),
          );
        },
      ),
    );
  }
}
