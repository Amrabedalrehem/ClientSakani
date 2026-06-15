import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterToggle extends StatelessWidget {
  final bool isSavedOnly;
  final VoidCallback onToggle;

  const FilterToggle({
    super.key,
    required this.isSavedOnly,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 7.h,
        ),
        decoration: BoxDecoration(
          color: isSavedOnly
              ? const Color(0xFF1A7EC8)
              : const Color(0xFFF0F4F8),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          isSavedOnly ? 'Saved only' : 'All',
          style: TextStyle(
            color: isSavedOnly
                ? Colors.white
                : Colors.grey,
          ),
        ),
      ),
    );
  }
}