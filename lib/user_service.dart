import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  static Future<void> updateUserProfile(
      String displayName, String phoneNumber) async {
    User? user = FirebaseAuth.instance.currentUser;

    try {
      await user?.updateDisplayName(displayName);
      // You cannot update the phone number directly. Firebase requires re-authentication for that.
      await user?.reload(); // Reload user info to get updated data
      print("User profile updated successfully.");
    } catch (error) {
      print("Error updating user profile: $error");
    }
  }
}
