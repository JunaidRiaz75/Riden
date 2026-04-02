// TODO Implement this library.
// riden_bottom_nav.dart
// ignore_for_file: use_super_parameters, deprecated_member_use

import 'dart:ui';

import 'package:Riden/bookings/bookride.dart';
import 'package:Riden/call_and_chat/chat_screen.dart';
import 'package:Riden/my_profile/profilesheet.dart';
import 'package:Riden/notifications/notification.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─────────────────────────────────────────────────────────────────────────────
// CENTRALIZED GLASSMORPHIC BOTTOM NAV
// ─────────────────────────────────────────────────────────────────────────────
class RidenBottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int>? onChanged;
  final bool isFromSheet;

  const RidenBottomNav({
    super.key,
    required this.selectedIndex,
    this.onChanged,
    this.isFromSheet = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 17),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.58),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: Colors.white.withOpacity(0.70), width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.10),
                  blurRadius: 12,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.only(top: 14),
                child: Row(
                  children: [
                    _NItem(0, Icons.directions_car_rounded, 'Bookings', selectedIndex, _handleNavigation),
                    _NItem(1, Icons.support_agent_rounded, 'Support', selectedIndex, _handleNavigation),
                    _NItem(2, Icons.notifications_none_rounded, 'Notifications', selectedIndex, _handleNavigation),
                    _NItem(3, Icons.person_outline_rounded, 'Account', selectedIndex, _handleNavigation),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleNavigation(int index, BuildContext context) {
    if (onChanged != null) {
      onChanged!(index);
    }

    switch (index) {
      case 0: // Bookings
        if (isFromSheet) Navigator.pop(context);
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          barrierColor: Colors.black54,
          builder: (_) => const RideBottomSheetEntry(),
        );
        break;
      case 1: // Support
        if (isFromSheet) Navigator.pop(context);
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          barrierColor: Colors.black54,
          builder: (_) => const ChatBottomSheetEntry(),
        );
        break;
      case 2: // Notifications
        if (isFromSheet) Navigator.pop(context);
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          barrierColor: Colors.black54,
          builder: (_) => const NotificationsBottomSheetEntry(),
        );
        break;
      case 3: // Account
        if (isFromSheet) Navigator.pop(context);
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          barrierColor: Colors.black54,
          builder: (context) => DraggableScrollableSheet(
            initialChildSize: 0.85,
            minChildSize: 0.5,
            maxChildSize: 0.95,
            snap: true,
            snapSizes: const [0.5, 0.85, 0.95],
            builder: (context, sc) => ProfileBottomSheet(scrollController: sc),
          ),
        );
        break;
    }
  }
}

class _NItem extends StatelessWidget {
  final int index;
  final IconData icon;
  final String label;
  final int selectedIndex;
  final Function(int, BuildContext) onTap;

  const _NItem(this.index, this.icon, this.label, this.selectedIndex, this.onTap);

  @override
  Widget build(BuildContext context) {
    final bool active = selectedIndex == index;
    final Color col = active ? const Color(0xFFE53935) : const Color.fromARGB(255, 24, 30, 36);
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index, context),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: col, size: 24),
            const SizedBox(height: 5),
            Text(
              label,
              style: GoogleFonts.poppins(
                color: col,
                fontSize: 12,
                fontWeight: active ? FontWeight.w700 : FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
