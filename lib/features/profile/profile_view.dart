import 'package:flutter/material.dart';
import 'package:mealmap/features/profile/widgets/profile_info_row.dart';
import 'package:mealmap/http/auth_service.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late Future<Map<String, dynamic>> _userProfileFuture;
  Map<String, dynamic> _user = {};

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  void _fetchUserProfile() {
    _userProfileFuture = AuthService.getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF29912).withOpacity(0.8),
        title: const Text('My Profile', style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: SizedBox(
              height: 28,
              width: 30,
              child: Image.asset('assets/icons/notification.png'),
            ),
            onPressed: () {
              // Handle notification button action
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.black),
            onPressed: () async {
              final result =
                  await Navigator.of(context).pushNamed('/edit-profile');
              if (result == true) {
                setState(() {
                  _fetchUserProfile();
                });
              }
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
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _userProfileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No user data found'));
          } else {
            _user = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/profile.png'),
                    ),
                    const SizedBox(height: 17),
                    Text(
                      _user['fullName'] ?? 'No Name',
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _user['bio'] ?? 'I am a foodie.',
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ProfileInfoRow(
                      label: 'Gender',
                      value: _user['gender'] ?? 'Gender not specified',
                    ),
                    ProfileInfoRow(
                      label: 'Email',
                      value: _user['email'] ?? 'Email not specified',
                    ),
                    ProfileInfoRow(
                      label: 'Phone Number',
                      value:
                          _user['phoneNumber'] ?? 'Phone number not specified',
                    ),
                    ProfileInfoRow(
                      label: 'Location',
                      value: _user['location'] ?? 'Location not specified',
                    ),
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
                      title:
                          const Text('Logout', style: TextStyle(fontSize: 20)),
                      onTap: () {
                        // Handle logout
                      },
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
