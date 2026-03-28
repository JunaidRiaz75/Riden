// booking_bottom_sheet.dart
// ignore_for_file: deprecated_member_use

import 'package:Riden/bookings/my_bookings_detail_screen.dart';
import 'package:Riden/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // showBookingDetailSheet

class BookingBottomSheet extends StatelessWidget {
  final ScrollController scrollController;

  const BookingBottomSheet({required this.scrollController, super.key});

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
              // Drag Handle
              Padding(
                padding: const EdgeInsets.only(top: 12),
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
              Expanded(
                child: BookingBottomSheetContent(
                  scrollController: scrollController,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BookingBottomSheetContent extends StatefulWidget {
  final ScrollController scrollController;

  const BookingBottomSheetContent({required this.scrollController, super.key});

  @override
  State<BookingBottomSheetContent> createState() =>
      _BookingBottomSheetContentState();
}

class _BookingBottomSheetContentState extends State<BookingBottomSheetContent> {
  final Map<String, dynamic> ongoingBooking = {
    'date': '25 May, 2025',
    'bookingId': '2345',
    'price': '\$45.00',
    'pickLabel': 'Office',
    'pickAddress': '2972 Westheimer Rd. Santa Ana, Illinois 85486',
    'pickTime': '04:30pm',
    'dropLabel': 'Coffee shop',
    'dropAddress': '1901 Thornridge Cir. Shiloh, Hawaii 81063',
    'dropTime': '08:30pm',
    'status': 'Ongoing',
  };

  final List<Map<String, dynamic>> bookings = [
    {
      'date': '25 May, 2025',
      'bookingId': '2345',
      'price': '\$45.00',
      'pickLabel': 'Office',
      'pickAddress': '2972 Westheimer Rd. Santa Ana, Illinois 85486',
      'pickTime': '04:30pm',
      'dropLabel': 'Coffee shop',
      'dropAddress': '1901 Thornridge Cir. Shiloh, Hawaii 81063',
      'dropTime': '08:30pm',
      'status': 'Completed',
    },
    {
      'date': '24 May, 2025',
      'bookingId': '2344',
      'price': '\$35.00',
      'pickLabel': 'Home',
      'pickAddress': '1234 Main St, Austin, Texas 78701',
      'pickTime': '09:15am',
      'dropLabel': 'Airport',
      'dropAddress': 'Austin Bergstrom International Airport',
      'dropTime': '10:30am',
      'status': 'Completed',
    },
    {
      'date': '23 May, 2025',
      'bookingId': '2343',
      'price': '\$52.00',
      'pickLabel': 'Shopping Center',
      'pickAddress': '4140 Parker Rd. Allentown, New Mexico 31134',
      'pickTime': '02:00pm',
      'dropLabel': 'Home',
      'dropAddress': '1234 Main St, Austin, Texas 78701',
      'dropTime': '03:15pm',
      'status': 'Cancelled',
    },
  ];

  // ✅ Opens detail as a BOTTOM SHEET (not a screen)
  void _goToDetail(Map<String, dynamic> booking) {
    showBookingDetailSheet(
      context,
      date: booking['date'] ?? 'Sun, 23 May 2025',
      bookingId: booking['bookingId'] ?? '0000',
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.scrollController,
      physics: const ClampingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
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
                  "My Bookings",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // ── Ongoing Section ──
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ongoing Bookings",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.redAccent,
                  ),
                ),
                const SizedBox(height: 8),
                // ✅ Entire ongoing card tappable → opens detail sheet
                GestureDetector(
                  onTap: () => _goToDetail(ongoingBooking),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.red.withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Ride in Progress",
                              style: GoogleFonts.poppins(
                                color: Colors.green,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          ongoingBooking['date'],
                          style: GoogleFonts.poppins(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                ongoingBooking['pickAddress'],
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.flag, color: Colors.red, size: 16),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                ongoingBooking['dropAddress'],
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ongoingBooking['price'],
                              style: GoogleFonts.poppins(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // ✅ Track Ride → opens detail sheet
                            GestureDetector(
                              onTap: () => _goToDetail(ongoingBooking),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  "Track Ride",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // ── Past Bookings Header ──
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Past Bookings",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // ── Past Bookings List ──
          ...bookings.map((b) => _buildBookingCard(b)),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildBookingCard(Map<String, dynamic> booking) {
    final isCompleted = booking['status'] == 'Completed';
    final statusColor = isCompleted ? Colors.green : Colors.red;

    // ✅ Entire past card tappable → opens detail sheet
    return GestureDetector(
      onTap: () => _goToDetail(booking),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.15), width: 1),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  booking['date'],
                  style: GoogleFonts.poppins(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    booking['status'],
                    style: GoogleFonts.poppins(
                      color: statusColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Column(
                  children: [
                    const Icon(Icons.circle, color: Colors.black, size: 10),
                    Container(width: 2, height: 30, color: Colors.white38),
                    const Icon(Icons.navigation, color: Colors.red, size: 14),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            booking['pickLabel'],
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            booking['pickTime'],
                            style: GoogleFonts.poppins(
                              color: Colors.white54,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        booking['pickAddress'],
                        style: GoogleFonts.poppins(
                          color: Colors.white70,
                          fontSize: 11,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Text(
                            booking['dropLabel'],
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            booking['dropTime'],
                            style: GoogleFonts.poppins(
                              color: Colors.white54,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        booking['dropAddress'],
                        style: GoogleFonts.poppins(
                          color: Colors.white70,
                          fontSize: 11,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  booking['price'],
                  style: GoogleFonts.poppins(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // ✅ View Details → opens detail sheet
                GestureDetector(
                  onTap: () => _goToDetail(booking),
                  child: Text(
                    "View Details",
                    style: GoogleFonts.poppins(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
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
