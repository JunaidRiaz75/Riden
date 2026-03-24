// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:riden/widgets/glass.dart';

class GlassyBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onChanged;
  const GlassyBottomNavBar({
    required this.currentIndex,
    required this.onChanged,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
        child: GlassSection(
          radius: 28,
          blur: 18,
          opacity: 0.21,
          borderColor: Colors.white.withOpacity(0.13),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            currentIndex: currentIndex,
            onTap: onChanged,
            selectedItemColor: const Color(0xFFF80F0F),
            unselectedItemColor: Colors.white.withOpacity(0.91),
            selectedLabelStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_rounded, size: 22),
                label: 'My Bookings',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.support_agent_rounded, size: 22),
                label: 'Support',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications_rounded, size: 22),
                label: 'Notifications',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded, size: 22),
                label: 'Account',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
