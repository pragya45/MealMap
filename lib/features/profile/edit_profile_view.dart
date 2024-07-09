import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mealmap/features/navbar/custom_toast.dart';
import 'package:mealmap/features/profile/widgets/edit_profile_dropdown_field.dart';
import 'package:mealmap/features/profile/widgets/edit_profile_text_field.dart';
import 'package:mealmap/http/auth_service.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  late Future<Map<String, dynamic>> _userProfileFuture;
  Map<String, dynamic> _user = {};
  String? _gender;
  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool _showToast = false;
  String _toastMessage = '';

  @override
  void initState() {
    super.initState();
    _requestPermissions();
    _userProfileFuture = AuthService.getUserProfile();
  }

  Future<void> _requestPermissions() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    }

    status = await Permission.photos.status;
    if (!status.isGranted) {
      await Permission.photos.request();
    }
  }

  Future<void> _updateProfile(BuildContext context) async {
    try {
      var request = http.MultipartRequest(
        'PUT',
        Uri.parse('http://10.0.2.2:5000/api/user/profile'),
      );

      // Add image if available
      if (_image != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            _image!.path,
            filename: basename(_image!.path),
          ),
        );
      }

      // Add other user details
      request.fields['fullName'] = _user['fullName'] ?? '';
      request.fields['email'] = _user['email'] ?? '';
      request.fields['phoneNumber'] = _user['phoneNumber'] ?? '';
      request.fields['gender'] = _user['gender'] ?? '';
      request.fields['bio'] = _user['bio'] ?? '';
      request.fields['location'] = _user['location'] ?? '';

      // Add headers
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }

      var response = await request.send();
      if (response.statusCode == 200) {
        if (!mounted) return;
        _showCustomToast('Profile Updated Successfully');
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.of(context).pop(true); // Return true to indicate success
        });
      } else {
        throw Exception('Failed to update profile');
      }
    } catch (error) {
      if (!mounted) return;
      _showCustomToast('Failed to update profile: $error');
    }
  }

  void _showCustomToast(String message) {
    setState(() {
      _toastMessage = message;
      _showToast = true;
    });
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _showToast = false;
      });
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
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
      body: Stack(
        children: [
          FutureBuilder<Map<String, dynamic>>(
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
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    leading: const Icon(Icons.camera),
                                    title: const Text('Camera'),
                                    onTap: () {
                                      _pickImage(ImageSource.camera);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.photo_library),
                                    title: const Text('Gallery'),
                                    onTap: () {
                                      _pickImage(ImageSource.gallery);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: _image != null
                                ? FileImage(_image!)
                                : _user['image'] != null &&
                                        _user['image'].isNotEmpty
                                    ? NetworkImage(_user['image'])
                                    : const AssetImage(
                                            'assets/images/default_profile.png')
                                        as ImageProvider,
                          ),
                        ),
                        const SizedBox(height: 17),
                        EditProfileTextField(
                          iconPath: 'assets/icons/user.png',
                          label: 'Full Name',
                          initialValue: _user['fullName'],
                          onChanged: (value) {
                            _user['fullName'] = value;
                          },
                        ),
                        const SizedBox(height: 10),
                        EditProfileTextField(
                          iconPath: 'assets/icons/email.png',
                          label: 'Email',
                          initialValue: _user['email'],
                          onChanged: (value) {
                            _user['email'] = value;
                          },
                        ),
                        const SizedBox(height: 10),
                        EditProfileTextField(
                          iconPath: 'assets/icons/phone.png',
                          label: 'Phone Number',
                          initialValue: _user['phoneNumber'],
                          onChanged: (value) {
                            _user['phoneNumber'] = value;
                          },
                        ),
                        const SizedBox(height: 10),
                        EditProfileDropdownField(
                          iconPath: 'assets/icons/gender.png',
                          label: 'Gender',
                          dropdownValue: _gender,
                          onDropdownChanged: (String? newValue) {
                            setState(() {
                              _gender = newValue;
                              _user['gender'] = newValue;
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        EditProfileTextField(
                          iconPath: 'assets/icons/bio.png',
                          label: 'Add Bio',
                          initialValue: _user['bio'],
                          onChanged: (value) {
                            _user['bio'] = value;
                          },
                        ),
                        const SizedBox(height: 10),
                        EditProfileTextField(
                          iconPath: 'assets/icons/location.png',
                          label: 'Location',
                          initialValue: _user['location'],
                          onChanged: (value) {
                            _user['location'] = value;
                          },
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () => _updateProfile(context),
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
          if (_showToast)
            Positioned(
              bottom: 0,
              left: 0.0,
              right: 0.0,
              child: CustomToast(message: _toastMessage),
            ),
        ],
      ),
    );
  }
}
