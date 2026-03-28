// complaint_tickets_bottom_sheet.dart
// ignore_for_file: deprecated_member_use

import 'package:Riden/my_profile/complaint_ticket/complaint_view_screen.dart';
import 'package:Riden/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ComplaintTicketsBottomSheet extends StatelessWidget {
  final ScrollController scrollController;

  const ComplaintTicketsBottomSheet({
    required this.scrollController,
    super.key,
  });

  void _openComplaintView(BuildContext context, Map<String, dynamic> ticket) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        snap: true,
        snapSizes: const [0.5, 0.85, 0.95],
        builder: (context, sc) =>
            ComplaintViewBottomSheet(scrollController: sc, ticketData: ticket),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final complaints = [
      {
        "section": "Today",
        "tickets": [
          {
            "type": "In-App Issue",
            "bookingId": "2345",
            "date": "25 May, 2025",
            "time": "09:00pm",
            "desc":
                "The application crashed while I was trying to book a ride. I had to restart the app multiple times.",
            "images": ['assets/images/car1.png', 'assets/images/car2.png'],
            "adminReply":
                "We are sorry for the inconvenience. Our technical team is looking into the crash logs for your session.",
            "adminReplyDate": "25 May, 2025",
            "adminReplyTime": "10:30pm",
            "adminReplyImages": <String>[],
          },
        ],
      },
      {
        "section": "Yesterday",
        "tickets": [
          {
            "type": "Driver Behavior",
            "bookingId": "2346",
            "date": "24 May, 2025",
            "time": "02:15pm",
            "desc":
                "The driver was bit rude during the trip. He was talking loudly on the phone throughout the journey.",
            "images": <String>[],
            "adminReply":
                "Thank you for reporting this. We have flagged this driver and will provide them with additional training.",
            "adminReplyDate": "24 May, 2025",
            "adminReplyTime": "05:00pm",
            "adminReplyImages": ['assets/images/car2.png'],
          },
        ],
      },
      {
        "section": "May, 20 2023",
        "tickets": [
          {
            "type": "Overcharged",
            "bookingId": "2348",
            "date": "20 May, 2023",
            "time": "11:00am",
            "desc":
                "I was charged more than the estimated price. The extra amount was for a route deviation which I didn't authorize.",
            "images": ['assets/images/car1.png'],
          },
        ],
      },
    ];

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(28),
        topRight: Radius.circular(28),
      ),
      child: Stack(
        children: [
          // ── Dark gradient background ──────────────────────
          const Positioned.fill(child: RidenDarkBackground()),

          // ── Sheet content ─────────────────────────────────
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
              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
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
                            "Complaint Tickets",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Complaint sections
                      ...complaints.map(
                        (section) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              section['section'] as String,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 15.1,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ...(section['tickets'] as List).map((ticket) {
                              return ComplaintTicketRow(
                                type: ticket['type'] as String,
                                bookingId: ticket['bookingId'] as String,
                                desc: ticket['desc'] as String,
                                onTap: () => _openComplaintView(
                                  context,
                                  ticket as Map<String, dynamic>,
                                ),
                              );
                            }),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── ComplaintTicketRow (unchanged widget) ───────────────────────────

class ComplaintTicketRow extends StatelessWidget {
  final String type;
  final String bookingId;
  final String desc;
  final VoidCallback onTap;

  const ComplaintTicketRow({
    required this.type,
    required this.bookingId,
    required this.desc,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(13),
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 7),
          padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 11),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.12),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          type,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.4,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.21),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "Booking ID : $bookingId",
                            style: GoogleFonts.poppins(
                              color: Colors.black87,
                              fontSize: 11.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(width: 7),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white70,
                          size: 15,
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Text(
                      desc,
                      style: GoogleFonts.poppins(
                        color: Colors.white70,
                        fontSize: 13.7,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
