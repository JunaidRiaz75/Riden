// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riden/auth/signup_choice_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _pages = [
    OnboardingData(
      imagePath: 'assets/images/onboarding1.png',
      title: 'Move Your Way',
      subtitle:
          'Create your own path, move freely,\nand live life on your terms.',
    ),
    OnboardingData(
      imagePath: 'assets/images/onboarding2.png',
      title: 'Ride with Ease',
      subtitle:
          'Experience smooth, stress-free\ntravel designed for comfort,\nfreedom, and simplicity.',
    ),
    OnboardingData(
      imagePath: 'assets/images/onboarding3.png',
      title: 'Wherever You Go',
      subtitle:
          'Stay connected, stay comfortable\n— smart travel solutions for every\ndestination.',
    ),
  ];

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SignUpChoiceScreen()),
      ); // Replace with actual home screen
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    // Figma frame: 430 × 932
    // Button outer: 79×79, top:668, left:346
    // Button top ratio:  668/932 = 0.717
    // Button left ratio: 346/430 = 0.805  (but we place on right bar)
    final buttonTopRatio = 668 / 932; // 0.717
    final buttonSize = 70.0;
    final arrowIconSize = 50.0;

    // Red bar width ratio from Figma: screen right ~346px from left,
    // so bar starts at 346/430 = 0.805 → bar width = (430-346)/430 = 0.196
    final barWidthRatio = (380 - 346) / 430; // 0.196
    final barWidth = sw * barWidthRatio;

    // Bump protrudes left — button center sits at left edge of bar
    // Extra width to accommodate the bump + button overflow
    final totalBarWidth = barWidth + buttonSize * 0.55;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // ── PageView ──
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemBuilder: (_, index) => _OnboardingPage(data: _pages[index]),
          ),

          // ── Right red bar + bump + button ──
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            width: totalBarWidth,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Red bar with bump shape
                CustomPaint(
                  size: Size(totalBarWidth, sh),
                  painter: _RightBarPainter(
                    barWidth: barWidth,
                    bumpCenterRatio: buttonTopRatio,
                    bumpSize: buttonSize * 0.75,
                  ),
                ),

                // Arrow button — centered on bump
                Positioned(
                  top: sh * buttonTopRatio - buttonSize / 2,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: GestureDetector(
                      onTap: _nextPage,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Outer white glow: 0px 0px 14px 9px #FFFFFF80
                          Container(
                            width: buttonSize + 18,
                            height: buttonSize + 18,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.50),
                                  blurRadius: 14,
                                  spreadRadius: 9,
                                  offset: Offset.zero,
                                ),
                              ],
                            ),
                          ),
                          // Inner button: 79×79 with inset shadow simulated
                          // 0px 0px 4px 3px #E4E3E340 inset
                          Container(
                            width: buttonSize,
                            height: buttonSize,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                center: Alignment.center,
                                radius: 0.85,
                                colors: [
                                  Colors.white,
                                  const Color(0xFFE4E3E3).withOpacity(0.85),
                                ],
                                stops: const [0.60, 1.0],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFFE4E3E3,
                                  ).withOpacity(0.25),
                                  blurRadius: 4,
                                  spreadRadius: 3,
                                  offset: Offset.zero,
                                ),
                              ],
                            ),
                            // Arrow icon: 50×50 inside 79×79
                            child: Center(
                              child: Icon(
                                _currentPage == _pages.length - 1
                                    ? Icons.chevron_right_rounded
                                    : Icons.chevron_right_rounded,
                                color: const Color(0xFFF80F0F),
                                size: arrowIconSize,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Bottom text area ──
          Positioned(
            bottom: 0,
            left: 0,
            right: sw * barWidthRatio + 16,
            child: _BottomTextArea(
              data: _pages[_currentPage],
              currentPage: _currentPage,
              totalPages: _pages.length,
              screenHeight: sh,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Single onboarding page ────────────────────────────────────────────────────

class _OnboardingPage extends StatelessWidget {
  final OnboardingData data;
  const _OnboardingPage({required this.data});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    // Figma: red bar starts at x=346 on 430 frame
    // Illustration should be centered in the available white space (0 to 346)
    // Available width = sw * (346/430) = sw * 0.805
    final availableWidth = sw * (346 / 430);

    // Figma: illustration top ~180, height ~310 on 932 frame
    // top ratio: 180/932 = 0.193, height ratio: 310/932 = 0.333
    final illustrationTop = sh * 0.17;
    final illustrationHeight = sh * 0.36;

    // Equal horizontal padding inside available width
    final horizontalPad = availableWidth * 0.05; // 5% each side

    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          // ── Watermark leaf top-left ──
          Positioned(
            top: -sh * 0.04,
            left: -sw * 0.12,
            child: Image.asset(
              'assets/images/leaf.png',
              width: sw * 0.46,
              height: sw * 0.46,
              color: const Color(0xFFF80F0F).withOpacity(0.10),
              colorBlendMode: BlendMode.modulate,
            ),
          ),

          // ── Watermark leaf top-right (inside available white area) ──
          Positioned(
            top: -sh * 0.03,
            right: sw * 0.20, // keep inside white area, away from red bar
            child: Image.asset(
              'assets/images/leaf.png',
              width: sw * 0.38,
              height: sw * 0.38,
              color: const Color(0xFFF80F0F).withOpacity(0.10),
              colorBlendMode: BlendMode.modulate,
            ),
          ),

          // ── RIDEN logo ──
          Positioned(
            top: sh * 0.065,
            left: 0,
            right: sw * (84 / 430), // center within full width
            child: Center(
              child: Text(
                'RIDEN',
                style: GoogleFonts.audiowide(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),

          // ── Illustration — centered in available white space ──
          Positioned(
            top: illustrationTop,
            left: horizontalPad,
            width: availableWidth - horizontalPad * 2,
            height: illustrationHeight,
            child: Image.asset(
              data.imagePath,
              fit: BoxFit.contain,
              // No decoration/border — plain image
            ),
          ),
        ],
      ),
    );
  }
}

// ── Right bar CustomPainter ───────────────────────────────────────────────────

class _RightBarPainter extends CustomPainter {
  final double barWidth;
  final double bumpCenterRatio; // 0.0 to 1.0 vertical position
  final double bumpSize;

  const _RightBarPainter({
    required this.barWidth,
    required this.bumpCenterRatio,
    required this.bumpSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFF80F0F)
      ..style = PaintingStyle.fill;

    final path = Path();
    final leftEdge = size.width - barWidth;
    final bumpCenterY = size.height * bumpCenterRatio;
    final bumpH = bumpSize; // vertical half-size of bump
    final bumpW = bumpSize * 0.75; // how far bump protrudes left

    // Top-right → bottom-right → bottom-left of bar
    path.moveTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(leftEdge, size.height);

    // Up left edge to bottom of bump
    path.lineTo(leftEdge, bumpCenterY + bumpH);

    // Bump curves outward (left)
    path.cubicTo(
      leftEdge,
      bumpCenterY + bumpH * 0.6,
      leftEdge - bumpW,
      bumpCenterY + bumpH * 0.3,
      leftEdge - bumpW,
      bumpCenterY,
    );
    path.cubicTo(
      leftEdge - bumpW,
      bumpCenterY - bumpH * 0.3,
      leftEdge,
      bumpCenterY - bumpH * 0.6,
      leftEdge,
      bumpCenterY - bumpH,
    );

    // Continue up to top
    path.lineTo(leftEdge, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ── Bottom text area ──────────────────────────────────────────────────────────

class _BottomTextArea extends StatelessWidget {
  final OnboardingData data;
  final int currentPage;
  final int totalPages;
  final double screenHeight;

  const _BottomTextArea({
    required this.data,
    required this.currentPage,
    required this.totalPages,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 8,
        bottom: screenHeight * 0.045,
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Column(
          key: ValueKey(currentPage),
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Text(
              data.title,
              style: GoogleFonts.poppins(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFF80F0F),
                height: 1.2,
              ),
            ),
            const SizedBox(height: 8),

            // Subtitle
            Text(
              data.subtitle,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
                height: 1.6,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),

            // Page dots
            // Row(
            //   children: List.generate(
            //     totalPages,
            //     (i) => AnimatedContainer(
            //       duration: const Duration(milliseconds: 300),
            //       curve: Curves.easeInOut,
            //       margin: const EdgeInsets.only(right: 6),
            //       width: i == currentPage ? 24 : 8,
            //       height: 8,
            //       decoration: BoxDecoration(
            //         color: i == currentPage
            //             ? const Color(0xFFF80F0F)
            //             : const Color(0xFFCCCCCC),
            //         borderRadius: BorderRadius.circular(4),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

// ── Data model ────────────────────────────────────────────────────────────────

class OnboardingData {
  final String imagePath;
  final String title;
  final String subtitle;

  const OnboardingData({
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });
}
