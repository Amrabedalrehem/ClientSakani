import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/core/const/HomeConst.dart';

class DetailStatsCard extends StatelessWidget {
  final PropertyModel property;

  const DetailStatsCard({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Property Details',
      child: Row(
        children: [
          Expanded(
            child: _StatBox(
              label: 'Total Rooms',
              value: '${property.totalRooms}',
              bgColor: const Color(0xFFEBF3FB),
              valueColor: const Color(0xFF1A7EC8),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: _StatBox(
              label: 'Total Beds',
              value: '${property.totalBeds}',
              bgColor: const Color(0xFFE8F5E9),
              valueColor: const Color(0xFF22C55E),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  final Color bgColor;
  final Color valueColor;

  const _StatBox({
    required this.label,
    required this.value,
    required this.bgColor,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 12.sp, color: Colors.grey),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 0, 16, 12),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A2E),
            ),
          ),
          SizedBox(height: 14.h),
          child,
        ],
      ),
    );
  }
}
