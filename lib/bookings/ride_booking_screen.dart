// ride_booking_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riden/bookings/my_bookings_detail_screen.dart';
import 'package:riden/bookings/my_bookings_screen.dart';
import 'package:riden/call_and_chat/chat_screen.dart';
import 'package:riden/my_profile/profile_management.dart';
import 'package:riden/notifications/notification.dart';
import 'package:riden/theme/app_colors.dart';
import 'package:riden/widgets/glass_bottom_nav.dart';
import 'package:riden/widgets/glass_button.dart';
import 'package:riden/widgets/glass_dropdown.dart';
import 'package:riden/widgets/glass_input_field.dart';

class RideBookingScreen extends StatefulWidget {
  const RideBookingScreen({super.key});

  @override
  State<RideBookingScreen> createState() => _RideBookingScreenState();
}

class _RideBookingScreenState extends State<RideBookingScreen> {
  int _selectedNavIndex = 0; // Home tab selected

  String selectedCarType = 'Standard';
  final carTypes = [
    {'name': 'Standard', 'asset': 'assets/images/standard_car.png'},
    {'name': 'SUV', 'asset': 'assets/images/suv_car.png'},
    {'name': 'Van', 'asset': 'assets/images/van_car.png'},
    {'name': 'Premium', 'asset': 'assets/images/premium_car.png'},
    {
      'name': 'Wheelchair Accessible',
      'asset': 'assets/images/wheelchair_car.png',
      'forceWrap': true,
    },
  ];

