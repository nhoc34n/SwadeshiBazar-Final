import 'package:firebase_database/firebase_database.dart';

class DatabaseService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  // Write user profile data to Firebase Realtime Database
  Future<void> saveUserProfile(
      String userId, String displayName, String phoneNumber) async {
    try {
      await _dbRef.child('users/$userId').set({
        'displayName': displayName,
        'phoneNumber': phoneNumber,
      });
      print("User profile saved successfully");
    } catch (error) {
      print("Error saving user profile: $error");
    }
  }

  // Retrieve user profile data from Firebase Realtime Database
  Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    try {
      DataSnapshot snapshot = await _dbRef.child('users/$userId').get();
      if (snapshot.exists) {
        return Map<String, dynamic>.from(snapshot.value as Map);
      } else {
        print("User not found");
        return null;
      }
    } catch (error) {
      print("Error fetching user profile: $error");
      return null;
    }
  }

  // Update user profile data
  Future<void> updateUserProfile(
      String userId, String displayName, String phoneNumber) async {
    try {
      await _dbRef.child('users/$userId').update({
        'displayName': displayName,
        'phoneNumber': phoneNumber,
      });
      print("User profile updated successfully");
    } catch (error) {
      print("Error updating user profile: $error");
    }
  }
}
