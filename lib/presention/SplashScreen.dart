import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A7EC8),  
              Color(0xFF0FA89A),  
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.25),
                borderRadius: BorderRadius.circular(28),
              ),
              child: const Icon(
                Icons.home_rounded,
                size: 64,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),

             const Text(
              'Sakani',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),

            const SizedBox(height: 6),

             const Text(
              'STUDENT HOUSING',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.white,
                letterSpacing: 3.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}