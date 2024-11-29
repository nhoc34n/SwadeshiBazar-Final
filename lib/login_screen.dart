import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart'; // Assuming HomePage is in home_page.dart

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _selectedUserType = 'Farmer'; // Default selection
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false; // To show a loading indicator during login

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF9EE), // Background color
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Background Image
            Stack(
              children: [
                Image.asset(
                  'assets/top_background1.png', // Replace with your background image path
                  width: double.infinity,
                  height: 400,
                  fit: BoxFit.cover,
                ),
                const Positioned(
                  left: 32,
                  bottom: 30,
                  child: Text(
                    'Welcome\nBack',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF199B33),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Sign In Label
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'Sign in as...',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF199B33),
                ),
              ),
            ),
            // Radio Buttons for User Type
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Farmer',
                        groupValue: _selectedUserType,
                        onChanged: (value) {
                          setState(() {
                            _selectedUserType = value!;
                          });
                        },
                        activeColor: const Color(0xFF199B33),
                      ),
                      const Text(
                        'Farmer',
                        style: TextStyle(color: Color(0xFF199B33)),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Consumer',
                        groupValue: _selectedUserType,
                        onChanged: (value) {
                          setState(() {
                            _selectedUserType = value!;
                          });
                        },
                        activeColor: const Color(0xFF199B33),
                      ),
                      const Text(
                        'Consumer',
                        style: TextStyle(color: Color(0xFF199B33)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Email Input
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.email, color: Color(0xFF199B33)),
                  hintStyle: TextStyle(color: Color(0xFF199B33)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF199B33)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF199B33)),
                  ),
                ),
                style: const TextStyle(color: Color(0xFF199B33)),
              ),
            ),
            const SizedBox(height: 16),
            // Password Input
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock, color: Color(0xFF199B33)),
                  hintStyle: TextStyle(color: Color(0xFF199B33)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF199B33)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF199B33)),
                  ),
                ),
                style: const TextStyle(color: Color(0xFF199B33)),
              ),
            ),
            const SizedBox(height: 20),
            // Login Button
            Padding(
              padding: const EdgeInsets.only(right: 32),
              child: Align(
                alignment: Alignment.centerRight,
                child: _isLoading
                    ? const CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xFF199B33)),
                      )
                    : ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            _isLoading = true; // Show loading indicator
                          });
                          try {
                            // Attempt to sign in with Firebase
                            UserCredential userCredential = await FirebaseAuth
                                .instance
                                .signInWithEmailAndPassword(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                            // Navigate to home page after successful login
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(
                                  userType:
                                      _selectedUserType, // Pass the selected userType here
                                ),
                              ),
                            );
                          } on FirebaseAuthException catch (e) {
                            // Handle any errors that occur during login
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Error'),
                                content: Text(e.message ?? 'An error occurred'),
                                actions: [
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            );
                          } finally {
                            setState(() {
                              _isLoading = false; // Hide loading indicator
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(20),
                          backgroundColor: const Color(0xFF199B33),
                        ),
                        child: const Icon(Icons.arrow_forward,
                            color: Colors.white),
                      ),
              ),
            ),
            const SizedBox(height: 16),
            // Register Text
            Center(
              child: RichText(
                text: TextSpan(
                  text: 'Are you a new user? ',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF199B33),
                  ),
                  children: [
                    TextSpan(
                      text: 'Register',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF199B33),
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, '/signup');
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
