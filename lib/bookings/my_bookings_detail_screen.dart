// ignore_for_file: unused_element_parameter

import 'dart:ui';
import 'package:Riden/bookings/booking_ride_detail.dart';
import 'package:Riden/bookings/report_issue_screen.dart';
import 'package:Riden/theme/app_colors.dart';
import 'package:Riden/widgets/riden_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// ─────────────────────────────────────────────────────────────────────────────
// HOW TO OPEN (from list or other screens):
//
//   showBookingDetailSheet(
//     context: context,
//     date: "Sun, 23 May 2025",
//     bookingId: "2345",
//   );
// ─────────────────────────────────────────────────────────────────────────────

void showBookingDetailSheet(
  BuildContext context, {
  String date = "Sun, 23 May 2025",
  String bookingId = "2345",
  Driver? driver,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black54,
    builder: (_) => _MyBookingsDetailSheetEntry(
      date: date,
      bookingId: bookingId,
      driver: driver,
    ),
  );
}

class _MyBookingsDetailSheetEntry extends StatelessWidget {
  final String date;
  final String bookingId;
  final Driver? driver;

  const _MyBookingsDetailSheetEntry({
    required this.date,
    required this.bookingId,
    this.driver,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.90,
      minChildSize: 0.50,
      maxChildSize: 0.98,
      expand: false, 
      snap: true,
      snapSizes: const [0.50, 0.90, 0.98],
      builder: (context, scrollController) {
        return MyBookingsDetailSheet(
          scrollController: scrollController,
          date: date,
          bookingId: bookingId,
          driver: driver,
        );
      },
    );
  }
}

class MyBookingsDetailScreen extends StatelessWidget {
  final String date;
  final String bookingId;
  final Driver? driver;

  const MyBookingsDetailScreen({
    super.key,
    this.date = "Sun, 23 May 2025",
    this.bookingId = "2345",
    required Map<dynamic, dynamic> booking,
    this.driver,
  });

  @override
  Widget build(BuildContext context) {
    // If opened as a screen, show it inside a scaffold with dark background
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          const RidenDarkBackground(),
          MyBookingsDetailSheet(
            scrollController: ScrollController(),
            date: date,
            bookingId: bookingId,
            driver: driver,
            isFromScreen: true,
          ),
        ],
      ),
    );
  }
}

class MyBookingsDetailSheet extends StatelessWidget {
  final ScrollController scrollController;
  final String date;
  final String bookingId;
  final Driver? driver;
  final bool isFromScreen;

  const MyBookingsDetailSheet({
    required this.scrollController,
    required this.date,
    required this.bookingId,
    this.driver,
    this.isFromScreen = false,
    super.key,
  });

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
        final double progress = isFromScreen ? 1.0 : ((sheetH - minH) / (maxH - minH)).clamp(0.0, 1.0);

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
                    if (!isFromScreen)
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

