import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/core/const/HomeConst.dart';
import 'package:flutter_application_1/presention/home/component/AmenitiesRow.dart';
import 'package:flutter_application_1/presention/home/component/AvailabilityChip.dart';
import 'package:flutter_application_1/presention/home/component/GenderBadge.dart';

class PropertyInfo extends StatelessWidget {
  final PropertyModel property;

  const PropertyInfo({required this.property});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(14.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  property.name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
              ),
              GenderBadge(gender: property.gender),
            ],
          ),

          SizedBox(height: 8.h),

           Row(
            children: [
              Icon(Icons.location_on_outlined,
                  size: 15.sp, color: Color(0xFF1A7EC8)),
              SizedBox(width: 4.w),
              Text(
                property.area,
                style: TextStyle(fontSize: 13.sp, color: Colors.grey),
              ),
            ],
          ),

          SizedBox(height: 8.h),

           Row(
            children: [
              Icon(Icons.bed_outlined, size: 15.sp, color: Colors.grey),
              SizedBox(width: 4.w),
              Text(
                '${property.totalBeds} beds',
                style: TextStyle(fontSize: 13.sp, color: Colors.grey),
              ),
              SizedBox(width: 10.w),
              AvailabilityChip(
                status: property.availabilityStatus,
                availableBeds: property.availableBeds,
              ),
            ],
          ),

          SizedBox(height: 10.h),
 
          AmenitiesRow(amenities: property.amenities),
        ],
      ),
    );
  }
}