import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserServices {
  //method to store the user name and user email in the shared preferences
  static Future<void> storeUserDetails(
      {required BuildContext context,
      required userName,
      required String email,
      required String password,
      required String confirmPassword}) async {
    //check weather the user entered password and  the confirm password are the same

    //if the users password and confirm password are same then store the users name and email iin the shRED PREFERENCES

    try {
      if (password != confirmPassword) {
        //show the massage to the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("password and confirm password do not match"),
          ),
        );
        return;
      }
      //create and instance from sheared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //store the user name and email as key value pairs
      await prefs.setString("username", userName);
      await prefs.setString("email", email);
      //show a message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("User details stored successfully"),
        ),
      );
    } catch (err) {
      err.toString();
    }
  }
}
