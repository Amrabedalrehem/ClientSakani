 

 
import 'package:flutter/material.dart';

class OnboardingIcon extends StatefulWidget {
  final IconData icon;

  const OnboardingIcon({super.key, required this.icon});

  @override
  State<OnboardingIcon> createState() => _OnboardingIconState();
}

class _OnboardingIconState extends State<OnboardingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    _pulseAnim = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _pulseAnim,
      child: Container(
        width: 140,
        height: 140,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.20),
        ),
        child: Center(
          child: Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.30),
            ),
            child: Icon(
              widget.icon,
              size: 44,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

 