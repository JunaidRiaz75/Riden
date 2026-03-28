// ride_bottom_sheet.dart
import 'dart:ui';

import 'package:Riden/bookings/ride_booking_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RideBottomSheet extends StatelessWidget {
  final ScrollController scrollController;

  const RideBottomSheet({required this.scrollController, super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(28),
        topRight: Radius.circular(28),
      ),
      child: Stack(
        children: [
          // Dark gradient background (same as chat)
          const RidenDarkBackground(),
          Column(
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
                child: RideBottomSheetContent(
                  scrollController: scrollController,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RideBottomSheetContent extends StatefulWidget {
  final ScrollController scrollController;

  const RideBottomSheetContent({required this.scrollController, super.key});

  @override
  State<RideBottomSheetContent> createState() => _RideBottomSheetContentState();
}

class _RideBottomSheetContentState extends State<RideBottomSheetContent> {
  final List<Map<String, String>> savedLocations = [
    {
      'name': 'Office',
      'address': '2972 Westheimer Rd, Santa Ana, Illinois 85486',
    },

    {
      'name': 'Coffee shop',
      'address': '1901 Thorndige Cir, Shiloh, Hawaii 81063',
    },
    {
      'name': 'Shopping center',
      'address': '4140 Parker Rd, Allentown, New Mexico 31134',
    },
    {
      'name': 'Office',
      'address': '2972 Westheimer Rd, Santa Ana, Illinois 85486',
    },
    {
      'name': 'Coffee shop',
      'address': '1901 Thorndige Cir, Shiloh, Hawaii 81063',
    },
    {
      'name': 'Shopping center',
      'address': '4140 Parker Rd, Allentown, New Mexico 31134',
    },
    {
      'name': 'Office',
      'address': '2972 Westheimer Rd, Santa Ana, Illinois 85486',
    },
    {
      'name': 'Coffee shop',
      'address': '1901 Thorndige Cir, Shiloh, Hawaii 81063',
    },
    {
      'name': 'Shopping center',
      'address': '4140 Parker Rd, Allentown, New Mexico 31134',
    },
    {
      'name': 'Office',
      'address': '2972 Westheimer Rd, Santa Ana, Illinois 85486',
    },
    {
      'name': 'Coffee shop',
      'address': '1901 Thorndige Cir, Shiloh, Hawaii 81063',
    },
    {
      'name': 'Shopping center',
      'address': '4140 Parker Rd, Allentown, New Mexico 31134',
    },
    // ... (can add more)
  ];

  void _openCarSelectionSheet() {
    Navigator.pop(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        snap: true,
        snapSizes: const [0.5, 0.85, 0.95],
        builder: (ctx, sc) => CarSelectionScreen(scrollController: sc),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const accentRed = Color(0xFFFF2B2B);

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            controller: widget.scrollController,
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tappable Pickup/Destination Card (glass‑like)
                  GestureDetector(
                    onTap: _openCarSelectionSheet,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.58),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1.5,
                        ),
                      ),
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        children: [
                          // Pickup field
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.white70,
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Pickup',
                                      style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '2972 Westheimer Rd, Santa Ana, Illinois 85486',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Divider(
                            color: Colors.white.withOpacity(0.2),
                            height: 1,
                          ),
                          const SizedBox(height: 12),
                          // Destination field
                          Row(
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: accentRed,
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Destination',
                                      style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Where to go?',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.45),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'MAP',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Saved Locations List (text in white)
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: savedLocations.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final location = savedLocations[index];
                      return GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Selected: ${location['name']}'),
                              backgroundColor: accentRed,
                              duration: const Duration(milliseconds: 800),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: accentRed,
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                  size: 12,
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    location['name']!,
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    location['address']!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white70,
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.white.withOpacity(0.2),
                                    height: 1,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
        // Bottom navigation bar (unchanged, works on any background)
        _HomeBottomNav(
          selectedIndex: 0,
          onChanged: (index) {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// BOTTOM NAVIGATION BAR – same as chat (light glass with dark icons)
// ─────────────────────────────────────────────────────────────────────────────
class _HomeBottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const _HomeBottomNav({required this.selectedIndex, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 17),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.58),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: Colors.white.withOpacity(0.7),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 12,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  children: [
                    _NItem(
                      0,
                      Icons.directions_car_rounded,
                      'Ride',
                      selectedIndex,
                      onChanged,
                    ),
                    _NItem(
                      1,
                      Icons.support_agent_rounded,
                      'Support',
                      selectedIndex,
                      onChanged,
                    ),
                    _NItem(
                      2,
                      Icons.receipt_long_rounded,
                      'Bookings',
                      selectedIndex,
                      onChanged,
                    ),
                    _NItem(
                      3,
                      Icons.person_outline_rounded,
                      'Account',
                      selectedIndex,
                      onChanged,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NItem extends StatelessWidget {
  final int index;
  final IconData icon;
  final String label;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const _NItem(
    this.index,
    this.icon,
    this.label,
    this.selectedIndex,
    this.onChanged,
  );

  @override
  Widget build(BuildContext context) {
    final bool active = selectedIndex == index;
    final Color iconColor = active
        ? const Color(0xFFE53935)
        : const Color.fromARGB(255, 24, 30, 36);
    final Color labelColor = active
        ? const Color(0xFFE53935)
        : const Color.fromARGB(255, 24, 30, 36);

    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(index),
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 1),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, color: iconColor, size: 24),
              const SizedBox(height: 6),
              Text(
                label,
                style: TextStyle(
                  color: labelColor,
                  fontSize: 12,
                  fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
