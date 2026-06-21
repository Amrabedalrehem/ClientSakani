import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/core/const/OnboardingConst.dart';
 import 'package:flutter_application_1/data/shared%20prefrence/SettingsService.dart';
import 'package:flutter_application_1/presention/home/HomeScreen.dart';
import 'package:flutter_application_1/presention/onboarding/component/onboadring/AnimatedGradientBackground.dart';
import 'package:flutter_application_1/presention/onboarding/component/onboadring/DotsIndicator.dart';
import 'package:flutter_application_1/presention/onboarding/component/onboadring/OnboardingButton.dart';
import 'package:flutter_application_1/presention/onboarding/component/onboadring/OnboardingPage.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _onPageChanged(int index) {
    setState(() => _currentPage = index);
  }

  void _nextPage() {
    if (_currentPage < kOnboardingPages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      _onGetStarted();
    }
  }

  void _onGetStarted() {
    _finishOnboarding();
  }

  void _onSkip() {
    _finishOnboarding();
  }

  void _finishOnboarding() async {
    await SettingsService.setFirstTime(false);
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLast = _currentPage == kOnboardingPages.length - 1;

    return Scaffold(
      body: AnimatedGradientBackground(
        gradientColors: kOnboardingPages[_currentPage].gradientColors,
        child: SafeArea(
          child: Column(
            children: [
               Align(
                alignment: Alignment.topRight,
                child: AnimatedOpacity(
                  opacity: isLast ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 300),
                  child: TextButton(
                    onPressed: isLast ? null : _onSkip,
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

               Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: kOnboardingPages.length,
                  itemBuilder: (context, index) {
                    return OnboardingPage(
                      data: kOnboardingPages[index],
                      isActive: index == _currentPage,
                    );
                  },
                ),
              ),

               Padding(
                padding: EdgeInsets.fromLTRB(24, 0, 24, 32),
                child: Column(
                  children: [
                    DotsIndicator(
                      count: kOnboardingPages.length,
                      current: _currentPage,
                    ),
                    SizedBox(height: 24.h),
                    OnboardingButton(
                      label: isLast ? 'Get Started 🚀' : 'Next',
                      onTap: _nextPage,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}