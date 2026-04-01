// booking_loading_bottom_sheet.dart
// ignore_for_file: unused_element_parameter, use_super_parameters, deprecated_member_use

import 'dart:async';
import 'dart:ui';

import 'package:Riden/bookings/booking_ride_detail.dart';
import 'package:Riden/theme/app_colors.dart';
import 'package:Riden/widgets/riden_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ENTRY
// ─────────────────────────────────────────────────────────────────────────────
class BookingLoadingBottomSheetEntry extends StatelessWidget {
  const BookingLoadingBottomSheetEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.50,
      maxChildSize: 1.0,
      expand: false,
      snap: true,
      snapSizes: const [0.50, 0.75, 1.0],
      builder: (context, scrollController) {
        return BookingLoadingBottomSheet(scrollController: scrollController);
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// MAIN SHEET
// ─────────────────────────────────────────────────────────────────────────────
class BookingLoadingBottomSheet extends StatefulWidget {
  final ScrollController scrollController;

  const BookingLoadingBottomSheet({required this.scrollController, super.key});

  @override
  State<BookingLoadingBottomSheet> createState() =>
      _BookingLoadingBottomSheetState();
}

class _BookingLoadingBottomSheetState extends State<BookingLoadingBottomSheet> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pop(context);
        _openDriverSelectionSheet();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _openDriverSelectionSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 1.0,
        expand: false,
        snap: true,
        snapSizes: const [0.5, 0.85, 1.0],
        builder: (ctx, sc) => DriverSelectionBottomSheet(scrollController: sc),
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

        final double minH = screenHeight * 0.50;
        final double maxH = screenHeight * 1.00;
        final double progress = ((sheetH - minH) / (maxH - minH)).clamp(
          0.0,
          1.0,
        );

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
                // ── 1. Gradient background ──
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

                    // Scrollable content
                    Expanded(
                      child: ListView(
                        controller: widget.scrollController,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 18,
                        ),
                        children: [
                          // RIDEN wordmark
                          const SizedBox(height: 15),

                          // Spinner
                          Center(
                            child: SizedBox(
                              width: 72,
                              height: 72,
                              child: CircularProgressIndicator(
                                strokeWidth: 7,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  Color(0xFFE53935),
                                ),
                                backgroundColor: Colors.white.withOpacity(0.15),
                              ),
                            ),
                          ),
                          const SizedBox(height: 28),

                          // Heading
                          Center(
                            child: Text(
                              'We are booking a ride for you',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                height: 1.4,
                              ),
                            ),
                          ),
                          const SizedBox(height: 28),

                          // ── Destination card ──
                          // White 0.58 opacity, same as bottom nav
                          _WhiteGlassCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Destination',
                                  style: GoogleFonts.poppins(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF1A1B2E),
                                  ),
                                ),
                                const SizedBox(height: 18),
                                _LocationRow(
                                  isFirst: true,
                                  label: 'Office',
                                  address:
                                      '2972 Westheimer Rd. Santa Ana, Illinois 85486',
                                ),
                                _LocationRow(
                                  isFirst: false,
                                  label: 'Coffee shop',
                                  address:
                                      '1901 Thornridge Cir. Shiloh, Hawaii 81063',
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),

                          // ── Ride details card ──
                          _WhiteGlassCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ride Details',
                                  style: GoogleFonts.poppins(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF1A1B2E),
                                  ),
                                ),
                                const SizedBox(height: 18),
                                _DetailRow('Total Distance', '234km'),
                                const SizedBox(height: 16),
                                _DetailRowIcon(
                                  'Sedan',
                                  icon: Image.asset(
                                    'assets/images/standard_car.png',
                                    width: 58,
                                    height: 24,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                _DetailRow('Payment Method', 'Wallet'),
                                const SizedBox(height: 16),
                                _DetailRow('Estimated Fare', '\$400.00'),
                                const SizedBox(height: 16),
                                _DetailRow('Discount', '-\$40.00'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),

                    // Bottom nav (standardized)
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
// WHITE GLASS CARD  — matches bottom nav: white 0.58, border white 0.70
// ─────────────────────────────────────────────────────────────────────────────
class _WhiteGlassCard extends StatelessWidget {
  final Widget child;
  const _WhiteGlassCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.58),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.70), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: child,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// LOCATION ROW
// ─────────────────────────────────────────────────────────────────────────────
class _LocationRow extends StatelessWidget {
  final bool isFirst;
  final String label;
  final String address;

  const _LocationRow({
    required this.isFirst,
    required this.label,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: isFirst ? 0 : 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              if (isFirst)
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF1A1B2E),
                  ),
                )
              else
                Container(
                  width: 16,
                  height: 16,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFE53935),
                  ),
                  child: const Center(
                    child: Icon(Icons.navigation, size: 8, color: Colors.white),
                  ),
                ),
              if (isFirst)
                Container(
                  width: 2,
                  height: 40,
                  color: const Color(0xFF1A1B2E).withOpacity(0.25),
                  margin: const EdgeInsets.symmetric(vertical: 5),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1A1B2E),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  address,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF1A1B2E).withOpacity(0.60),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// DETAIL ROW helpers
// ─────────────────────────────────────────────────────────────────────────────
class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _DetailRow(this.label, this.value, {this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1A1B2E),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: valueColor ?? const Color(0xFF1A1B2E),
          ),
        ),
      ],
    );
  }
}

class _DetailRowIcon extends StatelessWidget {
  final String label;
  final Widget icon;

  const _DetailRowIcon(this.label, {required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF1A1B2E),
          ),
        ),
        Align(alignment: Alignment.centerRight, child: icon),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SHARED GRADIENT PAINTER  (imported from ride_bottom_sheet or duplicated)
// ─────────────────────────────────────────────────────────────────────────────
class SheetGradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    canvas.drawRect(
      Rect.fromLTWH(0, 0, w, h),
      Paint()..color = const Color(0xFF1A1B2E),
    );

    _blob(
      canvas,
      center: Offset(w * 0.15, h * 0.30),
      rx: w * 0.70,
      ry: h * 0.50,
      color: const Color(0xFF8B4A35),
      alpha: 170,
    );
    _blob(
      canvas,
      center: Offset(w * 0.05, h * 0.55),
      rx: w * 0.50,
      ry: h * 0.35,
      color: const Color(0xFF6B3828),
      alpha: 130,
    );
    _blob(
      canvas,
      center: Offset(w * 0.82, h * 0.68),
      rx: w * 0.70,
      ry: h * 0.52,
      color: const Color(0xFF2E6B72),
      alpha: 165,
    );
    _blob(
      canvas,
      center: Offset(w * 0.90, h * 0.50),
      rx: w * 0.40,
      ry: h * 0.30,
      color: const Color(0xFF3D8A8F),
      alpha: 110,
    );
    _blob(
      canvas,
      center: Offset(w * 0.50, h * 0.50),
      rx: w * 0.55,
      ry: h * 0.40,
      color: const Color(0xFF3A4555),
      alpha: 80,
    );
  }

  void _blob(
    Canvas canvas, {
    required Offset center,
    required double rx,
    required double ry,
    required Color color,
    required int alpha,
  }) {
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
