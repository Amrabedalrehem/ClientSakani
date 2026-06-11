import 'package:flutter/material.dart';

class PriceBadge extends StatelessWidget {
  final int price;

  const PriceBadge({required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Text(
            '\$ ',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF4CAF50),
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            '$price/mo',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A2E),
            ),
          ),
        ],
      ),
    );
  }
}