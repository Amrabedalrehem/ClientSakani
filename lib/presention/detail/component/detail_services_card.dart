import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/core/const/HomeConst.dart';

class DetailServicesCard extends StatelessWidget {
  final PropertyModel property;

  const DetailServicesCard({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    final amenities = property.amenities;

    return Container(
      margin: EdgeInsets.fromLTRB(16, 0, 16, 12),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Services Included',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 12.h),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: amenities.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 5,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (_, i) => Row(
              children: [
                Icon(Icons.check_circle_rounded,
                    size: 18.sp, color: Color(0xFF22C55E)),
                SizedBox(width: 6.w),
                Text(
                  amenities[i],
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
