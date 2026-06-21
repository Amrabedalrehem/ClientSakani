

import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/model/OnboardingModel.dart';




const List<OnboardingData> kOnboardingPages = [
  OnboardingData(
    icon: Icons.home_rounded,
    title: 'Welcome to Sakani',
    subtitle: 'Your #1 Student Housing Platform',
    description:
        'Find the perfect home near your university — fast, safe, and hassle-free.',
    gradientColors: [Color(0xFF1A7EC8), Color(0xFF29B6C8)],
  ),
  OnboardingData(
    icon: Icons.fact_check_rounded,
    title: 'Browse & Compare',
    subtitle: 'All options in one place',
    description:
        'Explore dozens of student housings with clear photos, prices, and amenities. Compare and choose what suits you.',
    gradientColors: [Color(0xFF0FA89A), Color(0xFF1AC8B0)],
  ),
  OnboardingData(
    icon: Icons.person_rounded,
    title: 'Contact Directly',
    subtitle: 'No middlemen, no hassle',
    description:
        'Reach landlords directly by phone and close the deal as fast as possible.',
    gradientColors: [Color(0xFF1A9EC8), Color(0xFF0FA89A)],
  ),
];