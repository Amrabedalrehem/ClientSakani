import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/core/const/HomeConst.dart';

class PropertyMarker extends StatelessWidget {
  final PropertyModel property;
  final bool isSaved;
  final bool isSelected;

  const PropertyMarker({
    super.key,
    required this.property,
    required this.isSaved,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final color =
        isSaved ? const Color(0xFF1A7EC8) : Colors.grey[600]!;
    final size = isSelected ? 52.0 : 44.0;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2.5.w),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: isSelected ? 12 : 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Icon(
        isSaved
            ? Icons.bookmark_rounded
            : Icons.home_rounded,
        color: Colors.white,
        size: isSelected ? 26 : 20,
      ),
    );
  }
}