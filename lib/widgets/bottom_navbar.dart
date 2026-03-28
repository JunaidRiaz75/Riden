// bottom_navbar.dart
// ignore_for_file: deprecated_member_use
//
// Place at: lib/widgets/bottom_navbar.dart
// Used consistently across all screens/bottom sheets.

import 'dart:ui';
import 'package:flutter/material.dart';

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
    return Container(
      // Floating margin — same as home screen nav
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 14),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          // White frosted blur — matches screenshots
          filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
          child: Container(
            decoration: BoxDecoration(
              // Bright white-ish glass — key difference from dark map glass
              color: Colors.white.withOpacity(0.82),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: Colors.white.withOpacity(0.60),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.18),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  _NavItem(
                    index: 0,
                    icon: Icons.receipt_long_rounded,
                    label: 'Bookings',
                    currentIndex: currentIndex,
                    onTap: onChanged,
                  ),
                  _NavItem(
                    index: 1,
                    icon: Icons.support_agent_rounded,
                    label: 'Support',
                    currentIndex: currentIndex,
                    onTap: onChanged,
                  ),
                  _NavItem(
                    index: 2,
                    icon: Icons.notifications_outlined,
                    label: 'Notifications',
                    currentIndex: currentIndex,
                    onTap: onChanged,
                  ),
                  _NavItem(
                    index: 3,
                    icon: Icons.person_outline_rounded,
                    label: 'Account',
                    currentIndex: currentIndex,
                    onTap: onChanged,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final int index;
  final IconData icon;
  final String label;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _NavItem({
    required this.index,
    required this.icon,
    required this.label,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool active = currentIndex == index;
    // Active = red accent, inactive = dark grey (readable on white glass)
    final Color iconColor = active
        ? const Color(0xFFE53935)
        : const Color(0xFF5A5A6E);
    final Color labelColor = active
        ? const Color(0xFFE53935)
        : const Color(0xFF7A7A8E);

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: iconColor, size: 23),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: labelColor,
                  fontSize: 10.5,
                  fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
