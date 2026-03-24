import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:riden/bookings/ride_booking_screen.dart';
import 'package:riden/bookings/my_bookings_screen.dart';
import 'package:riden/call_and_chat/chat_screen.dart';
import 'package:riden/notifications/notification.dart';
import 'package:riden/my_profile/profile_management.dart';

// You can add more imports for Support, Notifications, Profile as needed.

class GlassBottomNav extends StatelessWidget {
  final int selectedIndex;
  const GlassBottomNav({Key? key, this.selectedIndex = -1}) : super(key: key);
  
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
            icon: Icons.assignment, 
            label: "My Bookings", 
            selected: selectedIndex == 0,
            onTap: () {
              if (selectedIndex != 0) {
                Get.to(() => MyBookingsScreen());
              }
            },
          ),
          _NavIcon(
            icon: Icons.support_agent, 
            label: "Support", 
            selected: selectedIndex == 1,
            onTap: () {
              if (selectedIndex != 1) {
                Get.to(() => ChatScreen());
              }
            },
          ),
          _NavIcon(
            icon: Icons.notifications_outlined, 
            label: "Notifications", 
            selected: selectedIndex == 2,
            onTap: () {
              // Add notifications screen navigation here
              Get.to(() => NotificationsScreen());
            },
          ),
          _NavIcon(
            icon: Icons.person, 
            label: "Profile", 
            selected: selectedIndex == 3,
            onTap: () {
              // Add profile screen navigation here
              Get.to(() => ProfileSidebar());
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
    Key? key
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: selected ? Colors.redAccent : Colors.white70, size: 22),
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