import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/model/HomeData.dart';
import 'package:flutter_application_1/presention/home/component/AmenitiesRow.dart';
import 'package:flutter_application_1/presention/home/component/AvailabilityChip.dart';
import 'package:flutter_application_1/presention/home/component/GenderBadge.dart';

class PropertyInfo extends StatelessWidget {
  final PropertyModel property;

  const PropertyInfo({required this.property});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  property.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
              ),
              GenderBadge(gender: property.gender),
            ],
          ),

          const SizedBox(height: 8),

           Row(
            children: [
              const Icon(Icons.location_on_outlined,
                  size: 15, color: Color(0xFF1A7EC8)),
              const SizedBox(width: 4),
              Text(
                property.area,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),

          const SizedBox(height: 8),

           Row(
            children: [
              const Icon(Icons.bed_outlined, size: 15, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                '${property.totalBeds} beds',
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
              const SizedBox(width: 10),
              AvailabilityChip(
                status: property.availabilityStatus,
                availableBeds: property.availableBeds,
              ),
            ],
          ),

          const SizedBox(height: 10),
 
          AmenitiesRow(amenities: property.amenities),
        ],
      ),
    );
  }
}