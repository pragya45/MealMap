import 'package:flutter/material.dart';
import 'package:mealmap/features/profile/widgets/profile_info_input.dart';
import 'package:mealmap/http/auth_service.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  late Future<Map<String, dynamic>> _userProfileFuture;
  Map<String, dynamic> _user = {};
  String? _gender;

  @override
  void initState() {
    super.initState();
    _userProfileFuture = AuthService.getUserProfile();
  }

  Future<void> _updateProfile() async {
    try {
      await AuthService.updateUserProfile(_user);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile Updated Successfully'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pop(true); // Return true to indicate success
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update profile: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF29912).withOpacity(0.8),
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black),
        ),
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
            _gender = _user['gender'];
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/profile.png'),
                    ),
                    const SizedBox(height: 17),
                    ProfileInfoInput(
                      iconPath: 'assets/icons/user.png',
                      label: 'Full Name',
                      initialValue: _user['fullName'],
                      onChanged: (value) {
                        _user['fullName'] = value;
                      },
                    ),
                    const SizedBox(height: 10),
                    ProfileInfoInput(
                      iconPath: 'assets/icons/email.png',
                      label: 'Email',
                      initialValue: _user['email'],
                      onChanged: (value) {
                        _user['email'] = value;
                      },
                    ),
                    const SizedBox(height: 10),
                    ProfileInfoInput(
                      iconPath: 'assets/icons/phone.png',
                      label: 'Phone Number',
                      initialValue: _user['phoneNumber'],
                      onChanged: (value) {
                        _user['phoneNumber'] = value;
                      },
                    ),
                    const SizedBox(height: 10),
                    ProfileInfoInput(
                      iconPath: 'assets/icons/gender.png',
                      label: 'Gender',
                      isDropdown: true,
                      dropdownValue: _gender,
                      onDropdownChanged: (String? newValue) {
                        setState(() {
                          _gender = newValue;
                          _user['gender'] = newValue;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    ProfileInfoInput(
                      iconPath: 'assets/icons/bio.png',
                      label: 'Add Bio',
                      initialValue: _user['bio'],
                      onChanged: (value) {
                        _user['bio'] = value;
                      },
                    ),
                    const SizedBox(height: 10),
                    ProfileInfoInput(
                      iconPath: 'assets/icons/location.png',
                      label: 'Location',
                      initialValue: _user['location'],
                      onChanged: (value) {
                        _user['location'] = value;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _updateProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFFF29912).withOpacity(0.8),
                        side: const BorderSide(color: Colors.black),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40.0,
                          vertical: 12.0,
                        ),
                      ),
                      child: const Text(
                        'Update',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
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
