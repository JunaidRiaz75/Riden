// ignore_for_file: unused_element_parameter

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riden/theme/app_colors.dart';

import 'my_bookings_detail_screen.dart';

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const RidenDarkBackground(),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 15),
                // Page Title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "My Bookings",
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    child: Column(
                      children: [
                        _BookingSection(
                          onTap: () {
                            Get.to(() => MyBookingsDetailScreen(booking: {}));
                          },
                          title: "Ongoing Bookings",
                          isOngoing: true,
                          bookings: [
                            BookingInfo(
                              date: "25 May, 2025",
                              price: "\$45.00",
                              pickLabel: "Office",
                              pickAddress:
                                  "2972 Westheimer Rd. Santa Ana, Illinois 85486",
                              pickTime: "04:30pm",
                              dropLabel: "Coffee shop",
                              dropAddress:
                                  "1901 Thornridge Cir. Shiloh, Hawaii 81063",
                              dropTime: "08:30pm",
                            ),
                          ],
                        ),
                        const SizedBox(height: 22),
                        _BookingSection(
                          onTap: () {
                            Get.to(() => MyBookingsDetailScreen(booking: {}));
                          },
                          title: "Past Bookings",
                          isOngoing: false,
                          bookings: [
                            BookingInfo(
                              date: "25 May, 2025",
                              price: "\$45.00",
                              pickLabel: "Office",
                              pickAddress:
                                  "2972 Westheimer Rd. Santa Ana, Illinois 85486",
                              pickTime: "04:30pm",
                              dropLabel: "Coffee shop",
                              dropAddress:
                                  "1901 Thornridge Cir. Shiloh, Hawaii 81063",
                              dropTime: "08:30pm",
                            ),
                          ],
                        ),
                        const SizedBox(height: 90), // Room for nav bar
                      ],
                    ),
                  ),
                ),

                // Glassy bottom nav bar
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BookingSection extends StatelessWidget {
  final String title;
  final bool isOngoing;
  final List<BookingInfo> bookings;
  final VoidCallback? onTap;
  const _BookingSection({
    required this.title,
    required this.isOngoing,
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
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: isOngoing ? Colors.redAccent : Colors.red[200],
          ),
        ),
        const SizedBox(height: 6),
        ...bookings.map(
          (booking) => _GlassBookingCard(
            info: booking,
            isOngoing: isOngoing,
            onTap: onTap,
          ),
        ),
      ],
    );
  }
}

class _GlassBookingCard extends StatelessWidget {
  final BookingInfo info;
  final bool isOngoing;
  final VoidCallback? onTap;
  const _GlassBookingCard({
    required this.info,
    required this.isOngoing,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 13),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.white.withOpacity(0.13),
          border: Border.all(color: Colors.white24, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.055),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            // Top row: date and price
            Row(
              children: [
                Text(
                  info.date,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 13.2,
                  ),
                ),
                const Spacer(),
                Text(
                  info.price,
                  style: GoogleFonts.poppins(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 9),
            // Booking route chain
            Row(
              children: [
                // Vertical icon chain
                SizedBox(
                  width: 24,
                  child: Column(
                    children: [
                      Icon(Icons.circle, color: Colors.black, size: 10),
                      Container(
                        width: 2,
                        height: 21,
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              width: 2,
                              color: Colors.white38,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                      ),
                      Icon(Icons.navigation, color: Colors.red, size: 20),
                    ],
                  ),
                ),
                const SizedBox(width: 6),
                // Pickup info and drop info
                Expanded(
                  child: Column(
                    children: [
                      _BookingPointRow(
                        label: info.pickLabel,
                        address: info.pickAddress,
                        time: info.pickTime,
                        isOffice: true,
                      ),
                      const SizedBox(height: 3),
                      _BookingPointRow(
                        label: info.dropLabel,
                        address: info.dropAddress,
                        time: info.dropTime,
                        isOffice: false,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BookingPointRow extends StatelessWidget {
  final String label, address, time;
  final bool isOffice;
  const _BookingPointRow({
    required this.label,
    required this.address,
    required this.time,
    required this.isOffice,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            address,
            style: GoogleFonts.poppins(color: Colors.white70, fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (isOffice)
          Icon(Icons.chevron_right, color: Colors.white54, size: 20),
        if (!isOffice) const SizedBox(width: 12),
        Text(
          time,
          style: GoogleFonts.poppins(color: Colors.white60, fontSize: 12.5),
        ),
      ],
    );
  }
}

// Booking data model
class BookingInfo {
  final String date,
      price,
      pickLabel,
      pickAddress,
      pickTime,
      dropLabel,
      dropAddress,
      dropTime;
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
