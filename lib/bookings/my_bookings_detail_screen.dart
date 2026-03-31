// my_bookings_detail_screen.dart
import 'package:Riden/bookings/booking_ride_detail.dart';
import 'package:Riden/bookings/report_issue_screen.dart';
import 'package:Riden/theme/app_colors.dart';
import 'package:Riden/widgets/riden_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// ─────────────────────────────────────────────────────────────
// ✅ Call this to open as a bottom sheet — used by driver selection
// ─────────────────────────────────────────────────────────────
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
    builder: (_) => DraggableScrollableSheet(
      initialChildSize: 0.92,
      minChildSize: 0.5,
      maxChildSize: 0.97,
      snap: true,
      snapSizes: const [0.5, 0.92, 0.97],
      builder: (_, scrollController) => _MyBookingsDetailSheet(
        scrollController: scrollController,
        date: date,
        bookingId: bookingId,
        driver: driver,
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// ✅ Screen wrapper — kept so any Get.to() calls still work
// ─────────────────────────────────────────────────────────────
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
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const RidenDarkBackground(),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        date,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                 Expanded(
                  child: _DetailContent(
                    scrollController: ScrollController(),
                    date: date,
                    bookingId: bookingId,
                    driver: driver,
                  ),
                ),
                // Standardized Bottom Nav
                RidenBottomNav(selectedIndex: 0, isFromSheet: false),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// ✅ The actual bottom sheet widget (private — use showBookingDetailSheet)
// ─────────────────────────────────────────────────────────────
class _MyBookingsDetailSheet extends StatelessWidget {
  final ScrollController scrollController;
  final String date;
  final String bookingId;
  final Driver? driver;

  const _MyBookingsDetailSheet({
    required this.scrollController,
    required this.date,
    required this.bookingId,
    this.driver,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(28),
        topRight: Radius.circular(28),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          const RidenDarkBackground(),
          Column(
            children: [
              // Drag handle
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 4),
                child: Center(
                  child: Container(
                    width: 45,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),
                ),
              ),
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 6, 20, 4),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      date,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              // Scrollable body
               Expanded(
                child: _DetailContent(
                  scrollController: scrollController,
                  date: date,
                  bookingId: bookingId,
                  driver: driver,
                ),
              ),
              // Standardized Bottom Nav
              RidenBottomNav(selectedIndex: 0),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// ✅ Shared scrollable content (now with driver data)
// ─────────────────────────────────────────────────────────────
class _DetailContent extends StatelessWidget {
  final ScrollController scrollController;
  final String date;
  final String bookingId;
  final Driver? driver;

  const _DetailContent({
    required this.scrollController,
    required this.date,
    required this.bookingId,
    this.driver,
  });

  @override
  Widget build(BuildContext context) {
    // Use driver data if provided, else fallback to hardcoded values
    final driverName = driver?.name ?? 'Sergio';
    final driverCar = driver != null
        ? '${driver!.carModel}, (${driver!.plate})'
        : 'Black Suzuki Alto, (BKG-220)';

    return SingleChildScrollView(
      controller: scrollController,
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Map preview
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.asset(
              'assets/images/map1.png',
              height: 130,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 13),

          // Booking ID
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.14),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              "Booking id: $bookingId",
              style: GoogleFonts.poppins(
                color: Colors.deepOrangeAccent,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Route stops
          GlassyBookingStop(
            icon: Icons.location_on,
            title: "Office",
            details: "2972 Weatherliner Rd. Santa Ana, Illinois 95846",
            time: "04:30pm",
          ),
          GlassyBookingStop(
            icon: Icons.pin_drop_outlined,
            title: "Coffee shop",
            details: "1001 Thornridge Cir. Shiloh, Hawaii 81063",
            time: "05:03pm",
          ),
          const SizedBox(height: 7),

          // Duration & Distance
          Row(
            children: [
              const Icon(Icons.timer, color: Colors.red, size: 21),
              const SizedBox(width: 4),
              Text(
                "Duration: 34 mins",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 13.2,
                ),
              ),
              const SizedBox(width: 20),
              const Icon(Icons.square_outlined, color: Colors.red, size: 18),
              const SizedBox(width: 4),
              Text(
                "Distance: 5.2km",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 13.2,
                ),
              ),
            ],
          ),
          const Divider(height: 24, thickness: 1, color: Colors.white24),

          // Driver
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  driver?.avatarUrl ?? 'https://i.pravatar.cc/150?img=33',
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white54,
                      size: 36,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 13),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    driverName,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.3,
                    ),
                  ),
                  Text(
                    driverCar,
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Rating & Review
          Text(
            "Rating & Review",
            style: GoogleFonts.poppins(
              color: Colors.red,
              fontWeight: FontWeight.w600,
              fontSize: 14.9,
            ),
          ),
          Row(
            children: [
              ...List.generate(
                5,
                (i) => Icon(
                  i < 4 ? Icons.star : Icons.star_border,
                  color: Colors.red,
                  size: 21,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                "(4.0)",
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: 13.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 13.2,
            ),
          ),
          const SizedBox(height: 16),

          // Tip
          Row(
            children: [
              const Icon(Icons.lightbulb, color: Colors.amber, size: 20),
              const SizedBox(width: 5),
              Text(
                "Tip",
                style: GoogleFonts.poppins(
                  color: Colors.red,
                  fontWeight: FontWeight.w700,
                  fontSize: 14.4,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "You gave $driverName ",
                  style: GoogleFonts.poppins(
                    color: Colors.white70,
                    fontSize: 13.2,
                  ),
                ),
                TextSpan(
                  text: "\$10",
                  style: GoogleFonts.poppins(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                    fontSize: 13.8,
                  ),
                ),
                TextSpan(
                  text: " as a tip",
                  style: GoogleFonts.poppins(
                    color: Colors.white70,
                    fontSize: 13.2,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 28, thickness: 1, color: Colors.white24),

          // Action buttons
          GlassyActionButton(
            icon: Icons.download_for_offline,
            label: "Download Receipt",
            glassColor: Colors.white.withOpacity(0.13),
            textColor: Colors.white,
            onTap: () {},
          ),
          const SizedBox(height: 16),
          GlassyActionButton(
            icon: Icons.report_outlined,
            label: "Report an issue",
            glassColor: Colors.red,
            textColor: Colors.white,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ReportIssueScreen()),
              );
            },
          ),
          const SizedBox(height: 28),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// ✅ Reusable widgets (unchanged)
// ─────────────────────────────────────────────────────────────
class GlassyBookingStop extends StatelessWidget {
  final IconData icon;
  final String title;
  final String details;
  final String time;

  const GlassyBookingStop({
    required this.icon,
    required this.title,
    required this.details,
    required this.time,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.10),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.red, size: 22),
          const SizedBox(width: 5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 13.3,
                  ),
                ),
                Text(
                  details,
                  style: GoogleFonts.poppins(
                    color: Colors.white70,
                    fontSize: 12.2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            time,
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 12.7),
          ),
        ],
      ),
    );
  }
}

class GlassyActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color glassColor;
  final Color textColor;
  final VoidCallback onTap;

  const GlassyActionButton({
    required this.icon,
    required this.label,
    required this.glassColor,
    required this.textColor,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          decoration: BoxDecoration(
            color: glassColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: textColor, size: 18),
              const SizedBox(width: 7),
              Text(
                label,
                style: GoogleFonts.poppins(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
