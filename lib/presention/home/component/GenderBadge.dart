import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/core/const/HomeConst.dart';

class GenderBadge extends StatelessWidget {
  final PropertyGender gender;

  const GenderBadge({required this.gender});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: gender.color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Icon(gender.icon, size: 13.sp, color: gender.color),
          SizedBox(width: 4.w),
          Text(
            gender.label(context),
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: gender.color,
            ),
          ),
        ],
      ),
    );
  }
}