import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/datasource/HomeDataSource.dart';
import 'package:flutter_application_1/data/model/HomeData.dart';

class PropertyCard extends StatelessWidget {
  final PropertyModel property;
  final bool isSaved;
  final VoidCallback onClose;
  final VoidCallback? onTap;

  const PropertyCard({
    super.key,
    required this.property,
    required this.isSaved,
    required this.onClose,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF1A7EC8),
                  Color(0xFF0FA89A),
                ],
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: const Icon(
              Icons.apartment_rounded,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  property.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(property.area),
                Text(
                  'EGP ${property.pricePerMonth}/mo',
                ),
              ],
            ),
          ),
        
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: onClose,
            ),
          ],
        ),
      ),
    );
  }
}