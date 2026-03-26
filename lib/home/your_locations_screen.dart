// your_locations_screen.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riden/theme/app_colors.dart';
import 'package:riden/widgets/glass_button.dart';

import '../widgets/glass.dart';

class YourLocationsScreen extends StatelessWidget {
  const YourLocationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color accentRed = const Color(0xFFFF2B2B);
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
        "lat": 21.348,
        "lng": -157.955,
      },
    ];

    return Scaffold(
      body: Stack(
        children: [
          const RidenDarkBackground(),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Add New Address Button - This will open the persistent bottom sheet
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
                    iconColor: Colors.white,
                    onTap: () {
                      // Open Add Place as persistent bottom sheet
                      _openAddPlacePersistentSheet(context);
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
                    type: GlassButtonType.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openAddPlacePersistentSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: RidenColors.backgroundBase,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.12, // Start small (just drag handle)
          minChildSize: 0.12, // Minimum size
          maxChildSize: 0.85, // Maximum size
          snap: true,
          snapSizes: const [0.12, 0.45, 0.85], // Snap points
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: RidenColors.backgroundBase,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 25,
                    offset: const Offset(0, -5),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Drag Handle
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
                  // Add Place Content
                  Expanded(
                    child: AddPlaceContent(scrollController: scrollController),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

// Add Place Content Widget (to be used inside the persistent bottom sheet)
class AddPlaceContent extends StatefulWidget {
  final ScrollController scrollController;

  const AddPlaceContent({required this.scrollController, super.key});

  @override
  State<AddPlaceContent> createState() => _AddPlaceContentState();
}

class _AddPlaceContentState extends State<AddPlaceContent> {
  final TextEditingController _addressController = TextEditingController(
    text: "1234 Westheimer Rd, Santa Monica, TX",
  );
  final TextEditingController _placeNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const accentRed = Color(0xFFFF2B2B);

    return SingleChildScrollView(
      controller: widget.scrollController,
      physics: const ClampingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
            child: Text(
              "Add a place",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),

          // Description
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            child: Text(
              "Find your place by searching the address or simply drop a pin on the map to mark the exact pickup spot.",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.white.withOpacity(0.72),
              ),
            ),
          ),

          // Place Name Field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GlassyField(
              icon: Icons.title,
              hint: "Place name (e.g., Home, Office)",
              controller: _placeNameController,
            ),
          ),
          const SizedBox(height: 12),

          // Address Search Field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GlassyField(
              icon: Icons.search_rounded,
              hint: "Enter place address",
              controller: _addressController,
              iconColor: accentRed,
            ),
          ),
          const SizedBox(height: 20),

          // Map preview with pin overlay
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/images/map1.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 80,
                  left: 0,
                  right: 0,
                  child: Center(child: _Pin(accentRed: accentRed)),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: accentRed,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: accentRed.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      _addressController.text.length > 25
                          ? "${_addressController.text.substring(0, 25)}..."
                          : _addressController.text,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Action Buttons
          Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              0,
              20,
              24 + MediaQuery.of(context).padding.bottom,
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Confirm location logic here
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Location added successfully!"),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF2B2B), Color(0xFFFF4B4B)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFF2B2B).withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          "Confirm Location",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
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

// GlassyField Widget (Reused)
class GlassyField extends StatelessWidget {
  final IconData icon;
  final String hint;
  final TextEditingController? controller;
  final Color? iconColor;

  const GlassyField({
    required this.icon,
    required this.hint,
    this.controller,
    this.iconColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.17),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.18)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 15),
          Icon(
            icon,
            color: iconColor ?? Colors.white.withOpacity(0.76),
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.82),
                  fontSize: 15,
                ),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
