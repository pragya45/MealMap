import 'package:flutter/material.dart';

class CustomTopNavBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomTopNavBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF29912).withOpacity(0.8),
      elevation: 0,
      leading: Container(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          'assets/images/logo1.png',
          height: 60,
          width: 60,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.normal,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Image.asset('assets/icons/notification.png', height: 24),
          onPressed: () {
            // Add your onPressed code here!
          },
        ),
        IconButton(
          icon: Image.asset('assets/icons/threedot.png', height: 24),
          onPressed: () {
            // Add your onPressed code here!
          },
        ),
      ],
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(1.0),
        child: Divider(
          height: 1.0,
          thickness: 1.0,
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
