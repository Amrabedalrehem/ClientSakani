import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';

class PriceBadge extends StatelessWidget {
  final int price;

  const PriceBadge({required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Text(
            AppLocalizations.of(context)?.pricePerMo(price) ?? 'EGP $price/mo',
            style: TextStyle(
              fontSize: 12.sp,
              color: Color(0xFF4CAF50),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
