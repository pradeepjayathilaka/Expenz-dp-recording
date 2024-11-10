import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/constants.dart';
import 'package:expenz/data/onboarding_data.dart';
import 'package:expenz/screens/onboarding/font_page.dart';
import 'package:expenz/screens/onboarding/shared_onboarding_screen.dart';
import 'package:expenz/screens/user_data_screen.dart';
import 'package:expenz/widgets/custome_button.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool showDetailsPage = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void navigateToNextPage() {
    if (showDetailsPage) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const UserDataScreen()),
      );
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  PageView(
                    controller: _controller,
                    onPageChanged: (index) {
                      setState(() {
                        showDetailsPage = index == 3;
                      });
                    },
                    children: [
                      const FontPage(),
                      SharedOnboardingScreen(
                        imagepath:
                            OnboardingData.onboardingDataList[0].imagePath,
                        title: OnboardingData.onboardingDataList[0].title,
                        description:
                            OnboardingData.onboardingDataList[0].description,
                      ),
                      SharedOnboardingScreen(
                        imagepath:
                            OnboardingData.onboardingDataList[1].imagePath,
                        title: OnboardingData.onboardingDataList[1].title,
                        description:
                            OnboardingData.onboardingDataList[1].description,
                      ),
                      SharedOnboardingScreen(
                        imagepath:
                            OnboardingData.onboardingDataList[2].imagePath,
                        title: OnboardingData.onboardingDataList[2].title,
                        description:
                            OnboardingData.onboardingDataList[2].description,
                      ),
                    ],
                  ),
                  // Page dot indicator
                  Align(
                    alignment: const Alignment(0, 0.75),
                    child: SmoothPageIndicator(
                      controller: _controller,
                      count: 4,
                      effect: const WormEffect(
                        activeDotColor: kMainColor,
                        dotColor: kLightGrey,
                      ),
                    ),
                  ),
                  // Navigation button
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: GestureDetector(
                        onTap: navigateToNextPage,
                        child: CustomeButton(
                          buttonName: showDetailsPage ? "Get Started" : "Next",
                          buttonColor: kMainColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
