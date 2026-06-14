import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/model/HomeData.dart';

class DetailStatsCard extends StatelessWidget {
  final PropertyModel property;

  const DetailStatsCard({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Property Details',
      child: Row(
        children: [
          Expanded(
            child: _StatBox(
              label: 'Total Rooms',
              value: '${property.totalRooms}',
              bgColor: const Color(0xFFEBF3FB),
              valueColor: const Color(0xFF1A7EC8),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _StatBox(
              label: 'Total Beds',
              value: '${property.totalBeds}',
              bgColor: const Color(0xFFE8F5E9),
              valueColor: const Color(0xFF22C55E),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  final Color bgColor;
  final Color valueColor;

  const _StatBox({
    required this.label,
    required this.value,
    required this.bgColor,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A2E),
            ),
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}