  String paymentMethod = 'Payment via Wallet';
  final paymentOptions = ['Payment via Wallet', 'Debit/Credit Card'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          const RidenDarkBackground(),
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                const SizedBox(height: 18),
                // Header with Back Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_back_ios,
                              color: RidenColors.textPrimary,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Back',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: RidenColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "RIDEN",
                        style: GoogleFonts.audiowide(
                          fontSize: 26,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4,
                        ),
                      ),
                      const SizedBox(width: 50), // Balance for symmetry
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      children: [
                        // Location and Destination - vertical connect UI
                        const _PickupDropFields(),
                        const SizedBox(height: 18),

                        // --- Car selector ---
                        SizedBox(
                          height: 86,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: carTypes.length,
                            separatorBuilder: (context, idx) =>
                                const SizedBox(width: 12),
                            itemBuilder: (context, idx) {
                              final type = carTypes[idx];
                              final selected = type['name'] == selectedCarType;

                              final isWheelchair =
                                  (type['forceWrap'] == true ||
                                  type['name'] == 'Wheelchair Accessible');
                              final lines = isWheelchair
                                  ? ['Wheelchair', 'Accessible']
                                  : [type['name'] as String];

                              return GestureDetector(
                                onTap: () {
                                  setState(
                                    () => selectedCarType =
                                        type['name'] as String,
                                  );
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 170),
                                  width: 85,
                                  height: 86,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: selected
                                        ? Colors.white.withOpacity(0.13)
                                        : Colors.white.withOpacity(0.07),
                                    border: Border.all(
                                      color: selected
                                          ? Colors.red
                                          : Colors.white.withOpacity(0.17),
                                      width: selected ? 2 : 1,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        type['asset'] as String,
                                        width: 32,
                                        height: 28,
                                        fit: BoxFit.contain,
                                      ),
                                      const SizedBox(height: 6),
                                      isWheelchair
                                          ? Column(
                                              children: [
                                                Text(
                                                  lines[0],
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w700,
                                                    height: 1.09,
                                                  ),
                                                ),
                                                Text(
                                                  lines[1],
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w700,
                                                    height: 1.09,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Text(
                                              lines[0],
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 12.5,
                                                fontWeight: FontWeight.w600,
                                                height: 1.14,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.visible,
                                            ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 18),

                        // Price, Distance & Time
                        Row(
                          children: [
                            Icon(
                              Icons.attach_money,
                              color: Colors.red,
                              size: 19,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "EST Price : \$40.00",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Icon(
                              Icons.location_pin,
                              color: Colors.red,
                              size: 19,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "EST distance : 12km",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(
                              Icons.timer_rounded,
                              color: Colors.red,
                              size: 19,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "EST Time : 34 - 50 mins",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        GlassInputField(
                          hint: "Apply Coupon Code (optional)",
                          icon: Icons.card_giftcard,
                        ),
                        const SizedBox(height: 10),

                        GlassDropdown(
                          value: paymentMethod,
                          items: paymentOptions,
                          onChanged: (v) => setState(() => paymentMethod = v!),
                        ),
                        const SizedBox(height: 18),

                        GlassButton(
                          text: "Book Ride",
                          type: GlassButtonType.primary,
                          textStyle: GoogleFonts.poppins(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                          onTap: () {
                            Get.to(() => const MyBookingsDetailScreen());
                          },
                        ),
                        const SizedBox(height: 16),

                        // Map image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            "assets/images/map1.png",
                            fit: BoxFit.cover,
                            height: 180,
                            width: double.infinity,
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),

      // ✅ BOTTOM NAVIGATION BAR
      bottomNavigationBar: GlassBottomNav(
        selectedIndex: _selectedNavIndex,
        onTap: (index) {
          setState(() {
            _selectedNavIndex = index;
          });

          // Handle navigation
          if (index == 0) {
            Get.offAllNamed('/home');
          } else if (index == 1) {
            Get.to(() => const MyBookingsScreen());
          } else if (index == 2) {
            Get.to(() => const NotificationsScreen());
          } else if (index == 3) {
            Get.to(() => const ChatScreen());
          } else if (index == 4) {
            Get.to(() => ProfileSidebar());
          }
        },
      ),
    );
  }
}

/// DYNAMIC VERTICAL DOTS + ARROW MATCHING FIELD HEIGHT
class _PickupDropFields extends StatelessWidget {
  const _PickupDropFields({super.key});

  @override
  Widget build(BuildContext context) {
    const fieldHeight = 46.0;
    const spacing = 11.0;
    final totalHeight = fieldHeight * 2 + spacing;
    const accentRed = Color(0xFFFF2B2B);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VerticalDotsArrow(
          totalDotSpace: totalHeight,
          dotColor: Colors.black,
          dashColor: Colors.white38,
          arrowColor: accentRed,
        ),
        const SizedBox(width: 2),
        Expanded(
          child: Column(
            children: [
              GlassInputField(hint: "Your Location", icon: Icons.location_on),
              const SizedBox(height: spacing),
              GlassInputField(hint: "Enter Your Destination", icon: Icons.flag),
            ],
          ),
        ),
      ],
    );
  }
}

/// Vertical indicator with dynamic dots ---
class VerticalDotsArrow extends StatelessWidget {
  final double totalDotSpace;
  final Color dotColor;
  final Color dashColor;
  final Color arrowColor;

  const VerticalDotsArrow({
    required this.totalDotSpace,
    this.dotColor = Colors.black,
    this.dashColor = Colors.grey,
    this.arrowColor = Colors.red,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const dotSize = 9.0;
    const arrowSize = 22.0;
    return SizedBox(
      width: 22,
      height: totalDotSpace,
      child: Column(
        children: [
          Container(
            width: dotSize,
            height: dotSize,
            decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
          ),
          Expanded(
            child: DottedLine(
              color: dashColor,
              width: 3.0,
              dashHeight: 7.5,
              dashSpacing: 6.3,
            ),
          ),
          Icon(Icons.arrow_downward, color: arrowColor, size: arrowSize),
        ],
      ),
    );
  }
}

class DottedLine extends StatelessWidget {
  final Color color;
  final double width;
  final double dashHeight;
  final double dashSpacing;

  const DottedLine({
    required this.color,
    this.width = 2,
    this.dashHeight = 6,
    this.dashSpacing = 5,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final totalHeight = constraints.maxHeight;
        final nDashes =
            ((totalHeight + dashSpacing) / (dashHeight + dashSpacing)).floor();
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(nDashes, (_) {
            return Container(
              width: width,
              height: dashHeight,
              margin: EdgeInsets.only(bottom: dashSpacing),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(width / 2),
              ),
            );
          }),
        );
      },
    );
  }
}
