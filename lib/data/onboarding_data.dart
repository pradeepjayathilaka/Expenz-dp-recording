import 'package:expenz/models/onBoarding_model.dart';

class OnboardingData {
  static final List<Onboarding> onboardingDataList = [
    Onboarding(
      title: "Gain total control of your money",
      imagePath: "assets/images/onboard_1.png",
      description: "Becpme ayour own money manager and make every cent count",
    ),
    Onboarding(
      title: "Know where money goes",
      imagePath: "assets/images/onboard_2.png",
      description:
          "Track your transaction easily,with categories and financial report",
    ),
    Onboarding(
      title: "Planning a head",
      imagePath: "assets/images/onboard_3.png",
      description: "setup your budget for  each category so you in control",
    )
  ];
}
