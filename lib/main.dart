import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/core/dp/HiveService.dart';
import 'package:flutter_application_1/data/shared%20prefrence/SettingsService.dart';
import 'package:flutter_application_1/presention/home/cubit/home_cubit.dart';
import 'package:flutter_application_1/presention/settings/cubit/settings_cubit.dart';
import 'package:flutter_application_1/presention/slash/SplashScreen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  await SettingsService.init();
  runApp(const SakaniApp());
}

class SakaniApp extends StatelessWidget {
  const SakaniApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SettingsCubit>(
          create: (_) => SettingsCubit(),
        ),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, settingsState) {
          return ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp(
                title: 'Sakani',
                debugShowCheckedModeBanner: false,
                locale: settingsState.language.toLowerCase() == 'ar' ? const Locale('ar') : const Locale('en'),
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en', ''),
                  Locale('ar', ''),
                ],
                theme: ThemeData(
                  fontFamily: 'Inter',
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: const Color(0xFF1A7EC8),
                    brightness: Brightness.light,
                    surface: Colors.white,
                    onSurface: const Color(0xFF1A1A2E),
                  ),
                  scaffoldBackgroundColor: const Color(0xFFF4F6FA),
                  dividerColor: const Color(0xFFEEEEEE),
                  useMaterial3: true,
                ),
                darkTheme: ThemeData(
                  fontFamily: 'Inter',
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: const Color(0xFF1A7EC8),
                    brightness: Brightness.dark,
                    surface: const Color(0xFF1E1E1E),
                    onSurface: Colors.white,
                  ),
                  scaffoldBackgroundColor: const Color(0xFF121212),
                  dividerColor: const Color(0xFF2C2C2C),
                  useMaterial3: true,
                ),
                themeMode: settingsState.isDarkMode
                    ? ThemeMode.dark
                    : ThemeMode.light,
                home: const SplashScreen(),
              );
            },
          );
        },
      ),
    );
  }
}