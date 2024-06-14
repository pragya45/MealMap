import 'package:flutter/material.dart';
// import 'package:mealmap/features/home/home_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  static const Color primaryColor = Color(0xFFF29912);
  static const Color loginBlue = Color(0xFF007BFF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: _buildLoginForm(context),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: primaryColor,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Image.asset('assets/images/logo1.png', height: 30),
          const SizedBox(width: 10),
          const Text('Meal Map', style: TextStyle(fontFamily: 'Inika')),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.black),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.more_vert, color: Colors.black),
          onPressed: () {},
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(color: Colors.black, height: 1.0),
      ),
    );
  }

  Column _buildLoginForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTextField(label: 'Email', icon: Icons.email_outlined),
        const SizedBox(height: 20),
        _buildPasswordTextField(label: 'Password', icon: Icons.lock_outline),
        const SizedBox(height: 20),
        _buildForgotPasswordButton(context),
        const SizedBox(height: 20),
        _buildLoginButton(context),
        const SizedBox(height: 20),
        _buildSocialLoginButton(
            context: context,
            label: 'Login with Google',
            assetName: 'assets/images/google_icons.png'),
        const SizedBox(height: 10),
        _buildSocialLoginButton(
            context: context,
            label: 'Login with Facebook',
            assetName: 'assets/images/facebook_icon.png',
            bgColor: Colors.blue),
      ],
    );
  }

  Widget _buildTextField({required String label, required IconData icon}) {
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

  Widget _buildPasswordTextField(
      {required String label, required IconData icon}) {
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

  Widget _buildForgotPasswordButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        child: const Text(
          'Forgot Your Password?',
          style: TextStyle(color: Colors.black, fontFamily: 'Inika'),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Navigator.pushReplacement(
        //   // Use pushReplacement to change the screen completely without allowing a back swipe
        //   context,
        //   MaterialPageRoute(builder: (context) => const HomeView()),
        // );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: const Text('Login',
          style: TextStyle(fontFamily: 'Inika', color: Colors.black)),
    );
  }

  Widget _buildSocialLoginButton(
      {required BuildContext context,
      required String label,
      required String assetName,
      Color bgColor = Colors.white}) {
    return ElevatedButton.icon(
      icon: Image.asset(assetName, height: 24),
      label: Text(label, style: const TextStyle(fontFamily: 'Inika')),
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

  BottomNavigationBar _buildBottomNavigationBar() {
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
