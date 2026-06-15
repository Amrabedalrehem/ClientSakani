

 
 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 import 'package:flutter_application_1/data/model/OnboardingModel.dart';

class OnboardingContent extends StatelessWidget {
  final OnboardingData data;

  const OnboardingContent({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          data.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 26.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          data.subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 14.h),
        Text(
          data.description,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.white.withOpacity(0.85),
            height: 1.6.h,
          ),
        ),
      ],
    );
  }
}
