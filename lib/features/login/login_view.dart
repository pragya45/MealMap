import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  static const Color primaryColor = Color(0xFFF29912); // Custom orange color
  static const Color facebookBlue = Color(0xFF3B5998); // Facebook blue color

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false, // Removes back button
        title: const Text('Meal Map', style: TextStyle(fontFamily: 'Inika')),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {}, // Placeholder for notification action
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {}, // Placeholder for more options
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
            _buildTextField('Email', Icons.email_outlined),
            const SizedBox(height: 20),
            _buildPasswordTextField('Password', Icons.lock_outline),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {}, // Forgot password tap
                child: const Text(
                  'Forgot Your Password?',
                  style: TextStyle(color: Colors.black, fontFamily: 'Inika'),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildButton('Login', primaryColor),
            const SizedBox(height: 20),
            _buildOutlineButton(
                'Login with Google', 'assets/images/google_icons.png'),
            const SizedBox(height: 10),
            _buildOutlineButton('Login with Facebook',
                'assets/images/facebook_icon.png', facebookBlue),
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
        suffixIcon: const Icon(Icons.visibility_off, color: Colors.grey),
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
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(text,
          style: const TextStyle(fontFamily: 'Inika', color: Colors.black)),
    );
  }

  Widget _buildOutlineButton(String text, String assetName,
      [Color bgColor = Colors.white]) {
    return ElevatedButton.icon(
      icon: Image.asset(assetName, height: 24),
      label: Text(text, style: const TextStyle(fontFamily: 'Inika')),
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: bgColor,
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
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
        BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Discover'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
