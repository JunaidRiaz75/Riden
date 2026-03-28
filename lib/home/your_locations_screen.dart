// bookings_bottom_sheet.dart
// ignore_for_file: deprecated_member_use
//
// Place at: lib/bookings/bookings_bottom_sheet.dart

<<<<<<< HEAD
import 'package:Riden/theme/app_colors.dart';
import 'package:Riden/widgets/glass_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
=======
import 'dart:ui';
import 'package:flutter/material.dart';
>>>>>>> origin/my-version

class BookingsBottomSheet extends StatelessWidget {
  final ScrollController scrollController;

<<<<<<< HEAD
class YourLocationsScreen extends StatelessWidget {
  const YourLocationsScreen({
    super.key,
    required ScrollController scrollController,
  });
=======
  const BookingsBottomSheet({super.key, required this.scrollController});

  static const List<Map<String, String>> _locations = [
    {
      'title': 'Office',
      'address': '2972 Westheimer Rd, Santa Ana, Illinois 85486',
    },
    {
      'title': 'Coffee shop',
      'address': '1901 Thornridge Cir, Shiloh, Hawaii 81063',
    },
    {
      'title': 'Shopping center',
      'address': '4140 Parker Rd, Allentown, New Mexico 31134',
    },
    {
      'title': 'Office',
      'address': '2972 Westheimer Rd, Santa Ana, Illinois 85486',
    },
    {
      'title': 'Coffee shop',
      'address': '1901 Thornridge Cir, Shiloh, Hawaii 81063',
    },
    {
      'title': 'Shopping center',
      'address': '4140 Parker Rd, Allentown, New Mexico 31134',
    },
  ];
>>>>>>> origin/my-version

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(28),
        topRight: Radius.circular(28),
      ),
      child: BackdropFilter(
        // ── Key: heavy blur so the map bleeds through dark glass ──────────
        filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
        child: Container(
          decoration: BoxDecoration(
            // Dark semi-transparent — matches the screenshot exactly
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFF1C2035).withOpacity(0.93),
                const Color(0xFF151826).withOpacity(0.96),
              ],
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
            border: Border.all(color: Colors.white.withOpacity(0.10), width: 1),
          ),
          child: Column(
            children: [
              // ── Drag handle ────────────────────────────────────────────
              const SizedBox(height: 10),
              Center(
                child: Container(
                  width: 38,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.28),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // ── Pickup + Destination white card ────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 18,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // ── Pickup row ─────────────────────────────────────
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                        child: Row(
                          children: [
                            // Walk icon box — light grey
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF2F2F4),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.directions_walk_rounded,
                                size: 20,
                                color: Color(0xFF3A3A4A),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Pickup',
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.40),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  const Text(
                                    '2972 Westheimer Rd, Santa Ana, Illinois 85486',
                                    style: TextStyle(
                                      color: Color(0xFF141420),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ── Thin divider ───────────────────────────────────
                      Padding(
                        padding: const EdgeInsets.fromLTRB(62, 10, 14, 10),
                        child: Divider(
                          height: 1,
                          thickness: 1,
                          color: Colors.grey.withOpacity(0.15),
                        ),
                      ),

                      // ── Destination row ────────────────────────────────
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
                        child: Row(
                          children: [
                            // Red location icon box
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFEBEB),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.location_on_rounded,
                                size: 20,
                                color: Color(0xFFE53935),
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Text(
                                'Where to go?',
                                style: TextStyle(
                                  color: Color(0xFFB0B0BA),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            // MAP button — dark pill
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 9,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF252535),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                'MAP',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.5,
                                  letterSpacing: 0.6,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // ── Saved locations list — white text on dark glass ────────
              Expanded(
                child: ListView.separated(
                  controller: scrollController,
                  padding: const EdgeInsets.fromLTRB(16, 6, 16, 24),
                  itemCount: _locations.length,
                  separatorBuilder: (_, __) => Padding(
                    padding: const EdgeInsets.only(left: 28),
                    child: Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.white.withOpacity(0.08),
                    ),
                  ),
                  itemBuilder: (ctx, i) {
                    final loc = _locations[i];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Red circle dot
                          Container(
                            width: 11,
                            height: 11,
                            decoration: const BoxDecoration(
                              color: Color(0xFFE53935),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  loc['title']!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14.5,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  loc['address']!,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.50),
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
