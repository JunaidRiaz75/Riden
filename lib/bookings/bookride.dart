// ride_bottom_sheet.dart
// ignore_for_file: use_super_parameters, deprecated_member_use

import 'dart:ui';

import 'package:Riden/bookings/ride_booking_screen.dart';
import 'package:Riden/theme/app_colors.dart';
import 'package:Riden/widgets/riden_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ENTRY — used by showModalBottomSheet
//
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     backgroundColor: Colors.transparent,
//     barrierColor: Colors.black54,
//     builder: (_) => const RideBottomSheetEntry(),
//   );
// ─────────────────────────────────────────────────────────────────────────────
class RideBottomSheetEntry extends StatelessWidget {
  const RideBottomSheetEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      minChildSize: 0.40,
      maxChildSize: 1.0,
      expand: false,
      snap: true,
      snapSizes: const [0.40, 0.70, 1.0],
      builder: (context, scrollController) {
        return RideBottomSheet(scrollController: scrollController);
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// MAIN SHEET
// ─────────────────────────────────────────────────────────────────────────────
class RideBottomSheet extends StatefulWidget {
  final ScrollController scrollController;

  const RideBottomSheet({required this.scrollController, super.key});

  @override
  State<RideBottomSheet> createState() => _RideBottomSheetState();
}

class _RideBottomSheetState extends State<RideBottomSheet> {
  final List<Map<String, String>> savedLocations = [
    {'name': 'Office', 'address': '2972 Westheimer Rd, Santa Ana, Illinois 85486'},
    {'name': 'Coffee shop', 'address': '1901 Thorndige Cir, Shiloh, Hawaii 81063'},
    {'name': 'Shopping center', 'address': '4140 Parker Rd, Allentown, New Mexico 31134'},
    {'name': 'Office', 'address': '2972 Westheimer Rd, Santa Ana, Illinois 85486'},
    {'name': 'Coffee shop', 'address': '1901 Thorndige Cir, Shiloh, Hawaii 81063'},
    {'name': 'Shopping center', 'address': '4140 Parker Rd, Allentown, New Mexico 31134'},
    {'name': 'Office', 'address': '2972 Westheimer Rd, Santa Ana, Illinois 85486'},
    {'name': 'Coffee shop', 'address': '1901 Thorndige Cir, Shiloh, Hawaii 81063'},
    {'name': 'Shopping center', 'address': '4140 Parker Rd, Allentown, New Mexico 31134'},
  ];

  void _openCarSelectionSheet() {
    Navigator.pop(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        snap: true,
        snapSizes: const [0.5, 0.85, 0.95],
        builder: (ctx, sc) => CarSelectionScreen(scrollController: sc),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double sheetH = constraints.maxHeight;
        final double sheetW = constraints.maxWidth;

        final double minH = screenHeight * 0.40;
        final double maxH = screenHeight * 1.00;
        final double progress =
            ((sheetH - minH) / (maxH - minH)).clamp(0.0, 1.0);

        final double cornerRadius = 28.0 * (1.0 - progress);

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
                // ── 1. Gradient background (identical to chat sheet) ──
                Positioned.fill(
                  child: CustomPaint(painter: SheetGradientPainter()),
                ),

                // ── 2. Frosted glass blur ──
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.06),
                        border: Border(
                          top: BorderSide(
                            color: Colors.white.withOpacity(0.18),
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

                    Expanded(
                      child: SingleChildScrollView(
                        controller: widget.scrollController,
                        physics: const ClampingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ── Pickup / Destination card ──
                              // Uses the same white-glass style as bottom nav
                              GestureDetector(
                                onTap: _openCarSelectionSheet,
                                child: Container(
                                  decoration: BoxDecoration(
                                    // Matches bottom nav: white 0.58 opacity
                                    color: Colors.white.withOpacity(0.58),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.70),
                                      width: 1.2,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.08),
                                        blurRadius: 12,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    children: [
                                      // Pickup
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/pickup.png',
                                            width: 30,
                                            height: 30,
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Pickup',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w500,
                                                    color: const Color(
                                                        0xFF1A1B2E),
                                                    letterSpacing: 0.5,
                                                  ),
                                                ),
                                                const SizedBox(height: 3),
                                                Text(
                                                  '2972 Westheimer Rd, Santa Ana, Illinois 85486',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                    color: const Color(
                                                        0xFF1A1B2E),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      Divider(
                                        color: Colors.black.withOpacity(0.10),
                                        height: 1,
                                      ),
                                      const SizedBox(height: 12),
                                      // Destination
                                      Row(
                                        children: [
                                             Image.asset(
                                                'assets/images/destination.png',
                                                width: 30,
                                                height: 30,
                                              ),
                                           
                                         
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Destination',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w500,
                                                    color: const Color(
                                                        0xFF1A1B2E),
                                                    letterSpacing: 0.5,
                                                  ),
                                                ),
                                                const SizedBox(height: 3),
                                                Text(
                                                  'Where to go?',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 7),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF1A1B2E)
                                                  .withOpacity(0.80),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: const Text(
                                              'MAP',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(height: 22),

                              // ── Saved locations ──
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: savedLocations.length,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(height: 0),
                                itemBuilder: (context, index) {
                                  final loc = savedLocations[index];
                                  return GestureDetector(
                                    onTap: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content:
                                              Text('Selected: ${loc['name']}'),
                                          backgroundColor:
                                              const Color(0xFFE53935),
                                          duration: const Duration(
                                              milliseconds: 800),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 22,
                                            height: 22,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xFFE53935),
                                            ),
                                            child: const Center(
                                              child: Icon(Icons.location_on,
                                                  color: Colors.white,
                                                  size: 12),
                                            ),
                                          ),
                                          const SizedBox(width: 14),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  loc['name']!,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                const SizedBox(height: 2),
                                                Text(
                                                  loc['address']!,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    color: Colors.white60,
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                Divider(
                                                  color: Colors.white
                                                      .withOpacity(0.15),
                                                  height: 1,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),

                              const SizedBox(height: 30),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Bottom nav
                    RidenBottomNav(selectedIndex: 0),
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

// ─────────────────────────────────────────────────────────────────────────────
// SHARED GRADIENT PAINTER  (same across all 3 sheets)
// ─────────────────────────────────────────────────────────────────────────────
class SheetGradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Base dark navy
    canvas.drawRect(
      Rect.fromLTWH(0, 0, w, h),
      Paint()..color = const Color(0xFF1A1B2E),
    );

    _blob(canvas,
        center: Offset(w * 0.15, h * 0.30),
        rx: w * 0.70, ry: h * 0.50,
        color: const Color(0xFF8B4A35), alpha: 170);

    _blob(canvas,
        center: Offset(w * 0.05, h * 0.55),
        rx: w * 0.50, ry: h * 0.35,
        color: const Color(0xFF6B3828), alpha: 130);

    _blob(canvas,
        center: Offset(w * 0.82, h * 0.68),
        rx: w * 0.70, ry: h * 0.52,
        color: const Color(0xFF2E6B72), alpha: 165);

    _blob(canvas,
        center: Offset(w * 0.90, h * 0.50),
        rx: w * 0.40, ry: h * 0.30,
        color: const Color(0xFF3D8A8F), alpha: 110);

    _blob(canvas,
        center: Offset(w * 0.50, h * 0.50),
        rx: w * 0.55, ry: h * 0.40,
        color: const Color(0xFF3A4555), alpha: 80);
  }

  void _blob(Canvas canvas,
      {required Offset center,
      required double rx,
      required double ry,
      required Color color,
      required int alpha}) {
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
  bool shouldRepaint(SheetGradientPainter _) => false;
}
