// home_screen.dart
// ignore_for_file: unused_import, curly_braces_in_flow_control_structures, deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:riden/bookings/bookingride_loading.dart';
import 'package:riden/bookings/bookride.dart';
import 'package:riden/call_and_chat/chat_screen.dart';
import 'package:riden/home/your_locations_screen.dart';
import 'package:riden/my_profile/profilesheet.dart';
import 'package:riden/widgets/bottom_navbar.dart';
import 'package:riden/widgets/glass.dart'; // ← same GlassSection used by bottom nav

import '../theme/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    final bottomNavHeight = 70.0;
    final bottomNavBottomMargin = 16.0;
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.black,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ✅ FULL SCREEN MAP
          Positioned.fill(
            child: Image.asset(
              'assets/images/map1.png',
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),

          // ✅ TOP-RIGHT GLASSY PILL — same GlassSection as bottom nav
          Positioned(
            top: statusBarHeight + 12,
            right: 16,
            child: const _GlassyActionPill(),
          ),

          // ✅ DRAGGABLE BOTTOM SHEET
          Positioned(
            left: 0,
            right: 0,
            bottom: bottomNavHeight + bottomNavBottomMargin,
            child: DraggableScrollableSheet(
              initialChildSize: 0.15,
              minChildSize: 0.12,
              maxChildSize: 0.65,
              snap: true,
              snapSizes: const [0.15, 0.35, 0.65],
              builder: (context, scrollController) {
                return ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                    child: Container(
                      decoration: BoxDecoration(
                        // Match GlassSection: opacity 0.21 on white
                        color: Colors.white.withOpacity(0.21),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(28),
                          topRight: Radius.circular(28),
                        ),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.13),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
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
                          Expanded(
                            child: YourLocationsScreen(
                              scrollController: scrollController,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      // ✅ BOTTOM NAV BAR
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: bottomNavBottomMargin),
        child: GlassyBottomNavBar(
          currentIndex: _selectedNavIndex,
          onChanged: (int value) {
            setState(() => _selectedNavIndex = value);
            if (value == 0)
              _openRideBottomSheet(context);
            else if (value == 1)
              _openBookingBottomSheet(context);
            else if (value == 2)
              _openChatBottomSheet(context);
            else if (value == 3)
              _openProfileBottomSheet(context);
          },
        ),
      ),
    );
  }

  void _openRideBottomSheet(BuildContext context) {
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
        builder: (context, sc) => BookRideBottomSheet(scrollController: sc),
      ),
    );
  }

  void _openBookingBottomSheet(BuildContext context) {
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
        builder: (context, sc) => BookingBottomSheet(scrollController: sc),
      ),
    );
  }

  void _openChatBottomSheet(BuildContext context) {
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
        builder: (context, sc) => ChatBottomSheet(scrollController: sc),
      ),
    );
  }

  void _openProfileBottomSheet(BuildContext context) {
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
        builder: (context, sc) => ProfileBottomSheet(scrollController: sc),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────
// ✅ GLASSY ACTION PILL
//    Uses the exact same GlassSection widget as GlassyBottomNavBar:
//    radius: 28, blur: 18, opacity: 0.21, borderColor: white 13%
// ──────────────────────────────────────────────────────────────
class _GlassyActionPill extends StatelessWidget {
  const _GlassyActionPill();

  @override
  Widget build(BuildContext context) {
    return GlassSection(
      radius: 28, // matches bottom nav radius exactly
      blur: 18, // matches bottom nav blur exactly
      opacity: 0.21, // matches bottom nav opacity exactly
      borderColor: Colors.white.withOpacity(
        0.13,
      ), // matches bottom nav border exactly
      child: SizedBox(
        width: 54,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 🔔 Bell — Notifications
            _PillIconButton(icon: Icons.notifications_outlined, onTap: () {}),
            // ⊕ GPS Crosshair — Location
            _PillIconButton(icon: Icons.gps_fixed, onTap: () {}),
            // ➤ Near Me — Navigate / Share
            _PillIconButton(icon: Icons.near_me_outlined, onTap: () {}),
          ],
        ),
      ),
    );
  }
}

class _PillIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _PillIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 54,
        height: 52,
        child: Icon(
          icon,
          // Match unselected icon color from bottom nav
          color: Colors.white.withOpacity(0.91),
          size: 22,
        ),
      ),
    );
  }
}

class _PillDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.6,
      width: 32,
      // Match border color from GlassSection
      color: Colors.white.withOpacity(0.13),
    );
  }
}
