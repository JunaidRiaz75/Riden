import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riden/theme/app_colors.dart';
import 'package:riden/bookings/report_issue_screen.dart'; 

class MyBookingsDetailScreen extends StatelessWidget {
  final String date;
  final String bookingId;

  const MyBookingsDetailScreen({
    super.key,
    this.date = "Sun, 23 May 2025",
    this.bookingId = "2345",
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(child: RidenDarkBackground()),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // AppBar row
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new,
                            color: Colors.white, size: 21),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 4),
                      Text(date,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          )),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Map container
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
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
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
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 8),
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
                  Row(
                    children: [
                      Icon(Icons.timer, color: Colors.red, size: 21),
                      const SizedBox(width: 2),
                      Text(
                        "Duration: 34 mins",
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontWeight: FontWeight.w500, fontSize: 13.2),
                      ),
                      const SizedBox(width: 20),
                      Icon(Icons.square_outlined, color: Colors.red, size: 18),
                      const SizedBox(width: 2),
                      Text(
                        "Distance: 5.2km",
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontWeight: FontWeight.w500, fontSize: 13.2),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 24,
                    thickness: 1,
                    color: Colors.white24,
                  ),
                  Row(
                    children: [
                         Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: AssetImage('assets/driver.jpg'),
                                fit: BoxFit.cover,
                              ),
                              color: Colors.grey.shade800,
                            ),
                            child: Image.network(
                              'https://i.pravatar.cc/150?img=33',
                              fit: BoxFit.cover,
                            ),
                          ),
                      const SizedBox(width: 13),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sergio",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.3,
                            ),
                          ),
                          Text(
                            "Black Suzuki Alto, (BKG-220)",
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
                  Row(
                    children: [
                      Text("Rating & Review",
                        style: GoogleFonts.poppins(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.9,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  Row(
                    children: [
                      ...List.generate(5, (i) => Icon(
                        i < 4 ? Icons.star : Icons.star_border,
                        color: Colors.red,
                        size: 21,
                      )),
                      const SizedBox(width: 5),
                      Text("(4.0)",
                        style: GoogleFonts.poppins(
                          color: Colors.white70,
                          fontSize: 13.3,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 3.2),
                  Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 13.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.lightbulb, color: Colors.amber, size: 20),
                      const SizedBox(width: 5),
                      Text("Tip",
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
                          text: "You gave Sergio ",
                          style: GoogleFonts.poppins(
                            color: Colors.white70, fontSize: 13.2,
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
                            color: Colors.white70, fontSize: 13.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 28,
                    thickness: 1,
                    color: Colors.white24,
                  ),

                  // ---- GLASSY ACTION BUTTONS VERTICAL ----
                  GlassyActionButton(
                    icon: Icons.download_for_offline,
                    label: "Download Receipt",
                    glassColor: Colors.white.withOpacity(0.13),
                    textColor: Colors.white,
                    onTap: () {
                      // Download logic
                    },
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
                        MaterialPageRoute(
                          builder: (_) => const ReportIssueScreen(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
    Key? key,
  }) : super(key: key);

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
                Text(title,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 13.3,
                  ),
                ),
                Text(details,
                  style: GoogleFonts.poppins(
                    color: Colors.white70,
                    fontSize: 12.2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(time,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 12.7,
            ),
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
    Key? key,
  }) : super(key: key);

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
              Text(label, style: GoogleFonts.poppins(
                color: textColor,
                fontWeight: FontWeight.w600,
                fontSize: 14.3,
              )),
            ],
          ),
        ),
      ),
    );
  }
}