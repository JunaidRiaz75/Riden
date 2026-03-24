import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riden/theme/app_colors.dart'; // For RidenDarkBackground

class InstantSupportScreen extends StatelessWidget {
  const InstantSupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            const RidenDarkBackground(),
            SafeArea(
              child: Column(
                children: [
                  // Spacer for top area
                  const SizedBox(height: 40),
                  // Avatar illustration
                  Center(
                    child: CircleAvatar(
                      radius: 39,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 36,
                        backgroundImage: AssetImage('assets/images/avatar.png'), // Your icon asset
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  // Helpline title
                  Center(
                    child: Text(
                      "Helpline",
                      style: GoogleFonts.poppins(
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                        fontSize: 20.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 7),
                  Center(
                    child: Text(
                      "Calling...",
                      style: GoogleFonts.poppins(
                        color: Colors.black54,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.2,
                      ),
                    ),
                  ),
                  // Expanded to push bottom bar to the bottom
                  const Spacer(),

                  // Bottom action bar
                  Padding(
                    padding: const EdgeInsets.only(bottom: 26, left: 12, right: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Camera
                        CircleActionIcon(
                          icon: Icons.photo_camera_outlined,
                        ),
                        // Mic
                        CircleActionIcon(
                          icon: Icons.mic_none_outlined,
                        ),
                        // Call cut-off (RED)
                        CircleActionIcon(
                          icon: Icons.call_end_rounded,
                          bgColor: Colors.red,
                          iconColor: Colors.white,
                          onTap: () => Navigator.pop(context),
                        ),
                        // Share
                        CircleActionIcon(
                          icon: Icons.file_copy_outlined,
                        ),
                        // More
                        CircleActionIcon(
                          icon: Icons.more_horiz,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Bottom bar icons
class CircleActionIcon extends StatelessWidget {
  final IconData icon;
  final Color bgColor;
  final Color iconColor;
  final VoidCallback? onTap;

  const CircleActionIcon({
    required this.icon,
    this.bgColor = const Color(0xFFF5F5F5),
    this.iconColor = Colors.black54,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(25),
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: onTap,
        child: CircleAvatar(
          radius: 26,
          backgroundColor: bgColor,
          child: Icon(
            icon,
            color: iconColor,
            size: 26,
          ),
        ),
      ),
    );
  }
}