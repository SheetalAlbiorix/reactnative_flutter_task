import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reactnativetask/ui/onboarding_screen/onboarding_screen.dart';

import '../utils/base_assets.dart';
import '../utils/base_colors.dart';
import '../utils/base_strings.dart';
import '../utils/shared_data.dart';
import 'dashboard_screen/dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () {
      checkIfAlreadyLogin(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColors.backgroundBlueColor,
      body: Center(
        child: SvgPicture.asset(BaseAssets.logoPath),
      ),
    );
  }
}

/// Check if user is already logged in
checkIfAlreadyLogin(BuildContext context) async {
  SharedData sharedData = SharedData();
  final isLogin =
      await sharedData.readUserCredentialsData(BaseStrings.isUserLoggedIn);
  if (context.mounted) {
    if (isLogin == true) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()));
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
          (Route<dynamic> route) => false);
    }
  }
}
