// ignore_for_file: unused_field, prefer_final_fields, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riden/bookings/ride_booking_screen.dart';
import 'package:riden/theme/app_colors.dart';
import 'package:riden/widgets/glass_button.dart';
import 'package:riden/home/home_screen.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  LatLng _pickedLocation = const LatLng(30.2839, -97.7393);
  TextEditingController _controller = TextEditingController(
    text: "1234 Westheimer Rd, Santa Monica, TX",
  );
  Offset _pinPos = const Offset(0.5, 0.55);

  @override
  Widget build(BuildContext context) {
    const accentRed = Color(0xFFFF2B2B);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Full background map image
          Positioned.fill(
            child: Image.asset(
              'assets/images/map1.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
            ),
          ),

          // Pin overlay on the map (centered)
          Center(
            child: _Pin(accentRed: accentRed),
          ),

          // Pin label overlay
          Positioned(
            top: MediaQuery.of(context).size.height * 0.48,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
                decoration: BoxDecoration(
                  color: accentRed,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Text(
                  "Westheimer Rd, Santa",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),

          // Gradient card at top
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: GradientCard(
                  borderRadius: 23,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Back arrow + title row
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              "Add a place",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Find your place by searching the address or simply drop a pin on the map to mark the exact pickup spot.",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(0.72),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Glassy search field
                        GlassyField(
                          icon: Icons.search_rounded,
                          hint: "Enter place address",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Bottom buttons
          Positioned(
            left: 15,
            right: 15,
            bottom: 22 + MediaQuery.of(context).padding.bottom,
            child: Row(
              children: [
                Expanded(
                  child: GlassButton(
                    text: "Confirm Location",
                    onTap: () {
                      Get.to(() => const RideBookingScreen());
                    },
                    height: 46,
                    borderRadius: BorderRadius.circular(22),
                    type: GlassButtonType.primary,
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: GlassButton(
                    text: "Cancel",
                    onTap: () => Get.back(),
                    height: 46,
                    borderRadius: BorderRadius.circular(22),
                    type: GlassButtonType.secondary,
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white,
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
}

class _Pin extends StatelessWidget {
  final Color accentRed;
  const _Pin({required this.accentRed});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: accentRed,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: accentRed.withOpacity(0.35),
                blurRadius: 14,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 3,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.25),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}
