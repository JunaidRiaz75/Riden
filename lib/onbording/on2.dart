// ============================================================
//  RIDEN — Onboarding Screen 2  "Ride with Ease"
//
//  The right-side red wave (assets/1.png / Group_3.png) has
//  a baked-in arrow circle at y=68–87 % of image height.
//  A transparent GestureDetector is overlaid pixel-perfectly
//  on that circle and calls _onNext() when tapped.
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riden/Booking/bookingdetail.dart';
import 'package:riden/theme/colors.dart';
import 'package:riden/onbording/on3.dart';

// ── Color palette ─────────────────────────────────────────
// ── Dark theme colors ─────────────────────────────────────
class _C {
  static const background = RidenColors.backgroundBase;
  static const brandRed = RidenColors.brandRed;
  static const titleDark = RidenColors.textPrimary;
  static const bodyText = RidenColors.textSecondary;
}

// ════════════════════════════════════════════════════════════
//  ONBOARDING SCREEN 1
// ════════════════════════════════════════════════════════════

class On2 extends StatefulWidget {
  const On2({super.key});

  @override
  State<On2> createState() => _On2State();
}

class _On2State extends State<On2> with SingleTickerProviderStateMixin {
  late final AnimationController _anim;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fade = CurvedAnimation(parent: _anim, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _anim, curve: Curves.easeOutCubic));

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _anim.forward();
    });
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  // ── Navigation ─────────────────────────────────────────
  void _onNext() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const On3()),
      // ↑ Replace On2 with your actual next screen widget
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // ── Measurements derived from pixel analysis of Group_3.png ──
    // Image is 229 × 2000 px.  Circle occupies y = 68 %–87 % of height.
    // Circle center: y ≈ 76 %, x ≈ 57 % of image width.
    //
    // On screen the image fills:  right=0, width = size.width * 0.22,
    //                              top=0,  height = size.height
    //
    // So the circle on screen:
    //   top    = size.height * 0.68
    //   height = size.height * 0.19          (87 % – 68 %)
    //   right  = 0
    //   width  = size.width * 0.22           (full image width)
    final double imgW = size.width * 0.22;
    final double circleTop = size.height * 0.68;
    final double circleH = size.height * 0.19;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      ),

      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            // ── 1. Dark glossy gradient background ──────
            const RidenDarkBackground(),

            // ── 2. Top-left floral decoration ─────────────────
            Positioned(
              top: 0,
              left: 0,
              width: size.width * 0.52,
              height: size.height * 0.28,
              child: Image.asset(
                'assets/on1.1.png',
                fit: BoxFit.contain,
                alignment: Alignment.topLeft,
              ),
            ),

            // ── 3. Bottom-left floral decoration ──────────────
            Positioned(
              bottom: 0,
              left: 0,
              width: size.width * 2.50,
              height: size.height * 0.45,
              child: Image.asset(
                'assets/on1.3.png',
                fit: BoxFit.contain,
                alignment: Alignment.bottomLeft,
              ),
            ),

            // ── 4. Right-side red wave image ───────────────────
            //    Pinned to right edge, spans full screen height.
            //    The arrow circle is baked into the image — do NOT
            //    make the whole image tappable, use the overlay below.
            Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              width: imgW,
              child: Image.asset(
                'assets/1.png', // ← your Group_3.png file
                fit: BoxFit.fill,
                alignment: Alignment.centerRight,
              ),
            ),

            // ── 5. Transparent tap target over the arrow circle ─
            //    Positioned pixel-perfectly over the baked-in circle.
            //    Completely invisible — the image beneath shows through.
            Positioned(
              top: circleTop,
              right: 0,
              width: imgW,
              height: circleH,
              child: GestureDetector(
                onTap: _onNext,
                behavior: HitTestBehavior
                    .opaque, // catches taps even on transparent area
                child:
                    const SizedBox.expand(), // invisible — image shows through
              ),
            ),

            // ── 6. Main content ───────────────────────────────
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // RIDEN title
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Center(
                      child: Text(
                        'RIDEN',
                        style: GoogleFonts.audiowide(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: _C.titleDark,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),

                  // Centre illustration
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Center(
                        child: Image.asset('assets/2.png', fit: BoxFit.contain),
                      ),
                    ),
                  ),

                  // Heading + subtitle
                  FadeTransition(
                    opacity: _fade,
                    child: SlideTransition(
                      position: _slide,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          24,
                          0,
                          size.width * 0.26, // clear the wave
                          32,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ride with Ease',
                              style: GoogleFonts.outfit(
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                                color: _C.brandRed,
                                height: 1.2,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Text(
                              'Experience smooth, stress-free \n'
                              'travel designed for comfort,freedom, and simplicity.',
                              style: GoogleFonts.outfit(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: _C.bodyText,
                                height: 1.55,
                              ),
                            ),

                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),

            // ── 7. iOS home indicator ─────────────────────────
            Positioned(
              bottom: 8,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 134,
                  height: 5,
                  decoration: BoxDecoration(
                    color: RidenColors.homeIndicator,
                    borderRadius: BorderRadius.circular(3),
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
