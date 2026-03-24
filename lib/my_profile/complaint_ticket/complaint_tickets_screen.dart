import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riden/theme/app_colors.dart';
// Import your ComplaintViewScreen when you create it!
import 'package:riden/my_profile/complaint_ticket/complaint_view_screen.dart';

class ComplaintTicketsScreen extends StatelessWidget {
  const ComplaintTicketsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample data
    final complaints = [
      {
        "section": "Today",
        "tickets": [
          {
            "type": "In-App Issue",
            "bookingId": "2345",
            "date": "25 May, 2025",
            "time": "09:00pm",
            "desc": "The application crashed while I was trying to book a ride. I had to restart the app multiple times.",
            "images": [
              'assets/images/car1.png',
              'assets/images/car2.png',
            ],
            "adminReply": "We are sorry for the inconvenience. Our technical team is looking into the crash logs for your session.",
            "adminReplyDate": "25 May, 2025",
            "adminReplyTime": "10:30pm",
            "adminReplyImages": [],
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
            "desc": "The driver was bit rude during the trip. He was talking loudly on the phone throughout the journey.",
            "images": [],
            "adminReply": "Thank you for reporting this. We have flagged this driver and will provide them with additional training.",
            "adminReplyDate": "24 May, 2025",
            "adminReplyTime": "05:00pm",
            "adminReplyImages": [
              'assets/images/car2.png',
            ],
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
            "desc": "I was charged more than the estimated price. The extra amount was for a route deviation which I didn't authorize.",
            "images": [
              'assets/images/car1.png',
            ],
            // No admin reply yet for this one
          },
        ],
      },
    ];

    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            const RidenDarkBackground(),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 19),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new,
                              color: Colors.white, size: 22),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 7),
                        Text(
                          "Complaint Tickets",
                          style: GoogleFonts.audiowide(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 19),
                    // Sections
                    ...complaints.map((section) => Column(
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
                            onTap: () {
                              Navigator.push(context,
                                MaterialPageRoute(
                                  builder: (_) => ComplaintViewScreen(ticketData: ticket as Map<String, dynamic>),
                                ),
                              );
                            },
                          );
                        }).toList(),
                        const SizedBox(height: 16),
                      ],
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
    Key? key,
  }) : super(key: key);

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
              // Left content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(type,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.4,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 10),
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
                        Icon(Icons.arrow_forward_ios_rounded,
                          color: Colors.white70,
                          size: 15),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Text(desc,
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