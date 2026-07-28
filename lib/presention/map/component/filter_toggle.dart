import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';

class FilterToggle extends StatelessWidget {
  final bool isSavedOnly;
  final VoidCallback onToggle;

  const FilterToggle({
    super.key,
    required this.isSavedOnly,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onToggle,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 7.h,
        ),
        decoration: BoxDecoration(
          color: isSavedOnly
              ? const Color(0xFF1A7EC8)
              : (isDark ? scheme.surface.withOpacity(0.85) : const Color(0xFFF0F4F8)),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSavedOnly
                ? const Color(0xFF1A7EC8)
                : (isDark ? Colors.white12 : const Color(0xFFE0E0E0)),
          ),
        ),
        child: Text(
          isSavedOnly 
              ? (AppLocalizations.of(context)?.savedOnly ?? 'Saved only')
              : (AppLocalizations.of(context)?.allProperties ?? 'All'),
          style: TextStyle(
            color: isSavedOnly
                ? Colors.white
                : scheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
