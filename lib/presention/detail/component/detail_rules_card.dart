import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/core/const/HomeConst.dart';

class DetailRulesCard extends StatelessWidget {
  final PropertyModel property;

  const DetailRulesCard({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
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
            'Housing Rules',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 12.h),
          ...property.rules.map(
            (rule) => Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 6.h),
                    width: 6.w,
                    height: 6.h,
                    decoration: BoxDecoration(
                      color: Color(0xFF1A7EC8),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      rule,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                        height: 1.4.h,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
