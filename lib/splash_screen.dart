import 'dart:async';
import 'package:flutter/material.dart';
import 'welcome_screen.dart'; // Create a WelcomePage for redirection

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to WelcomePage after 3 seconds
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green, // Background colour
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white, // Background for the logo
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100), // Rounded shape
            child: Image.asset(
              'assets/logo.png', // Place your logo in the assets folder
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
