import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/constants.dart';
import 'package:expenz/screens/onboarding_screen.dart';
import 'package:expenz/services/expense_service.dart';
import 'package:expenz/services/income_service.dart';
import 'package:expenz/services/user_services.dart';
import 'package:expenz/widgets/profile_card.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = "User"; // Default placeholder
  String email = "email@example.com"; // Default placeholder
  bool isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    // Fetch user data asynchronously
    UserServices.getUserData().then((value) {
      if (value != null) {
        setState(() {
          userName = value['username'] ?? "User";
          email = value['email'] ?? "email@example.com";
          isLoading = false; // Data loaded
        });
      } else {
        setState(() {
          isLoading = false; // Handle case where data is null
        });
      }
    }).catchError((error) {
      // Handle error gracefully
      debugPrint("Error fetching user data: $error");
      setState(() {
        isLoading = false;
      });
    });
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: kWhite,
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          color: Colors.white,
          padding: EdgeInsets.all(kDefaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Are you suer you want  to log out?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: kBlack,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(kGreen),
                    ),
                    onPressed: () async {
                      //clear user data
                      await UserServices.clearUserData();

                      //clear the all expences and incomes
                      if (context.mounted) {
                        await ExpenseService().deleteAllExpences(context);
                        await IncomeService().deleteAllExpences(context);

                        //navigate to the onboarfing screen
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OnboardingScreen(),
                          ),
                          (route) => false,
                        );
                      }
                    },
                    child: const Text(
                      "Yes",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: kWhite,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(kRed),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "No",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: kWhite,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header Section
              Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // User Image
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: kMainColor,
                            border: Border.all(
                              color: kMainColor,
                              width: 3,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              'assets/images/user.jpg',
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        // User Name and Email
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              isLoading
                                  ? const CircularProgressIndicator() // Show a loader while data is loading
                                  : Text(
                                      "Welcome $userName",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                              const SizedBox(height: 5),
                              Text(
                                email,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: kMainColor.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        // Notification Icon
                        IconButton(
                          onPressed: () {
                            // Handle notification tap
                          },
                          icon: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: kMainColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: kMainColor,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const ProfileCard(
                      icon: Icons.wallet,
                      title: "My Wallet",
                      color: kMainColor,
                    ),
                    const ProfileCard(
                      icon: Icons.settings,
                      title: "Settings",
                      color: kYellow,
                    ),
                    const ProfileCard(
                      icon: Icons.download,
                      title: "Export data",
                      color: kGreen,
                    ),
                    GestureDetector(
                      onTap: () {
                        _showBottomSheet(context);
                      },
                      child: const ProfileCard(
                        icon: Icons.logout,
                        title: "Log Out",
                        color: kRed,
                      ),
                    ),
                  ],
                ),
              ),
              // Add additional sections here as needed
            ],
          ),
        ),
      ),
    );
  }
}
