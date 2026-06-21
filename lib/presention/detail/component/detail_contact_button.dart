import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/core/const/HomeConst.dart';
import 'package:url_launcher/url_launcher.dart';
class DetailContactButton extends StatelessWidget {
  final PropertyModel property;

  const DetailContactButton({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 0, 16, 24),
      height: 54.h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A7EC8), Color(0xFF22C55E)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1A7EC8).withOpacity(0.35),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(28.r),
          onTap: () async {
            final Uri launchUri = Uri(
              scheme: 'tel',
              path: '01093011701',
            );
            if (await canLaunchUrl(launchUri)) {
              await launchUrl(launchUri);
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.phone_rounded, color: Colors.white, size: 20.sp),
              SizedBox(width: 10.w),
              Text(
                property.phone.isNotEmpty ? property.phone : 'Contact Now',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
