
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DotsIndicator extends StatelessWidget {
  final int count;
  final int current;

  const DotsIndicator({super.key, required this.count, required this.current});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isActive = index == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          width: isActive ? 28 : 8,
          height: 8.h,
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.white.withOpacity(0.4),
            borderRadius: BorderRadius.circular(4.r),
          ),
        );
      }),
    );
  }
}