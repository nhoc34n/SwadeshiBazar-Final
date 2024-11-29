import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/bg2.png', // Replace with your background image path
              fit:
                  BoxFit.cover, // Ensure the background image covers the screen
            ),
          ),
          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo
                Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  child: Image.asset(
                    'assets/logo.png', // Replace with your logo image path
                    width:
                        MediaQuery.of(context).size.width * 0.4, // Scaled width
                    height: MediaQuery.of(context).size.width *
                        0.4, // Scaled height
                  ),
                ),
                // Welcome Text
                const Text(
                  'Welcome to Swadeshi Bazar',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Your trusted platform for farming needs',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 58, 57, 57),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                // Login Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Button background colour
                    minimumSize: Size(
                      MediaQuery.of(context).size.width * 0.6, // Scaled width
                      50, // Fixed height
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Sign-Up Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange, // Button background colour
                    minimumSize: Size(
                      MediaQuery.of(context).size.width * 0.6, // Scaled width
                      50, // Fixed height
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'SIGNUP',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
