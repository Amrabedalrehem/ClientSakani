
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/model/HomeData.dart';

class TopLeftBadge extends StatelessWidget {
  final AvailabilityStatus status;
  final int availableBeds;

  const TopLeftBadge({required this.status, required this.availableBeds});

  @override
  Widget build(BuildContext context) {
    if (status == AvailabilityStatus.available) return const SizedBox.shrink();

    final isFullyBooked = status == AvailabilityStatus.fullyBooked;
    final label = isFullyBooked ? 'Fully Booked' : '$availableBeds beds left';
    final color = isFullyBooked ? const Color(0xFFE53935) : const Color(0xFFFF9800);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}