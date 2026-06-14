import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/network/HiveService.dart';
import 'package:flutter_application_1/data/shared%20prefrence/SettingsService.dart';
import 'package:flutter_application_1/presention/home/HomeScreen.dart';
import 'package:flutter_application_1/presention/onboarding/OnboardingScreen.dart';
import 'package:flutter_application_1/presention/slash/SplashScreen.dart';
 import 'package:flutter/material.dart';
 import 'package:flutter/material.dart';

 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();        
  await SettingsService.init();     
  runApp(const SakaniApp());
}

class SakaniApp extends StatefulWidget {
  const SakaniApp({super.key});

  @override
  State<SakaniApp> createState() => _SakaniAppState();
}

class _SakaniAppState extends State<SakaniApp> {
  bool _isDarkMode = SettingsService.isDarkMode;
  Locale _locale = Locale(SettingsService.language);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sakani',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A7EC8),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        fontFamily: 'Inter',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A7EC8),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      locale: _locale,
      home: const SplashScreen(),
    );
  }
}