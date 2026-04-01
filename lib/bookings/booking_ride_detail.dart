// driver_selection_bottom_sheet.dart
// ignore_for_file: use_super_parameters, deprecated_member_use

import 'dart:ui';

import 'package:Riden/bookings/active_booking_screen.dart';
import 'package:Riden/bookings/my_bookings_detail_screen.dart';
import 'package:Riden/theme/app_colors.dart';
import 'package:Riden/widgets/riden_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ENTRY
// ─────────────────────────────────────────────────────────────────────────────
class DriverSelectionBottomSheetEntry extends StatelessWidget {
  const DriverSelectionBottomSheetEntry({super.key});

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
        return DriverSelectionBottomSheet(scrollController: scrollController);
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// MAIN SHEET
// ─────────────────────────────────────────────────────────────────────────────
class DriverSelectionBottomSheet extends StatelessWidget {
  final ScrollController scrollController;

  const DriverSelectionBottomSheet({required this.scrollController, super.key});

  @override
  Widget build(BuildContext context) {
    final List<Driver> drivers = [
      Driver(
        name: 'Sergio',
        avatarUrl: 'https://i.pravatar.cc/150?img=33',
        distance: '5mins away',
        ridesCount: 43,
        reviews: 31,
        carModel: 'Black Suzuki Alto',
        carImageUrl: 'assets/images/black_alto.png',
        plate: 'BKG-220',
        distanceKm: '0.2 km',
        time: '2 min',
        fare: '\$25.00',
      ),
      Driver(
        name: 'Ahmed',
        avatarUrl: 'https://i.pravatar.cc/150?img=57',
        distance: '5mins away',
        ridesCount: 43,
        reviews: 31,
        carModel: 'White Mercedes',
        carImageUrl: 'assets/images/white_mercedes.png',
        plate: 'BKG-134',
        distanceKm: '0.2 km',
        time: '2 min',
        fare: '\$35.00',
      ),
    ];

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

                    // Section title
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
                      child: Row(
                        children: [
                          Text(
                            'Available Drivers',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 0.3,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE53935).withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(
                                  0xFFE53935,
                                ).withOpacity(0.40),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              '${drivers.length} nearby',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFE53935),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Driver list
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
                        itemCount: drivers.length,
                        itemBuilder: (context, index) {
                          final driver = drivers[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: _DriverCard(
                              driver: driver,
                              onAccept: () {
                                Navigator.pop(context); // Close selection sheet
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  barrierColor: Colors.black54,
                                  builder: (_) => ActiveBookingBottomSheetEntry(
                                    driver: driver,
                                  ),
                                );
                              },
                            ),
                          );
                        },
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
// DRIVER CARD  — white 0.58, border white 0.70 (matches bottom nav exactly)
// ─────────────────────────────────────────────────────────────────────────────
class _DriverCard extends StatelessWidget {
  final Driver driver;
  final VoidCallback onAccept;

  const _DriverCard({required this.driver, required this.onAccept});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // Exact same color + opacity as bottom nav
        color: Colors.white.withOpacity(0.58),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.70), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // ── Driver info row ──
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Avatar
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.grey.shade300,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.70),
                      width: 1.5,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(13),
                    child: Image.network(
                      driver.avatarUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) =>
                          const Icon(Icons.person, color: Color(0xFF1A1B2E)),
                    ),
                  ),
                ),
                const SizedBox(width: 14),

                // Name / distance / rides
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        driver.name,
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1A1B2E),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 13,
                            color: Color(0xFFE53935),
                          ),
                          const SizedBox(width: 3),
                          Text(
                            driver.distance,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: const Color(0xFF1A1B2E).withOpacity(0.65),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '${driver.ridesCount} Rides  •  ${driver.reviews} reviews',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF1A1B2E).withOpacity(0.55),
                        ),
                      ),
                    ],
                  ),
                ),

                // Accept button
                ElevatedButton(
                  onPressed: onAccept,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE53935),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: const Text('Accept Ride'),
                ),
              ],
            ),
          ),

          // ── Divider ──
          Divider(color: Colors.black.withOpacity(0.10), height: 1),

          // ── Stats row ──
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatCell('DISTANCE', driver.distanceKm),
                _VerticalDivider(),
                _StatCell('TIME', driver.time),
                _VerticalDivider(),
                _StatCell('FARE', driver.fare),
              ],
            ),
          ),

          // ── Divider ──
          Divider(color: Colors.black.withOpacity(0.10), height: 1),

          // ── Car details ──
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF1A1B2E),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '${driver.carModel}  •  ${driver.plate}',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF1A1B2E),
                    ),
                  ),
                ),
                Image.asset(
                  driver.carImageUrl,
                  width: 50,
                  height: 30,
                  fit: BoxFit.contain,
                  errorBuilder: (_, _, _) => const Icon(
                    Icons.directions_car_outlined,
                    color: Color(0xFF1A1B2E),
                    size: 20,
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

class _StatCell extends StatelessWidget {
  final String label;
  final String value;
  const _StatCell(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1A1B2E).withOpacity(0.55),
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1A1B2E),
          ),
        ),
      ],
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 36,
      color: Colors.black.withOpacity(0.10),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SHARED GRADIENT PAINTER
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

// ─────────────────────────────────────────────────────────────────────────────
// DRIVER MODEL
// ─────────────────────────────────────────────────────────────────────────────
class Driver {
  final String name;
  final String avatarUrl;
  final String distance;
  final int ridesCount;
  final int reviews;
  final String carModel;
  final String carImageUrl;
  final String plate;
  final String distanceKm;
  final String time;
  final String fare;

  Driver({
    required this.name,
    required this.avatarUrl,
    required this.distance,
    required this.ridesCount,
    required this.reviews,
    required this.carModel,
    required this.carImageUrl,
    required this.plate,
    required this.distanceKm,
    required this.time,
    required this.fare,
  });
}
