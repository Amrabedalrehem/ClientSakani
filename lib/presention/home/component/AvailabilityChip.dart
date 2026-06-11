
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/model/HomeData.dart';

class AvailabilityChip extends StatelessWidget {
  final AvailabilityStatus status;
  final int availableBeds;

  const AvailabilityChip({required this.status, required this.availableBeds});

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case AvailabilityStatus.available:
        return _chip(
          label: '$availableBeds available',
          textColor: const Color(0xFF2E7D32),
          bgColor: const Color(0xFFE8F5E9),
        );
      case AvailabilityStatus.limitedBeds:
        return _chip(
          label: '$availableBeds available',
          textColor: const Color(0xFFE65100),
          bgColor: const Color(0xFFFFF3E0),
        );
      case AvailabilityStatus.fullyBooked:
        return _chip(
          label: 'No availability',
          textColor: const Color(0xFFC62828),
          bgColor: const Color(0xFFFFEBEE),
        );
    }
  }

  Widget _chip({
    required String label,
    required Color textColor,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}