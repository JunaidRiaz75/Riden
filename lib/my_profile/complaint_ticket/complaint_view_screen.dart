import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riden/theme/app_colors.dart';

class ComplaintViewScreen extends StatelessWidget {
  final Map<String, dynamic> ticketData;
  const ComplaintViewScreen({required this.ticketData, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Extracting data from ticketData or providing defaults
    final String type = ticketData['type'] ?? "Complaint Type";
    final String bookingId = ticketData['bookingId'] ?? "N/A";
    final String date = ticketData['date'] ?? "25 May, 2025";
    final String time = ticketData['time'] ?? "09:00pm";
    final String description = ticketData['desc'] ?? "No description provided.";
    final List<String> complaintImages = List<String>.from(ticketData['images'] ?? []);
    
    final String? adminReply = ticketData['adminReply'];
    final String? adminReplyDate = ticketData['adminReplyDate'];
    final String? adminReplyTime = ticketData['adminReplyTime'];
    final List<String> adminReplyImages = List<String>.from(ticketData['adminReplyImages'] ?? []);

    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            const RidenDarkBackground(),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 22),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 7),
                          Text(
                            type,
                            style: GoogleFonts.audiowide(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              letterSpacing: 0.8,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    
                    // Complaint Info Section
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.21),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "Booking ID : $bookingId",
                            style: GoogleFonts.poppins(
                              color: Colors.black87,
                              fontSize: 11.8,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          date,
                          style: GoogleFonts.poppins(
                            color: Colors.white70,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          time,
                          style: GoogleFonts.poppins(
                            color: Colors.white70,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      description,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 13.7,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (complaintImages.isNotEmpty)
                      Row(
                        children: [
                          ...complaintImages.map((path) =>
                            Padding(
                              padding: const EdgeInsets.only(right: 7),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  path,
                                  width: 77,
                                  height: 53,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => Container(
                                    width: 77,
                                    height: 53,
                                    color: Colors.white10,
                                    child: const Icon(Icons.broken_image, color: Colors.white30, size: 20),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                    if (adminReply != null) ...[
                      const SizedBox(height: 23),
                      // Divider
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        width: double.infinity,
                        height: 1,
                        color: Colors.white30,
                      ),
                      
                      // Replies Section
                      Row(
                        children: [
                          Text(
                            "Replies from support",
                            style: GoogleFonts.poppins(
                              color: Colors.red,
                              fontSize: 15.1,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          if (adminReplyDate != null)
                            Text(
                              adminReplyDate,
                              style: GoogleFonts.poppins(
                                color: Colors.white70,
                                fontSize: 12.5,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          const SizedBox(width: 8),
                          if (adminReplyTime != null)
                            Text(
                              adminReplyTime,
                              style: GoogleFonts.poppins(
                                color: Colors.white70,
                                fontSize: 12.5,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Text(
                        adminReply,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 13.7,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (adminReplyImages.isNotEmpty)
                        Row(
                          children: [
                            ...adminReplyImages.map((path) =>
                              Padding(
                                padding: const EdgeInsets.only(right: 7),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    path,
                                    width: 77,
                                    height: 53,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => Container(
                                      width: 77,
                                      height: 53,
                                      color: Colors.white10,
                                      child: const Icon(Icons.broken_image, color: Colors.white30, size: 20),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],

                    const SizedBox(height: 28),
                    // Reply button
                    GlassyReplyButton(
                      onTap: () {
                        // Reply action here
                      },
                    ),
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

class GlassyReplyButton extends StatelessWidget {
  final VoidCallback onTap;
  const GlassyReplyButton({required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 17),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.reply, color: Colors.white, size: 18),
              const SizedBox(width: 7),
              Text(
                "Reply",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}