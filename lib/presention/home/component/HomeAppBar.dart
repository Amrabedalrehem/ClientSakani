import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/presention/home/component/FiltersButton.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int activeFiltersCount;
  final VoidCallback onFiltersTap;

  const HomeAppBar({
    super.key,
    required this.activeFiltersCount,
    required this.onFiltersTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleSpacing: 16,
      title: Row(
        children: [
           Container(
            width: 44.w,
            height: 44.h,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1A7EC8), Color(0xFF0FA89A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.home_rounded,
              color: Colors.white,
              size: 24.sp,
            ),
          ),

          SizedBox(width: 12.w),

           Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)?.homeTitle ?? 'Student Housing',
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  AppLocalizations.of(context)?.homeSubtitle ?? 'Find your perfect accommodation',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 16.w),
          child: FiltersButton(
            activeCount: activeFiltersCount,
            onTap: onFiltersTap,
          ),
        ),
      ],
    );
  }
}