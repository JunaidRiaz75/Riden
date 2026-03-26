// your_locations_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riden/theme/app_colors.dart';

class YourLocationsScreen extends StatelessWidget {
  final ScrollController scrollController;

  const YourLocationsScreen({required this.scrollController, super.key});

  @override
  Widget build(BuildContext context) {
    final Color accentRed = const Color(0xFFFF2B2B);
    final locations = [
      {
        "title": "Office",
        "address": "2972 Westheimer Rd, Santa Ana, Illinois 85486",
      },
      {
        "title": "Coffee shop",
        "address": "1901 Thorndige Cir, Shiloh, Hawaii 81063",
      },
      {
        "title": "Shopping center",
        "address": "4140 Parker Rd. Allentown, New Mexico 31134",
      },
    ];

    return SingleChildScrollView(
      controller: scrollController,
      physics: const ClampingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ LOCATION SEARCH FIELDS
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Pickup Field
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.white.withOpacity(0.15)),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 14,
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.circle, color: Colors.black, size: 12),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pickup",
                              style: GoogleFonts.poppins(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "2972 Westheimer Rd. Santa Ana, Illinois 85486",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
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
                const SizedBox(height: 12),
                // Destination Field
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.white.withOpacity(0.15)),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 14,
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.flag, color: accentRed, size: 14),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                          decoration: InputDecoration(
                            hintText: "Where to go?",
                            hintStyle: GoogleFonts.poppins(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 15,
                            ),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ✅ SAVED LOCATIONS HEADER
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Saved Locations",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "See All",
                  style: TextStyle(
                    color: accentRed,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // ✅ SAVED LOCATIONS LIST (Horizontal Scroll)
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: locations.length,
              itemBuilder: (ctx, i) {
                final loc = locations[i];
                return Container(
                  width: 200,
                  margin: const EdgeInsets.only(right: 12),
                  child: GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Selected: ${loc["title"]}'),
                          backgroundColor: accentRed,
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    child: GlassSection(
                      opacity: 0.15,
                      radius: 15,
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.place, color: accentRed, size: 18),
                              const SizedBox(width: 6),
                              Text(
                                loc["title"]?.toString() ?? "",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            loc["address"]?.toString() ?? "",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 11,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // ✅ ADD NEW ADDRESS BUTTON
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: () {
                // Open Add Place as persistent bottom sheet
                _openAddPlacePersistentSheet(context);
              },
              child: Container(
                width: double.infinity,
                height: 48,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF2B2B), Color(0xFFFF4B4B)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF2B2B).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add_location_alt_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Add New Address",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  void _openAddPlacePersistentSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.12,
          minChildSize: 0.12,
          maxChildSize: 0.85,
          snap: true,
          snapSizes: const [0.12, 0.45, 0.85],
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    RidenColors.backgroundBase.withOpacity(0.98),
                    RidenColors.backgroundBase.withOpacity(0.95),
                    RidenColors.backgroundBase.withOpacity(0.92),
                  ],
                  stops: const [0.0, 0.6, 1.0],
                ),
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

// GlassSection Widget
class GlassSection extends StatelessWidget {
  final Widget child;
  final double opacity;
  final double radius;
  final EdgeInsetsGeometry padding;

  const GlassSection({
    required this.child,
    this.opacity = 0.13,
    this.radius = 15,
    this.padding = const EdgeInsets.all(0),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(opacity),
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: Colors.white.withOpacity(0.15)),
        ),
        child: child,
      ),
    );
  }
}

// AddPlaceContent class - you'll need to import this from add_place_screen.dart
// Or create a placeholder for now
class AddPlaceContent extends StatelessWidget {
  final ScrollController scrollController;

  const AddPlaceContent({required this.scrollController, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Add Place Content', style: TextStyle(color: Colors.white)),
    );
  }
}
