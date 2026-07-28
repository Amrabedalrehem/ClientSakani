

import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/model/OnboardingModel.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';




List<OnboardingData> getOnboardingPages(BuildContext context) {
  final l10n = AppLocalizations.of(context);
  return [
    OnboardingData(
      icon: Icons.home_rounded,
      title: l10n?.onb1Title ?? 'Welcome to SUKNA',
      subtitle: l10n?.onb1Sub ?? 'Your #1 home-finding platform',
      description: l10n?.onb1Desc ?? 'Find the perfect home near your university — fast, safe, and hassle-free.',
      gradientColors: const [Color(0xFF1A7EC8), Color(0xFF29B6C8)],
    ),
    OnboardingData(
      icon: Icons.fact_check_rounded,
      title: l10n?.onb2Title ?? 'Browse & Compare',
      subtitle: l10n?.onb2Sub ?? 'All options in one place',
      description: l10n?.onb2Desc ?? 'Explore dozens of student housings with clear photos, prices, and amenities. Compare and choose what suits you.',
      gradientColors: const [Color(0xFF0FA89A), Color(0xFF1AC8B0)],
    ),
    OnboardingData(
      icon: Icons.person_rounded,
      title: l10n?.onb3Title ?? 'Contact Directly',
      subtitle: l10n?.onb3Sub ?? 'No middlemen, no hassle',
      description: l10n?.onb3Desc ?? 'Reach landlords directly by phone and close the deal as fast as possible.',
      gradientColors: const [Color(0xFF1A9EC8), Color(0xFF0FA89A)],
    ),
  ];
}
