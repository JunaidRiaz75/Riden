// driver_selection_bottom_sheet.dart
import 'dart:ui';

import 'package:Riden/bookings/my_bookings_detail_screen.dart';
import 'package:Riden/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DriverSelectionBottomSheet extends StatelessWidget {
  final ScrollController scrollController;

  const DriverSelectionBottomSheet({required this.scrollController, super.key});

  @override
  Widget build(BuildContext context) {
    final List<Driver> drivers = [
      Driver(
        name: 'Sergio',
        avatarUrl: 'https://i.pravatar.cc/150?img=33',
        distance: '5mins away',
        ridesCount: 43,
        reviews: 31,
        carModel: 'Black Suzuki Alto',
        plate: 'BKG-220',
        distanceKm: '0.2 km',
        time: '2 min',
        fare: '\$25.00',
      ),
      Driver(
        name: 'Ahmed',
        avatarUrl: 'https://i.pravatar.cc/150?img=33',
        distance: '5mins away',
        ridesCount: 43,
        reviews: 31,
        carModel: 'White Mercedes',
        plate: 'BKG-134',
        distanceKm: '0.2 km',
        time: '2 min',
        fare: '\$35.00',
      ),
    ];

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(28),
        topRight: Radius.circular(28),
      ),
      child: Stack(
        children: [
          const RidenDarkBackground(),
          Column(
            children: [
              // Drag handle
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
              // Scrollable driver list
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  itemCount: drivers.length,
                  itemBuilder: (context, index) {
                    final driver = drivers[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: _DriverCard(
                        driver: driver,
                        onAccept: () {
                          // Close driver sheet and open booking details sheet
                          Navigator.pop(context);
                          showBookingDetailSheet(context, driver: driver);
                        },
                      ),
                    );
                  },
                ),
              ),
              // Bottom navigation bar
              _HomeBottomNav(
                selectedIndex: 0, // Ride tab active
                onChanged: (index) {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DriverCard extends StatelessWidget {
  final Driver driver;
  final VoidCallback onAccept;

  const _DriverCard({required this.driver, required this.onAccept});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
      ),
      child: Column(
        children: [
          // Driver info
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Avatar
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade800,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(driver.avatarUrl, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(width: 16),
                // Name, distance, rides/reviews
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        driver.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: RidenColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 14,
                            color: RidenColors.brandRed,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            driver.distance,
                            style: const TextStyle(
                              fontSize: 13,
                              color: RidenColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${driver.ridesCount} Rides (${driver.reviews} reviews)',
                        style: const TextStyle(
                          fontSize: 13,
                          color: RidenColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                // Accept Ride button
                ElevatedButton(
                  onPressed: onAccept,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: RidenColors.brandRed,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Accept Ride'),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white24, height: 1),
          // Stats row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStat('DISTANCE', driver.distanceKm),
                _buildStat('TIME', driver.time),
                _buildStat('FARE', driver.fare),
              ],
            ),
          ),
          const Divider(color: Colors.white24, height: 1),
          // Car details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '${driver.carModel}, (${driver.plate})',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: RidenColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: RidenColors.textSecondary,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: RidenColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class Driver {
  final String name;
  final String avatarUrl;
  final String distance;
  final int ridesCount;
  final int reviews;
  final String carModel;
  final String plate;
  final String distanceKm;
  final String time;
  final String fare;

  Driver({
    required this.name,
    required this.avatarUrl,
    required this.distance,
    required this.ridesCount,
    required this.reviews,
    required this.carModel,
    required this.plate,
    required this.distanceKm,
    required this.time,
    required this.fare,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// BOTTOM NAVIGATION BAR – dark icons/text, centered, no overflow
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
              color: Colors.white.withOpacity(
                0.58,
              ), // bright white for dark text
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
        ? const Color(0xFFE53935) // red when active
        : const Color.fromARGB(255, 24, 30, 36); // dark blue‑grey when inactive
    final Color labelColor = active
        ? const Color(0xFFE53935)
        : const Color.fromARGB(255, 24, 30, 36);

    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(index),
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 1,
          ), // reduced to prevent overflow
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
