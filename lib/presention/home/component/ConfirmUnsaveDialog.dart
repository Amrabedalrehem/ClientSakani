import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<bool> showConfirmUnsaveDialog(BuildContext context) async {
  final bool? confirm = await showDialog<bool>(
    context: context,
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (context) => const _ConfirmUnsaveDialog(),
  );
  return confirm == true;
}

class _ConfirmUnsaveDialog extends StatelessWidget {
  const _ConfirmUnsaveDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(24.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             Container(
              width: 64.w,
              height: 64.h,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.bookmark_remove_rounded,
                size: 32.sp,
                color: Colors.redAccent,
              ),
            ),

            SizedBox(height: 16.h),

             Text(
              'Remove from Saved',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A2E),
              ),
            ),

            SizedBox(height: 10.h),

             Text(
              'Are you sure you want to remove this property from your saved list?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[500],
                height: 1.5.h,
              ),
            ),

            SizedBox(height: 24.h),

             Row(
              children: [
                 Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context, false),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F6FA),
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF555555),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 12.w),
                 Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context, true),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFEF5350), Color(0xFFE53935)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(14.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.redAccent.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Yes, Remove',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}