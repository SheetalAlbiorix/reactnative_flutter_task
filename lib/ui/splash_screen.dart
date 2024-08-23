import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dashboard_screen/dashboard_screen.dart';
import '../utils/base_assets.dart';
import '../utils/base_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
          (Route<dynamic> route) => false);
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
