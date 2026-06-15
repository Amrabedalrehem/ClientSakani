
 
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const OnboardingButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54.h,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF1A7EC8),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Text(
            label,
            key: ValueKey(label),
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}