import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/datasource/HomeDataSource.dart';
class GenderChips extends StatelessWidget {
  final GenderFilter selected;
  final ValueChanged<GenderFilter> onChanged;

  const GenderChips({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: GenderFilter.values.map((gender) {
        final isSelected = selected == gender;
        final color = gender.activeColor;

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: GestureDetector(
              onTap: () => onChanged(gender),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? color : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isSelected ? color : const Color(0xFFDDDDDD),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      gender.icon,
                      size: 14,
                      color: isSelected ? Colors.white : Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      gender.label,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}