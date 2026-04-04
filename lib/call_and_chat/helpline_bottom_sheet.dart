// helpline_bottom_sheet.dart
// ignore_for_file: use_super_parameters, deprecated_member_use

import 'dart:ui';

import 'package:Riden/widgets/riden_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ENTRY
// ─────────────────────────────────────────────────────────────────────────────
class HelplineBottomSheetEntry extends StatelessWidget {
  const HelplineBottomSheetEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.70,
      minChildSize: 0.50,
      maxChildSize: 1.0,
      expand: false,
      snap: true,
      snapSizes: const [0.50, 0.70, 1.0],
      builder: (context, scrollController) {
        return HelplineBottomSheet(scrollController: scrollController);
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// MAIN SHEET
// ─────────────────────────────────────────────────────────────────────────────
class HelplineBottomSheet extends StatelessWidget {
  final ScrollController scrollController;
  const HelplineBottomSheet({required this.scrollController, super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double sheetH = constraints.maxHeight;
        final double minH = screenHeight * 0.50;
        final double maxH = screenHeight * 1.00;
        final double progress =
            ((sheetH - minH) / (maxH - minH)).clamp(0.0, 1.0);
        final double cornerRadius = 28.0 * (1.0 - progress);

        return ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(cornerRadius),
            topRight: Radius.circular(cornerRadius),
          ),
          child: Stack(
            children: [
              // ── 1. Gradient background ──
              Positioned.fill(
                child: CustomPaint(painter: _HelplineGradientPainter()),
              ),

              // ── 2. Frosted glass blur ──
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      border: Border(
                        top: BorderSide(
                          color: Colors.white.withOpacity(0.15),
                          width: 1.2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // ── 3. Content ──
              Column(
                children: [
                  // Drag handle
                  AnimatedOpacity(
                    opacity: (1.0 - progress).clamp(0.0, 1.0),
                    duration: const Duration(milliseconds: 150),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 2),
                      child: Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.35),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Back button header
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Row(
                            children: [
                              const Icon(Icons.chevron_left,
                                  color: Colors.white, size: 24),
                              Text(
                                'Back',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Main call content
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        children: [
                          const SizedBox(height: 36),

                          // Avatar with ring
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white.withOpacity(0.15),
                                width: 2,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 68,
                              backgroundColor: Colors.white.withOpacity(0.12),
                              backgroundImage: const AssetImage(
                                  'assets/images/avatar.png'),
                            ),
                          ),
                          const SizedBox(height: 28),

                          // Name
                          Text(
                            'Helpline',
                            style: GoogleFonts.poppins(
                              fontSize: 28,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.3,
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Status
                          Text(
                            'Calling....',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: Colors.white70,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 56),

                          // Call Controls Capsule
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22, vertical: 14),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(44),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.22),
                                width: 1.5,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _ControlButton(icon: Icons.more_horiz),
                                const SizedBox(width: 14),
                                _ControlButton(icon: Icons.videocam_rounded),
                                const SizedBox(width: 14),
                                _ControlButton(icon: Icons.mic_off_rounded),
                                const SizedBox(width: 14),
                                _ControlButton(
                                  icon: Icons.call_end_rounded,
                                  isRed: true,
                                  onTap: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 60),
                        ],
                      ),
                    ),
                  ),

                  // Bottom Nav
                  RidenBottomNav(selectedIndex: 1),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// CONTROL BUTTON
// ─────────────────────────────────────────────────────────────────────────────
class _ControlButton extends StatelessWidget {
  final IconData icon;
  final bool isRed;
  final VoidCallback? onTap;

  const _ControlButton({required this.icon, this.isRed = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isRed
              ? const Color(0xFFE53935)
              : Colors.white.withOpacity(0.18),
          boxShadow: isRed
              ? [
                  BoxShadow(
                    color: const Color(0xFFE53935).withOpacity(0.45),
                    blurRadius: 16,
                    spreadRadius: 1,
                  )
                ]
              : [],
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: isRed ? 26 : 22,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// GRADIENT PAINTER
// ─────────────────────────────────────────────────────────────────────────────
class _HelplineGradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h),
        Paint()..color = const Color(0xFF1A1B2E));
    _blob(canvas,
        center: Offset(w * 0.15, h * 0.30),
        rx: w * 0.70,
        ry: h * 0.50,
        color: const Color(0xFF8B4A35),
        alpha: 170);
    _blob(canvas,
        center: Offset(w * 0.05, h * 0.55),
        rx: w * 0.50,
        ry: h * 0.35,
        color: const Color(0xFF6B3828),
        alpha: 130);
    _blob(canvas,
        center: Offset(w * 0.82, h * 0.68),
        rx: w * 0.70,
        ry: h * 0.52,
        color: const Color(0xFF2E6B72),
        alpha: 165);
    _blob(canvas,
        center: Offset(w * 0.90, h * 0.50),
        rx: w * 0.40,
        ry: h * 0.30,
        color: const Color(0xFF3D8A8F),
        alpha: 110);
    _blob(canvas,
        center: Offset(w * 0.50, h * 0.50),
        rx: w * 0.55,
        ry: h * 0.40,
        color: const Color(0xFF3A4555),
        alpha: 80);
  }

  void _blob(Canvas canvas,
      {required Offset center,
      required double rx,
      required double ry,
      required Color color,
      required int alpha}) {
    final solid = Color.fromARGB(alpha, color.red, color.green, color.blue);
    final clear = Color.fromARGB(0, color.red, color.green, color.blue);
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.scale(1.0, ry / rx);
    canvas.translate(-center.dx, -center.dy);
    canvas.drawCircle(
        center,
        rx,
        Paint()
          ..shader = RadialGradient(colors: [solid, clear]).createShader(
              Rect.fromCenter(
                  center: center, width: rx * 2, height: ry * 2)));
    canvas.restore();
  }

  @override
  bool shouldRepaint(_HelplineGradientPainter _) => false;
}
