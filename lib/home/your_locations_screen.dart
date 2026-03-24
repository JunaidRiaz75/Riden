// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riden/home/add_place_screen.dart';
import 'package:riden/widgets/glass_button.dart';
import 'package:riden/theme/app_colors.dart';
import '../widgets/glass.dart';

class YourLocationsScreen extends StatelessWidget {
  const YourLocationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color accentRed = const Color(0xFFFF2B2B);

    // Replace with your real locations
    final locations = [
      {
        "title": "Office",
        "address": "2972 Westheimer Rd, Santa Ana, Illinois 85486",
        "lat": 30.2839,
        "lng": -97.7393,
      },
      {
        "title": "Coffee shop",
        "address": "1901 Thorndige Cir, Shiloh, Hawaii 81063",
        "lat": 21.348, // mock lat/lng
        "lng": -157.955,
      },
    ];

    return Scaffold(
      body: Stack(
        children: [
          /// Dark Gradient Background (same as splash)
          const RidenDarkBackground(),

          /// Page Content
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // AppBar and title
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                      onPressed: () => Get.back(),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "Your Locations",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Use My Current Location Glass
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: GlassSection(
                    blur: 16,
                    opacity: 0.13,
                    radius: 15,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 7,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.my_location, color: accentRed, size: 22),
                        const SizedBox(width: 9),
                        Text(
                          "Use My Current Location",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.89),
                            fontWeight: FontWeight.w500,
                            fontSize: 15.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Glass map preview with location label
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(17),
                        child: SizedBox(
                          height: 110,
                          width: double.infinity,
                          child: Image.asset(
                            'assets/images/map1.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 10,
                        bottom: 6,
                        child: Row(
                          children: [
                            Icon(Icons.location_on, color: accentRed, size: 21),
                            const SizedBox(width: 5),
                            Text(
                              "Vancouver, British Columbia, Canada",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.97),
                                fontWeight: FontWeight.w600,
                                fontSize: 14.7,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                // LOCATION LIST (glass cards)
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    itemCount: locations.length,
                    itemBuilder: (ctx, i) {
                      final loc = locations[i];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 11),
                        child: GlassSection(
                          blur: 16,
                          opacity: 0.15,
                          radius: 15,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 9,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.place, color: accentRed, size: 22),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      loc["title"]?.toString() ?? "",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      loc["address"]?.toString() ?? "",
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.76),
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.edit_location_alt_rounded,
                                  color: Colors.white54,
                                  size: 23,
                                ),
                                onPressed: () {}, // TODO: handle edit
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Add New Address Button (sticky)
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    14,
                    0,
                    14,
                    18 + MediaQuery.of(context).padding.bottom,
                  ),
                  child: GlassButton(
                    text: "Add New Address",
                    icon: Icons.add_location_alt_rounded,
                    iconColor:
                        Colors.white, // Added required iconColor parameter
                    onTap: () {
                      Get.to(() => const AddPlaceScreen());
                    },
                    width: double.infinity,
                    height: 46,
                    borderRadius: BorderRadius.circular(22),
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 16,
                      letterSpacing: 0.1,
                    ),
                    type: GlassButtonType
                        .primary, // <-- ensures red glass pill effect!
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

