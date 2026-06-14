import 'package:flutter/material.dart';

class LangButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const LangButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 200,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 7,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF1A7EC8)
              : Colors.transparent,
          borderRadius:
              BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: isSelected
                ? Colors.white
                : Colors.grey,
          ),
        ),
      ),
    );
  }
}