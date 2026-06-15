import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/core/const/HomeConst.dart';
 class GenderChips extends StatelessWidget {
  final GenderFilter selected;
  final ValueChanged<GenderFilter> onChanged;

  const GenderChips({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: GenderFilter.values.map((gender) {
        final isSelected = selected == gender;
        final color = gender.activeColor;

        return Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            child: GestureDetector(
              onTap: () => onChanged(gender),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSelected ? color : Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: isSelected ? color : const Color(0xFFDDDDDD),
                    width: 1.5.w,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      gender.icon,
                      size: 14.sp,
                      color: isSelected ? Colors.white : Colors.grey[600],
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      gender.label,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}