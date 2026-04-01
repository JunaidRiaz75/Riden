// ignore_for_file: use_super_parameters, deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Riden/widgets/riden_bottom_nav.dart';
import '../theme/app_colors.dart';

// ─────────────────────────────────────────────────────────────────────────────
// HOW TO OPEN:
//
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     backgroundColor: Colors.transparent,
//     barrierColor: Colors.black54,
//     builder: (_) => const CallBottomSheetEntry(),
//   );
// ─────────────────────────────────────────────────────────────────────────────

class CallBottomSheetEntry extends StatelessWidget {
  const CallBottomSheetEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.50,
      maxChildSize: 1.0,
      expand: false, 
      snap: true,
      snapSizes: const [0.50, 0.85, 1.0],
      builder: (context, scrollController) {
        return CallBottomSheet(scrollController: scrollController);
      },
    );
  }
}

class CallBottomSheet extends StatefulWidget {
  final ScrollController scrollController;
  const CallBottomSheet({required this.scrollController, super.key});

  @override
  State<CallBottomSheet> createState() => _CallBottomSheetState();
}

class _CallBottomSheetState extends State<CallBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double sheetH = constraints.maxHeight;
        final double sheetW = constraints.maxWidth;

        // progress: 0.0 = min collapsed, 1.0 = full screen
        final double minH = screenHeight * 0.50;
        final double maxH = screenHeight * 1.00;
        final double progress = ((sheetH - minH) / (maxH - minH)).clamp(0.0, 1.0);

        final double cornerRadius = 32.0 * (1.0 - progress);

        return ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(cornerRadius),
            topRight: Radius.circular(cornerRadius),
          ),
          child: SizedBox(
            width: sheetW,
            height: sheetH,
            child: Stack(
              children: [
                // 1. Gradient background
                Positioned.fill(
                  child: CustomPaint(painter: _SheetGradientPainter()),
                ),

                // 2. Frosted glass blur layer
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.04),
                        border: Border(
                          top: BorderSide(
                            color: Colors.white.withOpacity(0.15),
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // 3. Foreground content
                Column(
                  children: [
                    // Drag handle
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 8),
                      child: Center(
                        child: Container(
                          width: 45,
                          height: 4.5,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(2.5),
                          ),
                        ),
                      ),
                    ),

                    // Header: "< Back"
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.of(context).popUntil((route) => route.isFirst),
                            child: Row(
                              children: [
                                const Icon(Icons.chevron_left, color: Colors.white, size: 26),
                                Text(
                                  'Back',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: SingleChildScrollView(
                        controller: widget.scrollController,
                        child: Column(
                          children: [
                            const SizedBox(height: 40),
                            // Profile Avatar
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.1),
                                  width: 1,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 75,
                                backgroundImage: const AssetImage('assets/images/avatar.png'),
                                backgroundColor: Colors.white.withOpacity(0.1),
                              ),
                            ),
                            const SizedBox(height: 24),
                            // Name
                            Text(
                              "Sergio",
                              style: GoogleFonts.poppins(
                                fontSize: 32,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 6),
                            // Status
                            Text(
                              "Calling...",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.white70,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 60),

                            // Call Controls Capsule
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(40),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.25),
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 20,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _ControlIcon(icon: Icons.more_horiz),
                                  const SizedBox(width: 12),
                                  _ControlIcon(icon: Icons.videocam),
                                  const SizedBox(width: 12),
                                  _ControlIcon(icon: Icons.mic_off),
                                  const SizedBox(width: 12),
                                  _ControlIcon(
                                    icon: Icons.call_end_rounded,
                                    color: Colors.redAccent,
                                    isEnd: true,
                                    onTap: () => Navigator.of(context).popUntil((route) => route.isFirst),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 80),
                          ],
                        ),
                      ),
                    ),

                    // Bottom Navigation
                    RidenBottomNav(selectedIndex: 1, isFromSheet: true),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ControlIcon extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final bool isEnd;
  final VoidCallback? onTap;

  const _ControlIcon({
    required this.icon,
    this.color,
    this.isEnd = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color ?? Colors.white.withOpacity(0.2),
          boxShadow: isEnd ? [
            BoxShadow(
              color: Colors.redAccent.withOpacity(0.4),
              blurRadius: 15,
              spreadRadius: 1,
            )
          ] : [],
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: isEnd ? 26 : 22,
        ),
      ),
    );
  }
}

class _SheetGradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    canvas.drawRect(
      Rect.fromLTWH(0, 0, w, h),
      Paint()..color = const Color(0xFF1A1B2E),
    );

    _radialBlob(
      canvas,
      center: Offset(w * 0.15, h * 0.30),
      rx: w * 0.75,
      ry: h * 0.55,
      color: const Color(0xFF8B4A35),
      alpha: 160,
    );

    _radialBlob(
      canvas,
      center: Offset(w * 0.85, h * 0.70),
      rx: w * 0.75,
      ry: h * 0.55,
      color: const Color(0xFF2E6B72),
      alpha: 160,
    );
  }

  void _radialBlob(Canvas canvas, {required Offset center, required double rx, required double ry, required Color color, required int alpha}) {
    final solid = Color.fromARGB(alpha, color.red, color.green, color.blue);
    final clear = Color.fromARGB(0, color.red, color.green, color.blue);
    final paint = Paint()
      ..shader = RadialGradient(colors: [solid, clear]).createShader(
        Rect.fromCenter(center: center, width: rx * 2, height: ry * 2),
      );
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.scale(1.0, ry / rx);
    canvas.translate(-center.dx, -center.dy);
    canvas.drawCircle(center, rx, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_SheetGradientPainter _) => false;
}
