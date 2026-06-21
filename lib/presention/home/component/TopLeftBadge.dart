
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/core/const/HomeConst.dart';

class TopLeftBadge extends StatelessWidget {
  final AvailabilityStatus status;
  final int availableBeds;

  const TopLeftBadge({required this.status, required this.availableBeds});

  @override
  Widget build(BuildContext context) {
    if (status == AvailabilityStatus.available) return SizedBox.shrink();

    final isFullyBooked = status == AvailabilityStatus.fullyBooked;
    final label = isFullyBooked ? 'Fully Booked' : '$availableBeds beds left';
    final color = isFullyBooked ? const Color(0xFFE53935) : const Color(0xFFFF9800);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}