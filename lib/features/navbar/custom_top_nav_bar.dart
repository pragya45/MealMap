import 'package:flutter/material.dart';

class CustomTopNavBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomTopNavBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF29912),
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment:
            CrossAxisAlignment.center, // Aligns items vertically
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 1, top: 25.0),
                child: Image.asset(
                  'assets/images/logo1.png',
                  height: 120,
                  width: 120,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ),
          Row(
            children: [
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
          ),
        ],
      ),
      centerTitle: true,
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
