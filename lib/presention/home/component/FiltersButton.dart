
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FiltersButton extends StatelessWidget {
  final int activeCount;
  final VoidCallback onTap;

  const FiltersButton({required this.activeCount, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: activeCount > 0
              ? const Color(0xFF1A7EC8).withOpacity(0.08)
              : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: activeCount > 0
                ? const Color(0xFF1A7EC8)
                : const Color(0xFFE0E0E0),
            width: 1.5.w,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.tune_rounded,
              size: 18.sp,
              color: activeCount > 0 ? const Color(0xFF1A7EC8) : Colors.grey,
            ),
            SizedBox(width: 6.w),
            Text(
              'Filters',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: activeCount > 0
                    ? const Color(0xFF1A7EC8)
                    : Colors.grey[700],
              ),
            ),

             if (activeCount > 0) ...[
              SizedBox(width: 6.w),
              Container(
                width: 20.w,
                height: 20.h,
                decoration: BoxDecoration(
                  color: Color(0xFF1A7EC8),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$activeCount',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}