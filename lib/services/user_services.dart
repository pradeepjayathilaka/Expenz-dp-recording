import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserServices {
  static Future<bool> storeUserDetails({
    required BuildContext context,
    required String userName,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      // Check if password and confirmPassword match
      if (password.trim() != confirmPassword.trim()) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Password and confirm password do not match")),
        );
        return false; // Passwords don't match
      }

      // Save user details if passwords match
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("username", userName);
      await prefs.setString("email", email);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User details stored successfully")),
      );
      return true; // Success
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: ${err.toString()}")),
      );
      return false; // Error
    }
  }
}
