import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/model/HomeData.dart';
import 'package:flutter_application_1/presention/home/component/PropertyImage.dart';
import 'package:flutter_application_1/presention/home/component/PropertyInfo.dart';

class PropertyCard extends StatelessWidget {
  final PropertyModel property;
  final VoidCallback onTap;
  final ValueChanged<bool> onSaveToggle;

  const PropertyCard({
    super.key,
    required this.property,
    required this.onTap,
    required this.onSaveToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          
            PropertyImage(property: property, onSaveToggle: onSaveToggle),
             PropertyInfo(property: property),
          ],
        ),
      ),
    );
  }
}
