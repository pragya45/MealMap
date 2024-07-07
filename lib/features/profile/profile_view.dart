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
    setState(() {
      _userProfileFuture = AuthService.getUserProfile();
    });
  }

  void _navigateBackToHomeView(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  void _logout() async {
    await AuthService.logout();
    if (!mounted) return;
    _navigateBackToHomeView(context);
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
            _navigateBackToHomeView(context);
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
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: _user['image'] != null
                          ? NetworkImage(_user['image'])
                          : const AssetImage('assets/images/profile.png')
                              as ImageProvider,
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
                        Navigator.of(context).pushNamed('/change-password');
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
                        _showConfirmationDialog(context, 'Delete Account',
                            'Are you sure you want to delete your account?',
                            () async {
                          await _deleteAccount();
                        });
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
                        _showConfirmationDialog(context, 'Logout',
                            'Are you sure you want to logout?', () async {
                          _logout();
                        });
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

  Future<void> _deleteAccount() async {
    try {
      await AuthService.deleteAccount();
      _showCustomToast('Account deleted successfully');
      Navigator.of(context).pushReplacementNamed('/login');
    } catch (e) {
      _showCustomToast('Failed to delete account: $e');
    }
  }

  void _showConfirmationDialog(BuildContext context, String title,
      String content, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm();
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  void _showCustomToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontSize: 12),
        ),
        backgroundColor: Colors.green.shade100,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
