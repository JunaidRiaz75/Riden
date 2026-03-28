// booking_loading_bottom_sheet.dart
import 'dart:async';
import 'dart:ui';

import 'package:Riden/bookings/booking_ride_detail.dart';
import 'package:Riden/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingLoadingBottomSheet extends StatefulWidget {
  final ScrollController scrollController;

  const BookingLoadingBottomSheet({required this.scrollController, super.key});

  @override
  State<BookingLoadingBottomSheet> createState() =>
      _BookingLoadingBottomSheetState();
}

class _BookingLoadingBottomSheetState extends State<BookingLoadingBottomSheet> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Start a timer that will close this sheet and open the driver selection after 2 seconds.
    _timer = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        // First, close the current bottom sheet.
        Navigator.pop(context);
        // Then, open the driver selection bottom sheet.
        _openDriverSelectionSheet();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _openDriverSelectionSheet() {
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
          builder: (ctx, sc) =>
              DriverSelectionBottomSheet(scrollController: sc),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
              // Scrollable loading content
              Expanded(
                child: ListView(
                  controller: widget.scrollController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 24,
                  ),
                  children: [
                    Center(
                      child: Text(
                        'RIDEN',
                        style: GoogleFonts.audiowide(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator(
                          strokeWidth: 8,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            RidenColors.brandRed,
                          ),
                          backgroundColor: Colors.white.withOpacity(0.2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: Text(
                        'We are booking ride for you',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: RidenColors.textPrimary,
                          height: 1.4,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    _buildGlassCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Destination',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: RidenColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildLocationRow(
                            isFirst: true,
                            label: 'Office',
                            address:
                                '2972 Westheimer Rd. Santa Ana, Illinois 85486',
                          ),
                          _buildLocationRow(
                            isFirst: false,
                            label: 'Coffee shop',
                            address:
                                '1901 Thornridge Cir. Shiloh, Hawaii 81063',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildGlassCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ride Details',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: RidenColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildDetailRow('Total Distance', '234km'),
                          const SizedBox(height: 18),
                          _buildDetailRowWithIcon(
                            'Sedan',
                            Icons.directions_car,
                          ),
                          const SizedBox(height: 18),
                          _buildDetailRow('Payment Method', 'Wallet'),
                          const SizedBox(height: 18),
                          _buildDetailRow('Estimated Fare', '\$400.00'),
                          const SizedBox(height: 18),
                          _buildDetailRow(
                            'Discount',
                            '-\$40.00',
                            isDiscount: true,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              // Bottom navigation bar
              _HomeBottomNav(
                selectedIndex: 2, // Bookings tab is active while loading
                onChanged: (index) {
                  // If user taps a nav item, cancel timer and close sheet
                  _timer?.cancel();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGlassCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
      ),
      padding: const EdgeInsets.all(20),
      child: child,
    );
  }

  Widget _buildLocationRow({
    required bool isFirst,
    required String label,
    required String address,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: isFirst ? 0 : 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              if (isFirst)
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                )
              else
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: RidenColors.brandRed,
                  ),
                  child: const Center(
                    child: Icon(Icons.navigation, size: 8, color: Colors.white),
                  ),
                ),
              if (isFirst)
                Container(
                  width: 2,
                  height: 40,
                  color: Colors.white.withOpacity(0.3),
                  margin: const EdgeInsets.symmetric(vertical: 6),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: RidenColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  address,
                  style: TextStyle(
                    fontSize: 13,
                    color: RidenColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    bool isDiscount = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: RidenColors.textPrimary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isDiscount
                ? const Color(0xFF4ECDC4)
                : RidenColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRowWithIcon(String label, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: RidenColors.textPrimary,
          ),
        ),
        Icon(icon, color: Colors.white, size: 24),
      ],
    );
  }
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
