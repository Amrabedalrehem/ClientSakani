import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyState extends StatelessWidget {
  final VoidCallback onBrowseTap;

  const EmptyState({
    super.key,
    required this.onBrowseTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.bookmark_border_rounded,
              size: 36.sp,
              color: Colors.grey[400],
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'No saved properties yet',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A2E),
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 48.w),
            child: Text(
              'Tap the bookmark icon on any listing to save it here for quick access.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey,
                height: 1.5.h,
              ),
            ),
          ),
          SizedBox(height: 32.h),
          GestureDetector(
            onTap: onBrowseTap,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 32.w,
                vertical: 14.h,
              ),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF1A7EC8),
                    Color(0xFF0FA89A),
                  ],
                ),
                borderRadius:
                    BorderRadius.circular(30.r),
              ),
              child: Text(
                'Browse Listings',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}