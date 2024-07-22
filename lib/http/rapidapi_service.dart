// import 'dart:convert';

// import 'package:http/http.dart' as http;

// class RapidApiService {
//   static const String apiKey =
//       '6e21659853mshd3bf3a86cda48adp13680bjsn68b7abe01a41';
//   static const String apiHost = 'map-places.p.rapidapi.com';

//   static Future<List<dynamic>> fetchNearbyRestaurants(
//       double latitude, double longitude) async {
//     final String url =
//         'https://$apiHost/restaurants/nearby?latitude=$latitude&longitude=$longitude';

//     final response = await http.get(
//       Uri.parse(url),
//       headers: {
//         'X-RapidAPI-Key': apiKey,
//         'X-RapidAPI-Host': apiHost,
//       },
//     );

//     if (response.statusCode == 200) {
//       return json.decode(response.body)[
//           'results']; // Adjust according to your API response structure
//     } else {
//       throw Exception('Failed to load nearby restaurants');
//     }
//   }
// }
