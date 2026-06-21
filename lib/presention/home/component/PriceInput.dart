
 
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';

 
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
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isActive
                ? const Color(0xFF1A7EC8)
                : const Color(0xFFDDDDDD),
            width: 1.5.w,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.attach_money_rounded,
              size: 18.sp,
              color: isActive ? const Color(0xFF1A7EC8) : Colors.grey,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: onChanged,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Color(0xFF333333),
                ),
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)?.filterPriceRange ?? 'Max price per month',
                  hintStyle: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[400],
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 10.h),
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
                    child: Icon(Icons.arrow_drop_up,
                        size: 20.sp, color: Colors.grey),
                  ),
                  GestureDetector(
                    onTap: () {
                      final current = int.tryParse(controller.text) ?? 0;
                      if (current > 50) {
                        controller.text = '${current - 50}';
                        onChanged(controller.text);
                      }
                    },
                    child: Icon(Icons.arrow_drop_down,
                        size: 20.sp, color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(width: 4.w),
              GestureDetector(
                onTap: onClear,
                child: Icon(Icons.close_rounded,
                    size: 18.sp, color: Colors.grey),
              ),
            ],
          ],
        ),
      ),
    );
  }
}


