import 'package:Riden/auth/signup_choice_screen.dart';
import 'package:Riden/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:riden/on.dart'; // ← import your On1 screen

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  // Fade + scale + slide animation for the RIDEN text
  late final AnimationController _ctrl;
  late final Animation<double> _fade;
  late final Animation<double> _scale;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();

    // Make status bar transparent with light icons
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    // Text entrance animation
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    
    _fade = CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
    );
    
    _scale = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.5), // starts down by 50% of its size
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );

    // Start text animation reliably after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _ctrl.forward(from: 0.0);
      }
    });

    // After 3.5 seconds navigate
    Future.delayed(const Duration(milliseconds: 3500), _goToOn1);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _goToOn1() {
    if (!mounted) return;
    Get.off(
      () => const SignUpChoiceScreen(),
      transition: Transition.fadeIn,
      duration: const Duration(milliseconds: 800),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── Dark gradient background ──────────────────────
          const RidenDarkBackground(),

          // ── Animated RIDEN text ───────────────────────────
          Center(
            child: FadeTransition(
              opacity: _fade,
              child: SlideTransition(
                position: _slide,
                child: ScaleTransition(
                  scale: _scale,
                  child: Text(
                    'RIDEN',
                    style: GoogleFonts.audiowide(
                      fontSize: 44,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 141, 145, 148),
                      letterSpacing: 7,
                      shadows: const [
                        Shadow(color: Color(0x33FFFFFF), blurRadius: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
