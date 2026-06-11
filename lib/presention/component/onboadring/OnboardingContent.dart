

 
 import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/model/OnboardingData.dart';

class OnboardingContent extends StatelessWidget {
  final OnboardingData data;

  const OnboardingContent({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          data.title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          data.subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          data.description,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withOpacity(0.85),
            height: 1.6,
          ),
        ),
      ],
    );
  }
}
