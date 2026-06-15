import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/data/datasource/HomeDataSource.dart';
import 'package:flutter_application_1/core/const/HomeConst.dart';

class DetailHeaderCard extends StatelessWidget {
  final PropertyModel property;

  const DetailHeaderCard({super.key, required this.property});

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
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  property.name,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        '\$ ',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF22C55E),
                        ),
                      ),
                      Text(
                        '${property.pricePerMonth}',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF22C55E),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'per month',
                    style: TextStyle(fontSize: 11.sp, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 6.h),

          Row(
            children: [
              Icon(Icons.location_on_rounded,
                  size: 14.sp, color: Color(0xFF1A7EC8)),
              SizedBox(width: 3.w),
              Text(
                property.area,
                style: TextStyle(fontSize: 13.sp, color: Colors.grey),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          Row(
            children: [
              _Chip(
                icon: Icons.bed_rounded,
                label:
                    '${property.availableBeds} of ${property.totalBeds} beds available',
                bgColor: const Color(0xFFE8F5E9),
                fgColor: const Color(0xFF22C55E),
              ),
              SizedBox(width: 8.w),
              _Chip(
                icon: property.gender.icon,
                label: '${property.gender.label} Only',
                bgColor: const Color(0xFFEBF3FB),
                fgColor: const Color(0xFF1A7EC8),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color bgColor;
  final Color fgColor;

  const _Chip({
    required this.icon,
    required this.label,
    required this.bgColor,
    required this.fgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13.sp, color: fgColor),
          SizedBox(width: 4.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: fgColor,
            ),
          ),
        ],
      ),
    );
  }
}
