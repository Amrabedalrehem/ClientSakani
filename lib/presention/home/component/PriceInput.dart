
 
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

 
class PriceInput extends StatelessWidget {
  final TextEditingController controller;
  final bool isFocused;
  final ValueChanged<bool> onFocusChange;
  final VoidCallback onClear;
  final ValueChanged<String> onChanged;

  const PriceInput({
    required this.controller,
    required this.isFocused,
    required this.onFocusChange,
    required this.onClear,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final hasValue = controller.text.isNotEmpty;
    final isActive = isFocused || hasValue;

    return Focus(
      onFocusChange: onFocusChange,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isActive
                ? const Color(0xFF1A7EC8)
                : const Color(0xFFDDDDDD),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.attach_money_rounded,
              size: 18,
              color: isActive ? const Color(0xFF1A7EC8) : Colors.grey,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: onChanged,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF333333),
                ),
                decoration: InputDecoration(
                  hintText: 'Max price per month',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[400],
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),

             if (hasValue) ...[
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      final current = int.tryParse(controller.text) ?? 0;
                      controller.text = '${current + 50}';
                      onChanged(controller.text);
                    },
                    child: const Icon(Icons.arrow_drop_up,
                        size: 20, color: Colors.grey),
                  ),
                  GestureDetector(
                    onTap: () {
                      final current = int.tryParse(controller.text) ?? 0;
                      if (current > 50) {
                        controller.text = '${current - 50}';
                        onChanged(controller.text);
                      }
                    },
                    child: const Icon(Icons.arrow_drop_down,
                        size: 20, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(width: 4),
              GestureDetector(
                onTap: onClear,
                child: const Icon(Icons.close_rounded,
                    size: 18, color: Colors.grey),
              ),
            ],
          ],
        ),
      ),
    );
  }
}


