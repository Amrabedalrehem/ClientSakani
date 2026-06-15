
 
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/presention/home/component/ConfirmUnsaveDialog.dart';

class BookmarkButton extends StatelessWidget {
  final bool isSaved;
  final ValueChanged<bool> onToggle;

  const BookmarkButton({required this.isSaved, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (isSaved) {
          final confirm = await showConfirmUnsaveDialog(context);
          if (confirm) onToggle(false);
        } else {
          onToggle(true);
        }
      },
      child: TweenAnimationBuilder<double>(
        key: ValueKey(isSaved),
        duration: const Duration(milliseconds: 400),
        tween: Tween(begin: 0.0, end: 1.0),
        curve: Curves.easeInOutCubic,
        builder: (context, value, child) {
          double scale = 1.0;
          if (isSaved) {
            // value goes 0 to 1, sin(value * pi) goes 0 -> 1 -> 0
            scale = 1.0 + (math.sin(value * math.pi) * 0.4);
          }
          return Transform.scale(
            scale: scale,
            child: child,
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 36.w,
          height: 36.h,
          decoration: BoxDecoration(
            color: isSaved ? const Color(0xFF1A7EC8) : Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
            size: 18.sp,
            color: isSaved ? Colors.white : Colors.grey[600],
          ),
        ),
      ),
    );
  }
}
