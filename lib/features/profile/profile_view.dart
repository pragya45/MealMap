import 'package:flutter/material.dart';
import 'package:mealmap/config/router/app_route.dart';
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
  bool _isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  void _checkAuthentication() async {
    _isAuthenticated = await AuthService.isLoggedIn();
    if (_isAuthenticated) {
      _fetchUserProfile();
    } else {
      _showLoginDialog();
    }
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

  void _showLoginDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Please Login'),
        content: const Text('You need to login to access this page.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AppRoute.loginRoute);
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF29912),
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
              Navigator.pushNamed(context,
                  AppRoute.notificationRoute); // Navigate to notification page
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
      body: _isAuthenticated
          ? FutureBuilder<Map<String, dynamic>>(
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
                            backgroundImage: _user['image'] != null &&
                                    _user['image'].isNotEmpty
                                ? NetworkImage(
                                    'http://10.0.2.2:5000/${_user['image']}'
                                        .replaceAll(r'\', '/'))
                                : const AssetImage('assets/images/profile1.png')
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
                            value: _user['phoneNumber'] ??
                                'Phone number not specified',
                          ),
                          ProfileInfoRow(
                            label: 'Location',
                            value:
                                _user['location'] ?? 'Location not specified',
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
                              Navigator.of(context)
                                  .pushNamed('/change-password');
                            },
                          ),
                          ListTile(
                            leading: SizedBox(
                              height: 24,
                              width: 24,
                              child: Image.asset('assets/icons/delete.png'),
                            ),
                            title: const Text('Delete Account',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 20)),
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
                            title: const Text('Logout',
                                style: TextStyle(fontSize: 20)),
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
            )
          : const Center(child: CircularProgressIndicator()),
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
            child: const Text('No', style: TextStyle(color: Colors.black)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm();
            },
            child: const Text('Yes', style: TextStyle(color: Colors.red)),
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
          style: const TextStyle(fontSize: 13, color: Colors.black),
        ),
        backgroundColor: const Color(0x5C62D558),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
