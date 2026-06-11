
 
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/model/OnboardingData.dart';
import 'package:flutter_application_1/presention/onboarding/component/onboadring/OnboardingContent.dart';
import 'package:flutter_application_1/presention/onboarding/component/onboadring/OnboardingIcon.dart';

class OnboardingPage extends StatefulWidget {
  final OnboardingData data;
  final bool isActive;

  const OnboardingPage({
    super.key,
    required this.data,
    required this.isActive,
  });

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    if (widget.isActive) _controller.forward();
  }

  @override
  void didUpdateWidget(OnboardingPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           OnboardingIcon(icon: widget.data.icon),

          const SizedBox(height: 48),
          FadeTransition(
            opacity: _fadeAnim,
            child: SlideTransition(
              position: _slideAnim,
              child: OnboardingContent(data: widget.data),
            ),
          ),
        ],
      ),
    );
  }
}
 
 