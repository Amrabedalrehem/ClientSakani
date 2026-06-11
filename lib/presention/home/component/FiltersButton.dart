
import 'package:flutter/material.dart';

class FiltersButton extends StatelessWidget {
  final int activeCount;
  final VoidCallback onTap;

  const FiltersButton({required this.activeCount, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: activeCount > 0
              ? const Color(0xFF1A7EC8).withOpacity(0.08)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: activeCount > 0
                ? const Color(0xFF1A7EC8)
                : const Color(0xFFE0E0E0),
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.tune_rounded,
              size: 18,
              color: activeCount > 0 ? const Color(0xFF1A7EC8) : Colors.grey,
            ),
            const SizedBox(width: 6),
            Text(
              'Filters',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: activeCount > 0
                    ? const Color(0xFF1A7EC8)
                    : Colors.grey[700],
              ),
            ),

             if (activeCount > 0) ...[
              const SizedBox(width: 6),
              Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  color: Color(0xFF1A7EC8),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$activeCount',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}