                    // ── Header: "< Back  Date" ──
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (isFromScreen) {
                                Get.back();
                              } else {
                                Navigator.pop(context);
                              }
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.chevron_left, color: Colors.white, size: 24),
                                const SizedBox(width: 4),
                                Text(
                                  'Back',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                date,
                                style: GoogleFonts.poppins(
                                  fontSize: 16, 
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 60), // Mirror space
                        ],
                      ),
                    ),

                    // ── Detailed Content ──
                    Expanded(
                      child: SingleChildScrollView(
                        controller: scrollController,
                        physics: const ClampingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [  
                            // Map Preview (reference UI style)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: Image.asset(
                                'assets/images/map1.png',
                                height: 170,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 18),

                            // Booking ID Badge
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.white, width: 1),
                              ),
                              child: Text(
                                "Booking ID : $bookingId",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Route Section (reference UI style)
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
                                        height: 48,
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
                                      _SimplePointRow(label: "Office", address: "2972 Westheimer Rd. Santa Ana, Illinois 85486", time: "04:30pm"),
                                      const SizedBox(height: 22),
                                      _SimplePointRow(label: "Coffee shop", address: "1901 Thornridge Cir. Shiloh, Hawaii 81063", time: "06:30pm"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),

                            // Stats: Duration & Distance
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Icon(Icons.access_time_filled_rounded, color: RidenColors.brandRed, size: 20),
                                      const SizedBox(width: 6),
                                      Flexible(
                                        child: Text(
                                          "Duration : 34 mins",
                                          style: GoogleFonts.poppins(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(Icons.location_on_rounded, color: RidenColors.brandRed, size: 20),
                                      const SizedBox(width: 6),
                                      Flexible(
                                        child: Text(
                                          "Distance : 5.2km",
                                          style: GoogleFonts.poppins(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Divider(color: Colors.white.withOpacity(0.15), height: 1),
                            const SizedBox(height: 20),

                            // Driver Info
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: Image.network(
                                    driver?.avatarUrl ?? 'https://i.pravatar.cc/150?img=33',
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        driver?.name ?? "Sergio",
                                        style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        driver != null ? "${driver!.carModel}, (${driver!.plate})" : "Black Suzuki Alto, (BKG-220)",
                                        style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),

                            // Rating & Review
                            Row(
                              children: [
                                Icon(Icons.rate_review_rounded, color: RidenColors.brandRed, size: 20),
                                const SizedBox(width: 8),
                                Text(
                                  "Rating & Review",
                                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                ...List.generate(4, (i) => Icon(Icons.star_rounded, color: RidenColors.brandRed, size: 26)),
                                Icon(Icons.star_outline_rounded, color: Colors.white38, size: 26),
                                const SizedBox(width: 10),
                                Text("(4.0)", style: GoogleFonts.poppins(color: Colors.white60, fontSize: 14)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
                              style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14, height: 1.4),
                            ),
                            const SizedBox(height: 24),

                            // Tip
                            Row(
                              children: [
                                Icon(Icons.wallet_rounded, color: RidenColors.brandRed, size: 20),
                                const SizedBox(width: 8),
                                Text(
                                  "Tip",
                                  style: GoogleFonts.poppins(color: RidenColors.brandRed, fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(text: "You gave ${driver?.name ?? 'Sergio'} ", style: GoogleFonts.poppins(color: Colors.white70, fontSize: 15)),
                                  TextSpan(text: "\$10 ", style: GoogleFonts.poppins(color: RidenColors.brandRed, fontSize: 16, fontWeight: FontWeight.w700)),
                                  TextSpan(text: "as a tip", style: GoogleFonts.poppins(color: Colors.white70, fontSize: 15)),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            Divider(color: Colors.white.withOpacity(0.15), height: 1),
                            const SizedBox(height: 24),

                            // Action Links
                            _ActionLink(
                              icon: Icons.receipt_long_rounded,
                              label: "Download Receipt",
                              onTap: () {},
                            ),
                            const SizedBox(height: 16),
                            _ActionLink(
                              icon: Icons.error_outline_rounded,
                              label: "Report an issue",
                              isRed: true,
                              onTap: () => Get.to(() => const ReportIssueScreen()),
                            ),

                            const SizedBox(height: 120),
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

class _SimplePointRow extends StatelessWidget {
  final String label, address, time;
  const _SimplePointRow({required this.label, required this.address, required this.time});
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: GoogleFonts.poppins(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
              const SizedBox(height: 2),
              Text(address, style: GoogleFonts.poppins(color: Colors.white60, fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
        Text(time, style: GoogleFonts.poppins(color: Colors.white60, fontSize: 12)),
      ],
    );
  }
}

class _ActionLink extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isRed;
  final VoidCallback onTap;
  const _ActionLink({required this.icon, required this.label, this.isRed = false, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: isRed ? RidenColors.brandRed : Colors.white70, size: 24),
          const SizedBox(width: 12),
          Text(label, style: GoogleFonts.poppins(color: isRed ? RidenColors.brandRed : Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white38..strokeWidth = 1.5..style = PaintingStyle.stroke;
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
