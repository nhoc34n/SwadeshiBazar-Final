import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  String? _displayName;
  String? _phoneNumber;
  String? _profileImageUrl;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Fetch user data from Firebase Authentication and Realtime Database
  Future<void> _loadUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      setState(() {
        _displayName = user.displayName;
        _phoneNumber = user.phoneNumber;
        _profileImageUrl =
            user.photoURL; // Get profile image URL from Firebase Authentication
      });

      // Fetch name from Firebase Realtime Database if displayName is not set
      if (_displayName == null) {
        try {
          final snapshot = await _dbRef.child('users/${user.uid}').get();
          if (snapshot.exists) {
            var userData = snapshot.value as Map<dynamic, dynamic>;
            setState(() {
              _displayName = userData['name'] ?? "No Name";
            });
          }
        } catch (e) {
          print("Error loading user data: $e");
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Account Info"),
        backgroundColor: const Color(0xFF199B33),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: user == null
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'User Information:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Display profile picture (if available)
                  _profileImageUrl != null
                      ? CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(_profileImageUrl!),
                        )
                      : const CircleAvatar(
                          radius: 50,
                          child: Icon(Icons.person, size: 50),
                        ),
                  const SizedBox(height: 20),
                  // Display name
                  Text(
                    'Name: ${_displayName ?? "Not set"}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  // Email
                  Text(
                    'Email: ${user.email ?? "Not set"}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  // Phone number
                  Text(
                    'Phone: ${_phoneNumber ?? "Not set"}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  // Button to logout
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF199B33),
                      ),
                      child: const Text("Logout"),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
