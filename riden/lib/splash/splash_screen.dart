// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riden/onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _leafFade;
  late Animation<double> _textFade;
  late Animation<Offset> _textSlide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _leafFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _textFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
      ),
    );

    _textSlide = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
          ),
        );

    _controller.forward();

    // Uncomment when ready to navigate:
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const OnboardingScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // ── Maple leaf ──────────────────────────────────────────
            // Figma: leaf width = 397/430 = 92% of screen width
            // Figma: leaf height = 460/932 = 49% of screen height
            // Centered both vertically and horizontally
            FadeTransition(
              opacity: _leafFade,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.92,
                height: MediaQuery.of(context).size.height * 0.49,
                child: Image.asset(
                  'assets/images/leaf.png',
                  fit: BoxFit.fill,
                  color: const Color(0xFFF80F0F).withOpacity(0.09),
                  colorBlendMode: BlendMode.modulate,
                ),
              ),
            ),

            // ── RIDEN text ──────────────────────────────────────────
            FadeTransition(
              opacity: _textFade,
              child: SlideTransition(
                position: _textSlide,
                child: Text(
                  'RIDEN',
                  style: GoogleFonts.audiowide(
                    fontSize: 40,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFFF80F0F),
                    height: 1.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
