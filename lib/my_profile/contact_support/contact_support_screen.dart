import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riden/theme/app_colors.dart';
// Update these imports as necessary for your screens
import 'package:riden/my_profile/complaint_ticket/complaint_tickets_screen.dart';
import 'package:riden/my_profile/contact_support/submit_complaint_ticket_screen.dart';
import 'package:riden/my_profile/contact_support/instant_support_screen.dart';
import 'package:riden/my_profile/complaint_ticket/complaint_view_screen.dart';

class ContactSupportScreen extends StatefulWidget {
  const ContactSupportScreen({Key? key}) : super(key: key);

  @override
  State<ContactSupportScreen> createState() => _ContactSupportScreenState();
}

class _ContactSupportScreenState extends State<ContactSupportScreen> {
  // 0: 911 Call, 1: Complaint, 2: Instant
  int selected = 0;

  void _onSelect(int idx, BuildContext context) {
    setState(() {
      selected = idx;
    });

    // Navigation for Complaint and Instant support
    if (idx == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => SubmitComplaintTicketScreen()),
      );
    }
    if (idx == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => InstantSupportScreen()),
      );
    }
    if (idx == 0) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Emergency Call"),
          content: const Text("This would call 911."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            const RidenDarkBackground(),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Back arrow and centered title
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 22),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const Spacer(),
                        Text(
                          "Contact Support",
                          style: GoogleFonts.audiowide(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 19,
                            letterSpacing: 0.6,
                          ),
                        ),
                        const Spacer(),
                        const SizedBox(width: 32), // Just to balance the back arrow side
                      ],
                    ),
                    const SizedBox(height: 34),

                    // 911 Call - highlighted by default, highlights on click, and so do others
                    GlassyContactButton(
                      icon: Icons.call,
                      label: "911 Call",
                      highlight: selected == 0,
                      onTap: () => _onSelect(0, context),
                    ),
                    const SizedBox(height: 22),

                    GlassyContactButton(
                      icon: Icons.confirmation_number_rounded,
                      label: "Submit Complaint Ticket",
                      highlight: selected == 1,
                      onTap: () => _onSelect(1, context),
                    ),
                    const SizedBox(height: 22),

                    GlassyContactButton(
                      icon: Icons.help_outline_rounded,
                      label: "Instant Support",
                      highlight: selected == 2,
                      onTap: () => _onSelect(2, context),
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

class GlassyContactButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool highlight;
  final VoidCallback onTap;

  const GlassyContactButton({
    required this.icon,
    required this.label,
    required this.highlight,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color iconColor = highlight ? Colors.red : Colors.black54;
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(17),
      child: InkWell(
        borderRadius: BorderRadius.circular(17),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 26),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.11),
            borderRadius: BorderRadius.circular(17),
            border: Border.all(color: highlight ? Colors.red : Colors.transparent, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.07),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.red.withOpacity(0.13),
                radius: 24,
                child: Icon(icon, color: iconColor, size: 29),
              ),
              const SizedBox(height: 13),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}