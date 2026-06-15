
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class AreaDropdown extends StatelessWidget {
  final String selectedArea;
  final List<String> areas;
  final ValueChanged<String> onChanged;

  const AreaDropdown({
    required this.selectedArea,
    required this.areas,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isFiltered = selectedArea != 'All Areas';

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isFiltered
              ? const Color(0xFF1A7EC8)
              : const Color(0xFFDDDDDD),
          width: 1.5.w,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedArea,
          isExpanded: true,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: isFiltered ? const Color(0xFF1A7EC8) : Colors.grey,
          ),
          style: TextStyle(
            fontSize: 14.sp,
            color: isFiltered ? const Color(0xFF1A7EC8) : const Color(0xFF555555),
            fontWeight: isFiltered ? FontWeight.w600 : FontWeight.w400,
          ),
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          items: areas.map((area) {
            final isSelected = area == selectedArea;
            return DropdownMenuItem(
              value: area,
              child: Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 16.sp,
                    color: isSelected
                        ? const Color(0xFF1A7EC8)
                        : Colors.grey,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    area,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                      color: isSelected
                          ? const Color(0xFF1A7EC8)
                          : const Color(0xFF333333),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (val) {
            if (val != null) onChanged(val);
          },
        ),
      ),
    );
  }
}

 