import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/data/shared%20prefrence/SettingsService.dart';
import 'package:flutter_application_1/presention/home/HomeScreen.dart';
import 'package:flutter_application_1/presention/onboarding/OnboardingScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        if (SettingsService.isFirstTime) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const OnboardingScreen()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A7EC8),  
              Color(0xFF0FA89A),  
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [


             Text(
              'Sakani',
              style: TextStyle(
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),

            SizedBox(height: 6.h),

             Text(
              'STUDENT HOUSING',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
                letterSpacing: 3.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}