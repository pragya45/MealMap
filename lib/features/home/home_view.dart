// import 'package:flutter/material.dart';
// import 'package:mealmap/features/home/widgets/category_tile.dart';
// import 'package:mealmap/features/navbar/custom_bottom_nav_bar.dart';

// class HomeView extends StatelessWidget {
//   const HomeView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0, // No shadow
//         automaticallyImplyLeading: false, // Hides the default back button
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             Container(
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage('assets/images/banner.png'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: 'What are you looking for?',
//                   prefixIcon: const Icon(Icons.search, color: Colors.grey),
//                   filled: true,
//                   fillColor: Colors.white,
//                   border: OutlineInputBorder(
//                     borderRadius:
//                         BorderRadius.circular(0), // No rounded corners
//                     borderSide:
//                         const BorderSide(color: Colors.black), // Black border
//                   ),
//                   contentPadding:
//                       const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
//                 ),
//               ),
//             ),
//             GridView.count(
//               crossAxisCount: 2,
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               children: List.generate(6, (index) {
//                 return CategoryTile(
//                   title: [
//                     "Breakfast",
//                     "Lunch",
//                     "Dinner",
//                     "Drinks",
//                     "Sweets",
//                     "Things to do"
//                   ][index],
//                   imagePath: [
//                     "assets/icons/breakfast.png",
//                     "assets/icons/lunch.png",
//                     "assets/icons/dinner.png",
//                     "assets/icons/drinks.png",
//                     "assets/icons/sweets.png",
//                     "assets/icons/thingstodo.png"
//                   ][index],
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: const CustomBottomNavBar(),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:mealmap/features/home/widgets/category_tile.dart';
import 'package:mealmap/features/home/widgets/search_bar.dart';
import 'package:mealmap/features/navbar/custom_bottom_nav_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.asset(
              'assets/images/banner.png',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            const SizedBox(height: 10),
            const SearchBar(),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(6, (index) {
                return CategoryTile(
                  title: [
                    "Breakfast",
                    "Lunch",
                    "Dinner",
                    "Drinks",
                    "Sweets",
                    "Things to do"
                  ][index],
                  imagePath: [
                    "assets/icons/breakfast.png",
                    "assets/icons/lunch.png",
                    "assets/icons/dinner.png",
                    "assets/icons/drinks.png",
                    "assets/icons/sweets.png",
                    "assets/icons/thingstodo.png"
                  ][index],
                );
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
