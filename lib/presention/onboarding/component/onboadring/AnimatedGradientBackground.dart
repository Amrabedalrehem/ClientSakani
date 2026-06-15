import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedGradientBackground extends StatelessWidget {
  final List<Color> gradientColors;
  final Widget child;

  const AnimatedGradientBackground({
    super.key,
    required this.gradientColors,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      builder: (context, value, _) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: gradientColors,
            ),
          ),
          child: child,
        );
      },
    );
  }
}