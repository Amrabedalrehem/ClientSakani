import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/presention/settings/component/lang_button.dart';
import 'package:flutter_application_1/presention/settings/component/settings_tile.dart';
import 'package:flutter_application_1/presention/settings/cubit/settings_cubit.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
     final cubit = context.read<SettingsCubit>();

    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final isDark = state.isDarkMode;
        final lang = state.language.toUpperCase();

        return Scaffold(
          appBar: AppBar(
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
                    Icons.settings_rounded,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)?.settings ?? 'Settings',
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      'Customize your experience',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(color: Theme.of(context).dividerColor, height: 1.h),
                SizedBox(height: 8.h),

                SettingsTile(
                  icon: isDark
                      ? Icons.nightlight_round
                      : Icons.wb_sunny_outlined,
                  iconColor: const Color(0xFFF59E0B),
                  title: AppLocalizations.of(context)?.darkMode ?? 'Dark Mode',
                  subtitle: isDark ? 'Currently dark' : 'Currently light',
                  trailing: Switch(
                    value: isDark,
                    onChanged: (_) => cubit.toggleDarkMode(),
                    activeColor: const Color(0xFF1A7EC8),
                  ),
                ),

                SizedBox(height: 4.h),
                Divider(color: Theme.of(context).dividerColor, height: 1.h),
                SizedBox(height: 4.h),

                SettingsTile(
                  icon: Icons.language_rounded,
                  iconColor: const Color(0xFF22C55E),
                  title: AppLocalizations.of(context)?.language ?? 'Language',
                  subtitle: lang == 'EN' ? 'English' : 'Arabic',
                  trailing: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).dividerColor,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        LangButton(
                          label: 'EN',
                          isSelected: lang == 'EN',
                          onTap: () => cubit.setLanguage('en'),
                        ),
                        LangButton(
                          label: 'AR',
                          isSelected: lang == 'AR',
                          onTap: () => cubit.setLanguage('ar'),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 4.h),
                Divider(color: Theme.of(context).dividerColor, height: 1.h),
              ],
            ),
          ),
        );
      },
    );
  }
}