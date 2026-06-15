import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/presention/settings/component/lang_button.dart';
import 'package:flutter_application_1/presention/settings/component/settings_tile.dart';
 

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  String _selectedLanguage = 'EN';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
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
                  'Settings',
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A2E),
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
            Divider(color: Color(0xFFEEEEEE), height: 1.h),
            SizedBox(height: 8.h),

            SettingsTile(
              icon: _isDarkMode
                  ? Icons.nightlight_round
                  : Icons.wb_sunny_outlined,
              iconColor: const Color(0xFFF59E0B),
              title: 'Dark Mode',
              subtitle:
                  _isDarkMode ? 'Currently dark' : 'Currently light',
              trailing: Switch(
                value: _isDarkMode,
                onChanged: (val) =>
                    setState(() => _isDarkMode = val),
                activeColor: const Color(0xFF1A7EC8),
              ),
            ),

            SizedBox(height: 4.h),
            Divider(color: Color(0xFFEEEEEE), height: 1.h),
            SizedBox(height: 4.h),

            SettingsTile(
              icon: Icons.language_rounded,
              iconColor: const Color(0xFF22C55E),
              title: 'Language',
              subtitle: _selectedLanguage == 'EN'
                  ? 'English'
                  : 'Arabic',
              trailing: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFEEEEEE),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LangButton(
                      label: 'EN',
                      isSelected: _selectedLanguage == 'EN',
                      onTap: () => setState(
                        () => _selectedLanguage = 'EN',
                      ),
                    ),
                    LangButton(
                      label: 'AR',
                      isSelected: _selectedLanguage == 'AR',
                      onTap: () => setState(
                        () => _selectedLanguage = 'AR',
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 4.h),
            Divider(color: Color(0xFFEEEEEE), height: 1.h),
          ],
        ),
      ),
    );
  }
}