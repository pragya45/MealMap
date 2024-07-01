import 'package:flutter/material.dart';

import 'widgets/profile_info_input.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  String? _gender;

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
              const ProfileInfoInput(
                iconPath: 'assets/icons/user.png',
                label: 'Pragya Phuyal',
              ),
              const SizedBox(height: 10),
              const ProfileInfoInput(
                iconPath: 'assets/icons/email.png',
                label: 'pp@gmail.com',
              ),
              const SizedBox(height: 10),
              const ProfileInfoInput(
                iconPath: 'assets/icons/phone.png',
                label: '98**********',
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
                  });
                },
              ),
              const SizedBox(height: 10),
              const ProfileInfoInput(
                iconPath: 'assets/icons/bio.png',
                label: 'Add Bio',
              ),
              const SizedBox(height: 10),
              const ProfileInfoInput(
                iconPath: 'assets/icons/location.png',
                label: 'Kathmandu, Bagmati',
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Handle update action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF29912).withOpacity(0.8),
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
      ),
    );
  }
}
