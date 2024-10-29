import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/constants.dart';
import 'package:expenz/screens/main_screen.dart';
import 'package:expenz/services/user_services.dart';
import 'package:expenz/widgets/custome_button.dart';
import 'package:flutter/material.dart';

class UserDataScreen extends StatefulWidget {
  const UserDataScreen({super.key});

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  bool _rememberMe = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter your \n Personal details",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _userNameController,
                        validator: (value) =>
                            value!.isEmpty ? 'Please enter your name' : null,
                        decoration: InputDecoration(
                          hintText: 'Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          contentPadding: EdgeInsets.all(20),
                        ),
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        controller: _emailController,
                        validator: (value) =>
                            value!.isEmpty ? 'Please enter your email' : null,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          contentPadding: EdgeInsets.all(20),
                        ),
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        controller: _passwordController,
                        validator: (value) => value!.isEmpty
                            ? 'Please enter a valid password'
                            : null,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          contentPadding: EdgeInsets.all(20),
                        ),
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        validator: (value) => value!.isEmpty
                            ? 'Please enter the same password'
                            : null,
                        decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          contentPadding: EdgeInsets.all(20),
                        ),
                      ),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Text(
                            "Remember Me for the next time",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: kGrey),
                          ),
                          Expanded(
                            child: CheckboxListTile(
                              activeColor: kMainColor,
                              value: _rememberMe,
                              onChanged: (value) =>
                                  setState(() => _rememberMe = value!),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            bool success = await UserServices.storeUserDetails(
                              context: context,
                              userName: _userNameController.text,
                              email: _emailController.text,
                              password: _passwordController.text,
                              confirmPassword: _confirmPasswordController.text,
                            );
                            // Navigate to MainScreen only if user details were stored successfully
                            if (success && context.mounted) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainScreen()),
                              );
                            }
                          }
                        },
                        child: CustomeButton(
                          buttonName: "Next",
                          buttonColor: kMainColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
