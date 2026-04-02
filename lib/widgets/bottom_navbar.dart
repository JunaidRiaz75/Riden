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
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
        child: GlassSection(
          width: 0,
          height: 80,
          radius: 28,
          blur: 18,
          opacity: 0.21,
          borderColor: Colors.white.withOpacity(0.13),
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

// Placeholder for GlassSection – you likely have this defined elsewhere.
// If not, define it or adjust the import.
class GlassSection extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final double blur;
  final double opacity;
  final Color borderColor;
  final Widget child;

  const GlassSection({
    required this.width,
    required this.height,
    required this.radius,
    required this.blur,
    required this.opacity,
    required this.borderColor,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(opacity),
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: borderColor, width: 1),
          ),
          child: child,
        ),
      ),
    );
  }
}
