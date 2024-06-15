import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Colors.black, width: 1)),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFFF29912),
        selectedItemColor: Colors.black,
        unselectedItemColor: const Color.fromARGB(255, 0, 0, 0),
        selectedLabelStyle: const TextStyle(color: Colors.black),
        unselectedLabelStyle: const TextStyle(color: Colors.black),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/search.png', height: 24),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/list.png', height: 24),
            label: 'Lists',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/explore.png', height: 24),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/profile.png', height: 24),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
