import 'package:Riden/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CallScreen extends StatelessWidget {
  const CallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Use the painter-based gradient (identical to rest of app)
          const RidenDarkBackground(),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 56),
                // Avatar
                CircleAvatar(
                  radius: 52,
                  backgroundColor: Colors.white.withOpacity(0.07),
                  child: CircleAvatar(
                    radius: 49,
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                const SizedBox(height: 20),
                // Name
                Text(
                  "Sergio",
                  style: GoogleFonts.poppins(
                    fontSize: 27,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                // Status
                Text(
                  "Calling...",
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                    color: Colors.white70,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
                // Glassy controls
                Padding(
                  padding: const EdgeInsets.only(bottom: 30, left: 9, right: 9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _CircleGlassIcon(icon: Icons.videocam),
                      _CircleGlassIcon(icon: Icons.mic_off),
                      _CircleGlassIcon(
                        icon: Icons.call_end_rounded,
                        filled: true,
                        color: Colors.redAccent,
                        onTap: () {
                          // Option 1: Go back to previous screen
                          Get.back();
                          // Option 2: Go directly to Booking Ride Detail screen
                          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const BookingDetailsScreen()));
                        },
                      ),
                      _CircleGlassIcon(icon: Icons.folder_open),
                      _CircleGlassIcon(icon: Icons.more_horiz),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Glassy circular icon with option for tap
class _CircleGlassIcon extends StatelessWidget {
  final IconData icon;
  final bool filled;
  final Color? color;
  final VoidCallback? onTap;
  const _CircleGlassIcon({
    required this.icon,
    this.filled = false,
    this.color,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final iconWidget = Center(
      child: Icon(
        icon,
        color: filled ? Colors.white : Colors.white70,
        size: filled ? 29 : 24,
      ),
    );
    final content = Container(
      width: 53,
      height: 53,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: filled
            ? (color ?? Colors.redAccent)
            : Colors.white.withOpacity(0.14),
        border: Border.all(
          color: Colors.white.withOpacity(filled ? 0.0 : 0.20),
          width: 1.6,
        ),
        boxShadow: filled
            ? [
                BoxShadow(
                  color: (color ?? Colors.redAccent).withOpacity(0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: iconWidget,
    );

    return onTap != null
        ? GestureDetector(onTap: onTap, child: content)
        : content;
  }
}
