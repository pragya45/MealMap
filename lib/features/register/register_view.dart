import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  static const Color primaryColor = Color(0xFFF29912); // Custom orange color
  static const Color loginBlue =
      Color(0xFF007BFF); // Custom blue for login text

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false, // Removes back button
        title: Row(
          children: [
            Image.asset('assets/images/logo1.png',
                height: 70), // Logo in AppBar
            const SizedBox(width: 10),
            const Text('Your Profile', style: TextStyle(fontFamily: 'Inika')),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {}, // Notification action
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {}, // More options
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.black, height: 1.0),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextField('Full Name', Icons.person_outline),
            const SizedBox(height: 20),
            _buildTextField('Email', Icons.email_outlined),
            const SizedBox(height: 20),
            _buildPasswordTextField('Create your password', Icons.lock_outline),
            const SizedBox(height: 20),
            _buildPasswordTextField(
                'Confirm your password', Icons.lock_outline),
            const SizedBox(height: 25),
            _buildButton('Register', primaryColor),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {},
                child: RichText(
                  text: const TextSpan(
                    text: 'Already have an account? ',
                    style: TextStyle(color: Colors.black, fontFamily: 'Inika'),
                    children: [
                      TextSpan(
                        text: 'Login',
                        style: TextStyle(color: loginBlue, fontFamily: 'Inika'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            _buildOutlineButton(
                'Register with Google', 'assets/images/google_icons.png'),
            const SizedBox(height: 10),
            _buildOutlineButton(
                'Register with Facebook', 'assets/images/facebook_icon.png'),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildTextField(String label, IconData icon) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black),
        ),
        labelStyle: const TextStyle(fontFamily: 'Inika'),
      ),
    );
  }

  Widget _buildPasswordTextField(String label, IconData icon) {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.black),
        suffixIcon: const Icon(Icons.visibility_off, color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black),
        ),
        labelStyle: const TextStyle(fontFamily: 'Inika'),
      ),
    );
  }

  Widget _buildButton(String text, Color color) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: const Size(160, 40), // Adjusted to smaller specific size
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(text,
          style: const TextStyle(fontFamily: 'Inika', color: Colors.black)),
    );
  }

  Widget _buildOutlineButton(String text, String assetName) {
    return ElevatedButton.icon(
      icon: Image.asset(assetName, height: 24),
      label: Text(text, style: const TextStyle(fontFamily: 'Inika')),
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        side: const BorderSide(color: Colors.black),
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: primaryColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: const Color.fromARGB(255, 3, 3, 3),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'List',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: 'Discover',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
