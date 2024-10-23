import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/constants.dart';
import 'package:expenz/widgets/custome_button.dart';
import 'package:flutter/material.dart';

class UserDataScreen extends StatefulWidget {
  const UserDataScreen({super.key});

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  //for the check box
  bool _rememberMe = false;

  //form key for the form validation
  final _formKey = GlobalKey<FormState>();

  //controller for the text form fields
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
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //form feild for the user name;
                        TextFormField(
                          controller: _userNameController,
                          validator: (value) {
                            //check wether the user entered the name or not
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            contentPadding: EdgeInsets.all(20),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        //form feild for the user Email;
                        TextFormField(
                          controller: _emailController,
                          validator: (value) {
                            //check wether the user entered the email or not
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            contentPadding: EdgeInsets.all(20),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        //form feild for the user password;
                        TextFormField(
                          controller: _passwordController,
                          validator: (value) {
                            //check wether the user entered the password or not
                            if (value!.isEmpty) {
                              return 'Please enter a valid password';
                            }
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            contentPadding: EdgeInsets.all(20),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        //form feild for the user password;
                        TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          validator: (value) {
                            //check wether the user entered the password or not
                            if (value!.isEmpty) {
                              return 'Please enter the  same password';
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'Confirm Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            contentPadding: EdgeInsets.all(20),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        //remember me for the next
                        Row(
                          children: [
                            Text(
                              "Remember Me for the next time",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: kGrey,
                              ),
                            ),
                            Expanded(
                              child: CheckboxListTile(
                                activeColor: kMainColor,
                                value: _rememberMe,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      _rememberMe = value!;
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              //if the form is valid then navigate to the next page
                              String userName = _userNameController.text;
                              String email = _emailController.text;
                              String password = _passwordController.text;
                              String confirmPassword =
                                  _confirmPasswordController.text;

                              print(
                                  "$userName $email $password $confirmPassword");
                            }
                          },
                          child: CustomeButton(
                            buttonName: "Next",
                            buttonColor: kMainColor,
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
