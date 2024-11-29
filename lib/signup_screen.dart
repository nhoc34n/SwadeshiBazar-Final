import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart'; // Ensure you have this import for your HomePage

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String _selectedUserType = 'Farmer'; // Default selection
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF9EE), // Background colour
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Background Image and Title
              Stack(
                children: [
                  Image.asset(
                    'assets/top_background.png', // Replace with your background image
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                  const Positioned(
                    left: 32,
                    bottom: 30,
                    child: Text(
                      'Create\nAccount',
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
              // Sign Up Label
              const Padding(
                padding: EdgeInsets.only(left: 32),
                child: Text(
                  'Sign up as...',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF199B33),
                  ),
                ),
              ),
              // Radio Buttons for User Type
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
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
              const SizedBox(height: 8),
              // Name Field
              _buildTextField(
                controller: _nameController,
                hintText: 'Name',
                prefixIcon: Icons.person,
              ),
              const SizedBox(height: 10),
              // Email Field
              _buildTextField(
                controller: _emailController,
                hintText: 'Email',
                prefixIcon: Icons.email,
              ),
              const SizedBox(height: 10),
              // Mobile Number Field
              _buildTextField(
                controller: _phoneController,
                hintText: 'Mobile Number',
                prefixIcon: Icons.phone,
              ),
              const SizedBox(height: 10),
              // Password Field
              _buildTextField(
                controller: _passwordController,
                hintText: 'Password',
                prefixIcon: Icons.lock,
                obscureText: true,
              ),
              const SizedBox(height: 10),
              // Confirm Password Field
              _buildTextField(
                controller: _confirmPasswordController,
                hintText: 'Confirm Password',
                prefixIcon: Icons.lock,
                obscureText: true,
              ),
              const SizedBox(height: 15),
              // Signup Button
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: _signup,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                    backgroundColor: const Color(0xFF199B33),
                  ),
                  child: const Icon(Icons.arrow_forward, color: Colors.white),
                ),
              ),
              const SizedBox(height: 15),
              // Recovery Text
              Center(
                child: TextButton(
                  onPressed: () {
                    // Handle recovery logic
                  },
                  child: const Text(
                    'Forget your password? Recovery',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF199B33),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method for text fields
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(prefixIcon, color: const Color(0xFF199B33)),
          hintStyle: const TextStyle(color: Color(0xFF199B33)),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF199B33)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF199B33)),
          ),
        ),
        style: const TextStyle(color: Color(0xFF199B33)),
      ),
    );
  }

  // Sign up logic
  void _signup() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      _showErrorDialog('Passwords do not match');
      return;
    }

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // User successfully created
      print('User signed up successfully: ${userCredential.user?.email}');

      // Navigate to HomePage after successful signup with the user type passed
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(userType: _selectedUserType),
        ),
      );
    } on FirebaseAuthException catch (e) {
      _showErrorDialog(e.message ?? 'An error occurred');
    }
  }

  // Helper method to show error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
