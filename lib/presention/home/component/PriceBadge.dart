import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PriceBadge extends StatelessWidget {
  final int price;

  const PriceBadge({required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Text(
            '\$ ',
            style: TextStyle(
              fontSize: 12.sp,
              color: Color(0xFF4CAF50),
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            '$price/mo',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A2E),
            ),
          ),
        ],
      ),
    );
  }
}