import 'package:flutter/material.dart';

class SavedPlacesSection extends StatefulWidget {
  final String searchQuery;

  const SavedPlacesSection({Key? key, required this.searchQuery})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SavedPlacesSectionState createState() => _SavedPlacesSectionState();
}

class _SavedPlacesSectionState extends State<SavedPlacesSection> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> places = [
      {'name': 'Garden of Dreams', 'location': 'Kathmandu, Nepal'},
      {'name': 'Garden of Dreams', 'location': 'Kathmandu, Nepal'},
      // Add more places here
    ];

    final filteredPlaces = places
        .where((place) =>
            place['name']!
                .toLowerCase()
                .contains(widget.searchQuery.toLowerCase()) ||
            place['location']!
                .toLowerCase()
                .contains(widget.searchQuery.toLowerCase()))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your Places',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'My Saved Places',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.red),
            ),
            TextButton(
              onPressed: () {
                // Navigate to see all saved places
              },
              child:
                  const Text('See all', style: TextStyle(color: Colors.blue)),
            ),
          ],
        ),
        SizedBox(
          height: 220, // Adjust the height to better fit your design
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: filteredPlaces.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/images/banner.png', // Ensure the correct image path
                        height: 140,
                        width: 180,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Garden of Dreams',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        'Kathmandu, Nepal',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
