// widgets/glass_bottom_nav.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riden/bookings/my_bookings_screen.dart'; // Import the chat bottom sheet
import 'package:riden/call_and_chat/chat_screen.dart';
import 'package:riden/my_profile/profile_management.dart';

class GlassBottomNav extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const GlassBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  void _openChatBottomSheet(BuildContext context) {
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
            return ChatBottomSheet(scrollController: scrollController);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2, top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.11),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white12, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavIcon(
            icon: Icons.directions_car_rounded,
            label: "Ride",
            selected: selectedIndex == 0,
            onTap: () {
              onTap(0);
              if (selectedIndex != 0) {
                Get.offAllNamed('/home');
              }
            },
          ),
          _NavIcon(
            icon: Icons.assignment_rounded,
            label: "Bookings",
            selected: selectedIndex == 1,
            onTap: () {
              onTap(1);
              if (selectedIndex != 1) {
                Get.to(() => const MyBookingsScreen());
              }
            },
          ),
          _NavIcon(
            icon: Icons.support_agent,
            label: "Support",
            selected: selectedIndex == 2,
            onTap: () {
              onTap(2);
              if (selectedIndex != 2) {
                // Open Chat as Bottom Sheet instead of using Get.to()
                _openChatBottomSheet(context);
              }
            },
          ),
          _NavIcon(
            icon: Icons.person_rounded,
            label: "Account",
            selected: selectedIndex == 4,
            onTap: () {
              onTap(4);
              if (selectedIndex != 4) {
                Get.to(() => ProfileSidebar());
              }
            },
          ),
        ],
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavIcon({
    required this.icon,
    required this.label,
    required this.onTap,
    this.selected = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: selected
                  ? Colors.red.withOpacity(0.15)
                  : Colors.transparent,
            ),
            child: Icon(
              icon,
              color: selected ? Colors.redAccent : Colors.white70,
              size: 22,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: GoogleFonts.poppins(
              color: selected ? Colors.red : Colors.white70,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
