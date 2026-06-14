import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/model/HomeData.dart';

class DetailServicesCard extends StatelessWidget {
  final PropertyModel property;

  const DetailServicesCard({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    final amenities = property.amenities;

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
          const Text(
            'Services Included',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A2E),
            ),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: amenities.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 5,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (_, i) => Row(
              children: [
                const Icon(Icons.check_circle_rounded,
                    size: 18, color: Color(0xFF22C55E)),
                const SizedBox(width: 6),
                Text(
                  amenities[i],
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
