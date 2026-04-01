// ignore_for_file: unused_element_parameter

import 'dart:ui';
import 'package:Riden/theme/app_colors.dart';
import 'package:Riden/widgets/riden_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'my_bookings_detail_screen.dart';

// ─────────────────────────────────────────────────────────────────────────────
// HOW TO OPEN (from profile or other screens):
//
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     backgroundColor: Colors.transparent,
//     barrierColor: Colors.black54,
//     builder: (_) => const MyBookingsBottomSheetEntry(),
//   );
// ─────────────────────────────────────────────────────────────────────────────

class MyBookingsBottomSheetEntry extends StatelessWidget {
  const MyBookingsBottomSheetEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.45,
      maxChildSize: 0.96,
      expand: false, 
      snap: true,
      snapSizes: const [0.45, 0.85, 0.96],
      builder: (context, scrollController) {
        return MyBookingsBottomSheet(scrollController: scrollController);
      },
    );
  }
}

class MyBookingsBottomSheet extends StatelessWidget {
  final ScrollController scrollController;
  const MyBookingsBottomSheet({required this.scrollController, super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double sheetH = constraints.maxHeight;
        final double sheetW = constraints.maxWidth;

        // progress: 0.0 = min collapsed, 1.0 = full screen
        final double minH = screenHeight * 0.45;
        final double maxH = screenHeight * 1.00;
        final double progress = ((sheetH - minH) / (maxH - minH)).clamp(0.0, 1.0);

        // Corners flatten as sheet goes full screen
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
                // ── 1. Gradient background ──
                Positioned.fill(
                  child: CustomPaint(painter: _SheetGradientPainter()),
                ),

                // ── 2. Frosted glass blur layer ──
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
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

                // ── 3. Foreground content ──
                Column(
                  children: [
                    // Drag handle
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 2),
                      child: Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),

                    // ── Header: "< Back  My Bookings" ──
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Row(
                              children: [
                                const Icon(Icons.chevron_left, color: Colors.white, size: 24),
                                const SizedBox(width: 4),
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
                          Expanded(
                            child: Center(
                              child: Text(
                                "My Bookings",
                                style: GoogleFonts.poppins(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 60), // Mirror back button space
                        ],
                      ),
                    ),

                    // ── Bookings List ──
                    Expanded(
                      child: SingleChildScrollView(
                        controller: scrollController,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            _BookingSection(
                              onTap: () {
                                showBookingDetailSheet(context);
                              },
                              title: "Ongoing Bookings",
                              bookings: [
                                BookingInfo(
                                  date: "25 May, 2025",
                                  price: "\$45.00",
                                  pickLabel: "Office",
                                  pickAddress: "2972 Westheimer Rd. Santa Ana, Illinois 85486",
                                  pickTime: "04:30pm",
                                  dropLabel: "Coffee shop",
                                  dropAddress: "1901 Thornridge Cir. Shiloh, Hawaii 81063",
                                  dropTime: "06:30pm",
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            _BookingSection(
                              onTap: () {
                                showBookingDetailSheet(context);
                              },
                              title: "Previous", 
                              bookings: [
                                BookingInfo(
                                  date: "25 May, 2025",
                                  price: "\$45.00",
                                  pickLabel: "Office",
                                  pickAddress: "2972 Westheimer Rd. Santa Ana, Illinois 85486",
                                  pickTime: "04:30pm",
                                  dropLabel: "Coffee shop",
                                  dropAddress: "1901 Thornridge Cir. Shiloh, Hawaii 81063",
                                  dropTime: "06:30pm",
                                ),
                              ],
                            ),
                            const SizedBox(height: 100),
                          ],
                        ),
                      ),
                    ),

                    // ── Navigation ──
                    RidenBottomNav(selectedIndex: 0, isFromSheet: true),
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

class _BookingSection extends StatelessWidget {
  final String title;
  final List<BookingInfo> bookings;
  final VoidCallback? onTap;
  const _BookingSection({
    required this.title,
    required this.bookings,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        ...bookings.asMap().entries.map(
          (entry) {
            int idx = entry.key;
            BookingInfo booking = entry.value;
            return Column(
              children: [
                _BookingEntry(
                  info: booking,
                  onTap: onTap,
                ),
                if (idx < bookings.length - 1)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Divider(color: Colors.white.withOpacity(0.15), height: 1),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _BookingEntry extends StatelessWidget {
  final BookingInfo info;
  final VoidCallback? onTap;
  const _BookingEntry({
    required this.info,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent, // Ensures tap works everywhere
        child: Column(
          children: [
            // Top row: Date and Price
            Row(
              children: [
                Text(
                  info.date,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                Text(
                  info.price,
                  style: GoogleFonts.poppins(
                    color: RidenColors.brandRed,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Route section
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon Chain column
                Padding(
                  padding: const EdgeInsets.only(top: 6, right: 14),
                  child: Column(
                    children: [
                      const Icon(Icons.circle, color: Colors.white, size: 12),
                      Container(
                        width: 1.5,
                        height: 38,
                        margin: const EdgeInsets.symmetric(vertical: 3),
                        child: CustomPaint(painter: _DashedLinePainter()),
                      ),
                      const Icon(Icons.navigation, color: RidenColors.brandRed, size: 22),
                    ],
                  ),
                ),
                // Text columns
                Expanded(
                  child: Column(
                    children: [
                      // Pickup Row
                      _PointRow(
                        label: info.pickLabel,
                        address: info.pickAddress,
                        time: info.pickTime,
                        showChevron: true,
                      ),
                      const SizedBox(height: 18),
                      // Dropoff Row
                      _PointRow(
                        label: info.dropLabel,
                        address: info.dropAddress,
                        time: info.dropTime,
                        showChevron: false,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Bottom Divider
            const SizedBox(height: 16),
            Divider(color: Colors.white.withOpacity(0.12), height: 1),
          ],
        ),
      ),
    );
  }
}

class _PointRow extends StatelessWidget {
  final String label, address, time;
  final bool showChevron;
  const _PointRow({
    required this.label,
    required this.address,
    required this.time,
    required this.showChevron,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                address,
                style: GoogleFonts.poppins(
                  color: Colors.white.withOpacity(0.55),
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (showChevron)
              const Icon(Icons.chevron_right_rounded, color: Colors.white70, size: 24),
            if (!showChevron) const SizedBox(height: 24),
            const SizedBox(height: 4),
            Text(
              time,
              style: GoogleFonts.poppins(
                color: Colors.white.withOpacity(0.5),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white38
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    double dashHeight = 4, dashSpace = 3, startY = 0;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _SheetGradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), Paint()..color = const Color(0xFF1A1B2E));
    _radialBlob(canvas, center: Offset(w * 0.15, h * 0.3), rx: w * 0.8, ry: h * 0.6, color: const Color(0xFF8B4A35), alpha: 170);
    _radialBlob(canvas, center: Offset(w * 0.85, h * 0.75), rx: w * 0.8, ry: h * 0.6, color: const Color(0xFF2E6B72), alpha: 170);
  }
  void _radialBlob(Canvas canvas, {required Offset center, required double rx, required double ry, required Color color, required int alpha}) {
    final solid = Color.fromARGB(alpha, color.red, color.green, color.blue);
    final clear = Color.fromARGB(0, color.red, color.green, color.blue);
    final paint = Paint()..shader = RadialGradient(colors: [solid, clear]).createShader(Rect.fromCenter(center: center, width: rx * 2, height: ry * 2));
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

class BookingInfo {
  final String date, price, pickLabel, pickAddress, pickTime, dropLabel, dropAddress, dropTime;
  BookingInfo({
    required this.date,
    required this.price,
    required this.pickLabel,
    required this.pickAddress,
    required this.pickTime,
    required this.dropLabel,
    required this.dropAddress,
    required this.dropTime,
  });
}
