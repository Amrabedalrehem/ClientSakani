import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/core/const/HomeConst.dart';
import 'package:flutter_application_1/presention/home/component/BookmarkButton.dart';
import 'package:flutter_application_1/presention/home/component/PriceBadge.dart';
import 'package:flutter_application_1/presention/home/component/TopLeftBadge.dart';

class PropertyImage extends StatelessWidget {
  final PropertyModel property;
  final ValueChanged<bool> onSaveToggle;

  const PropertyImage({required this.property, required this.onSaveToggle});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      child: SizedBox(
        height: 180.h,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
             Image.network(
              property.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: Colors.grey[200],
                child: Icon(Icons.image_not_supported_outlined,
                    size: 40.sp, color: Colors.grey),
              ),
            ),
            if (property.availabilityStatus == AvailabilityStatus.fullyBooked)
              Container(color: Colors.black.withOpacity(0.35)),

            Positioned(
              top: 12.h,
              left: 12.w,
              child: TopLeftBadge(status: property.availabilityStatus,
                  availableBeds: property.availableBeds),
            ),

             Positioned(
              top: 12.h,
              right: 12.w,
              child: PriceBadge(price: property.pricePerMonth),
            ),
            Positioned(
              bottom: 12.h,
              right: 12.w,
              child: BookmarkButton(
                isSaved: property.isSaved,
                onToggle: onSaveToggle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}