import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/const/OnboardingConst.dart';

class OnboardingData {
  final IconData icon;
  final String title;
  final String subtitle;
  final String description;
  final List<Color> gradientColors;

  const OnboardingData({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.gradientColors,
  });
}