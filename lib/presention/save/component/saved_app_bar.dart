import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SavedAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final int savedCount;

  const SavedAppBar({
    super.key,
    required this.savedCount,
  });

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleSpacing: 16,
      title: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.h,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF1A7EC8),
                  Color(0xFF0FA89A),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.bookmark_rounded,
              color: Colors.white,
              size: 24.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Saved',
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              Text(
                '$savedCount properties saved',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}