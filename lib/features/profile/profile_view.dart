import 'package:flutter/material.dart';
import 'package:mealmap/features/navbar/custom_top_nav_bar_profile.dart';

import 'edit_profile_view.dart';
import 'widgets/profile_info_row.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopNavBarProfile(
        title: 'My Profile',
        onBackPressed: () {
          Navigator.pop(context);
        },
        onEditPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EditProfileView()),
          );
        },
        onNotificationPressed: () {
          // Handle notification button action
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/profile.png'),
              ),
              const SizedBox(height: 17),
              const Text(
                'Pragya Phuyal',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'I am a foodie.',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 16),
              const ProfileInfoRow(
                label: 'Gender',
                value: 'Female',
              ),
              const Divider(color: Colors.black),
              const ProfileInfoRow(
                label: 'Email',
                value: 'pphuyal170@gmail.com',
              ),
              const Divider(color: Colors.black),
              const ProfileInfoRow(
                label: 'Phone Number',
                value: '98**********',
              ),
              const Divider(color: Colors.black),
              const ProfileInfoRow(
                label: 'Location',
                value: 'Kathmandu, Bagmati',
              ),
              const Divider(color: Colors.black),
              const SizedBox(height: 20),
              ListTile(
                leading: SizedBox(
                  height: 24,
                  width: 24,
                  child: Image.asset('assets/icons/lock.png'),
                ),
                title: const Text('Change Password',
                    style: TextStyle(fontSize: 20)),
                onTap: () {
                  // Handle change password
                },
              ),
              ListTile(
                leading: SizedBox(
                  height: 24,
                  width: 24,
                  child: Image.asset('assets/icons/delete.png'),
                ),
                title: const Text('Delete Account',
                    style: TextStyle(color: Colors.red, fontSize: 20)),
                onTap: () {
                  // Handle delete account
                },
              ),
              ListTile(
                leading: SizedBox(
                  height: 24,
                  width: 24,
                  child: Image.asset('assets/icons/logout.png'),
                ),
                title: const Text('Logout', style: TextStyle(fontSize: 20)),
                onTap: () {
                  // Handle logout
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
