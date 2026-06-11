import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/model/HomeData.dart';
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
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: SizedBox(
        height: 180,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
             Image.network(
              property.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: Colors.grey[200],
                child: const Icon(Icons.image_not_supported_outlined,
                    size: 40, color: Colors.grey),
              ),
            ),
            if (property.availabilityStatus == AvailabilityStatus.fullyBooked)
              Container(color: Colors.black.withOpacity(0.35)),

            Positioned(
              top: 12,
              left: 12,
              child: TopLeftBadge(status: property.availabilityStatus,
                  availableBeds: property.availableBeds),
            ),

             Positioned(
              top: 12,
              right: 12,
              child: PriceBadge(price: property.pricePerMonth),
            ),
            Positioned(
              bottom: 12,
              right: 12,
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