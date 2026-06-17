
 
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';

class EmptyState extends StatelessWidget {
  const EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_rounded, size: 56.sp, color: Colors.grey[350]),
          SizedBox(height: 16.h),
          Text(
            AppLocalizations.of(context)?.emptyFilterTitle ?? 'No housing matches your filters.',
            style: TextStyle(fontSize: 15.sp, color: Colors.grey[500]),
          ),
          SizedBox(height: 8.h),
          TextButton(
            onPressed: () {},
            child: Text(
              AppLocalizations.of(context)?.emptyFilterDesc ?? 'Clear all filters',
              style: TextStyle(
                fontSize: 14.sp,
                color: Color(0xFF1A7EC8),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}