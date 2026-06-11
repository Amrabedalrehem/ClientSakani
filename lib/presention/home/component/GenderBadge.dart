import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/datasource/HomeDataSource.dart';
import 'package:flutter_application_1/data/model/HomeData.dart';

class GenderBadge extends StatelessWidget {
  final PropertyGender gender;

  const GenderBadge({required this.gender});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: gender.color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(gender.icon, size: 13, color: gender.color),
          const SizedBox(width: 4),
          Text(
            gender.label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: gender.color,
            ),
          ),
        ],
      ),
    );
  }
}