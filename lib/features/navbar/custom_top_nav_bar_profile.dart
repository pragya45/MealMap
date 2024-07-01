// // import 'package:flutter/material.dart';

// // class CustomTopNavBarProfile extends StatelessWidget
// //     implements PreferredSizeWidget {
// //   final String title;
// //   final VoidCallback onBackPressed;
// //   final VoidCallback onEditPressed;
// //   final VoidCallback onNotificationPressed;

// //   const CustomTopNavBarProfile({
// //     Key? key,
// //     required this.title,
// //     required this.onBackPressed,
// //     required this.onEditPressed,
// //     required this.onNotificationPressed,
// //   }) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return AppBar(
// //       backgroundColor: const Color(0xFFF29912).withOpacity(0.8),
// //       title: Text(
// //         title,
// //         style: const TextStyle(color: Colors.black),
// //       ),
// //       leading: IconButton(
// //         icon: const Icon(Icons.arrow_back, color: Colors.black),
// //         onPressed: onBackPressed,
// //       ),
// //       actions: [
// //         IconButton(
// //           icon: SizedBox(
// //             height: 28,
// //             width: 30,
// //             child: Image.asset('assets/icons/notification.png'),
// //           ),
// //           onPressed: onNotificationPressed,
// //         ),
// //         IconButton(
// //           icon: SizedBox(
// //             height: 24,
// //             width: 24,
// //             child: Image.asset('assets/icons/edit.png'),
// //           ),
// //           onPressed: onEditPressed,
// //         ),
// //       ],
// //       bottom: const PreferredSize(
// //         preferredSize: Size.fromHeight(1.0),
// //         child: Divider(
// //           height: 1.0,
// //           thickness: 1.0,
// //           color: Colors.black,
// //         ),
// //       ),
// //     );
// //   }

// //   @override
// //   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// // }
// import 'package:flutter/material.dart';

// class CustomTopNavBarProfile extends StatelessWidget
//     implements PreferredSizeWidget {
//   final String title;
//   final VoidCallback onBackPressed;
//   final VoidCallback onEditPressed;
//   final VoidCallback onNotificationPressed;

//   const CustomTopNavBarProfile({
//     Key? key,
//     required this.title,
//     required this.onBackPressed,
//     required this.onEditPressed,
//     required this.onNotificationPressed,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: const Color(0xFFF29912).withOpacity(0.8),
//       title: Text(
//         title,
//         style: const TextStyle(color: Colors.black),
//       ),
//       leading: IconButton(
//         icon: const Icon(Icons.arrow_back, color: Colors.black),
//         onPressed: onBackPressed,
//       ),
//       actions: [
//         IconButton(
//           icon: SizedBox(
//             height: 28,
//             width: 30,
//             child: Image.asset('assets/icons/notification.png'),
//           ),
//           onPressed: onNotificationPressed,
//         ),
//         IconButton(
//           icon: SizedBox(
//             height: 24,
//             width: 24,
//             child: Image.asset('assets/icons/edit.png'),
//           ),
//           onPressed: onEditPressed,
//         ),
//       ],
//       bottom: const PreferredSize(
//         preferredSize: Size.fromHeight(1.0),
//         child: Divider(
//           height: 1.0,
//           thickness: 1.0,
//           color: Colors.black,
//         ),
//       ),
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }
import 'package:flutter/material.dart';

class CustomTopNavBarProfile extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final VoidCallback onBackPressed;
  final VoidCallback onEditPressed;
  final VoidCallback onNotificationPressed;
  final bool showEditIcon; // Add this to conditionally show the edit icon

  const CustomTopNavBarProfile({
    Key? key,
    required this.title,
    required this.onBackPressed,
    required this.onEditPressed,
    required this.onNotificationPressed,
    this.showEditIcon = true, // Default to true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF29912).withOpacity(0.8),
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: onBackPressed,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(
              right: 30.0), // Adjust the padding value as needed
          child: IconButton(
            icon: SizedBox(
              height: 28,
              width: 30,
              child: Image.asset('assets/icons/notification.png'),
            ),
            onPressed: onNotificationPressed,
          ),
        ),
        if (showEditIcon)
          IconButton(
            icon: SizedBox(
              height: 24,
              width: 24,
              child: Image.asset('assets/icons/edit.png'),
            ),
            onPressed: onEditPressed,
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
