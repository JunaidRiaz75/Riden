// contact_support_bottom_sheet.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riden/my_profile/contact_support/instant_support_screen.dart';
import 'package:riden/my_profile/contact_support/submit_complaint_ticket_screen.dart';
import 'package:riden/theme/app_colors.dart';

class ContactSupportBottomSheet extends StatefulWidget {
  final ScrollController scrollController;

  const ContactSupportBottomSheet({required this.scrollController, super.key});

  @override
  State<ContactSupportBottomSheet> createState() =>
      _ContactSupportBottomSheetState();
}

class _ContactSupportBottomSheetState extends State<ContactSupportBottomSheet> {
  int selected = 0;

  void _onSelect(int idx, BuildContext context) {
    setState(() {
      selected = idx;
    });

    if (idx == 1) {
      _openSubmitComplaintBottomSheet(context);
    }
    if (idx == 2) {
      _openInstantSupportBottomSheet(context);
    }
    if (idx == 0) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: RidenColors.backgroundBase,
          title: const Text(
            "Emergency Call",
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            "This would call 911.",
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("OK", style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      );
    }
  }

  void _openSubmitComplaintBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          snap: true,
          snapSizes: const [0.5, 0.85, 0.95],
          builder: (context, scrollController) {
            return SubmitComplaintTicketBottomSheet(
              scrollController: scrollController,
            );
          },
        );
      },
    );
  }

  void _openInstantSupportBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          snap: true,
          snapSizes: const [0.5, 0.85, 0.95],
          builder: (context, scrollController) {
            return InstantSupportBottomSheet(
              scrollController: scrollController,
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            RidenColors.backgroundBase.withOpacity(0.98),
            RidenColors.backgroundBase.withOpacity(0.95),
            RidenColors.backgroundBase.withOpacity(0.92),
          ],
          stops: const [0.0, 0.6, 1.0],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 25,
            offset: const Offset(0, -5),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
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
          // Content
          Expanded(
            child: SingleChildScrollView(
              controller: widget.scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Header with Back Button
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
                        const SizedBox(width: 32),
                      ],
                    ),
                    const SizedBox(height: 34),

                    // 911 Call Button
                    GlassyContactButton(
                      icon: Icons.call,
                      label: "911 Call",
                      highlight: selected == 0,
                      onTap: () => _onSelect(0, context),
                    ),
                    const SizedBox(height: 22),

                    // Submit Complaint Ticket Button
                    GlassyContactButton(
                      icon: Icons.confirmation_number_rounded,
                      label: "Submit Complaint Ticket",
                      highlight: selected == 1,
                      onTap: () => _onSelect(1, context),
                    ),
                    const SizedBox(height: 22),

                    // Instant Support Button
                    GlassyContactButton(
                      icon: Icons.help_outline_rounded,
                      label: "Instant Support",
                      highlight: selected == 2,
                      onTap: () => _onSelect(2, context),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ],
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
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(highlight ? 0.15 : 0.08),
          borderRadius: BorderRadius.circular(17),
          border: Border.all(
            color: highlight ? Colors.red : Colors.white.withOpacity(0.2),
            width: highlight ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red.withOpacity(0.2),
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: highlight ? Colors.red : Colors.white70,
                  size: 28,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: highlight ? Colors.red : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
