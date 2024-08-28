import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:reactnativetask/ui/signin_screen/signin_screen.dart';

import '../../utils/base_assets.dart';
import '../../utils/base_colors.dart';
import '../../utils/base_strings.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: OnBoardingSlider(
        totalPage: 3,
        headerBackgroundColor: BaseColors.whiteColor,
        pageBackgroundColor: BaseColors.whiteColor,
        finishButtonStyle: FinishButtonStyle(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: BaseColors.backgroundBlueColor),
        finishButtonTextStyle: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: BaseColors.whiteColor),
        finishButtonText: 'Sign In',
        speed: 1.2,
        background: [
          Image.asset(
            BaseAssets.onboardingImage,
            width: size.width,
          ),
          Image.asset(
            BaseAssets.onboardingImage,
            width: size.width,
          ),
          Image.asset(
            BaseAssets.onboardingImage,
            width: size.width,
          ),
        ],
        onFinish: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const SignInScreen()),
              (Route<dynamic> route) => false);
        },
        skipTextButton: const Text(
          'Skip',
          style: TextStyle(color: BaseColors.blackColor),
        ),
        pageBodies: [
          onBoardingWidget(BaseStrings.onboardingText1),
          onBoardingWidget(BaseStrings.onboardingText2),
          onBoardingWidget(
            isLast: true,
            BaseStrings.onboardingText3,
          ),
        ],
      ),
    );
  }

  Widget onBoardingWidget(String descriptionText, {bool isLast = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          isLast
              ? const SizedBox.shrink()
              : Text(
                  descriptionText,
                  textAlign: TextAlign.center,
                ),
        ],
      ),
    );
  }
}
