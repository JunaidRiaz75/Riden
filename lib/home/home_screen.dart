import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:riden/home/your_locations_screen.dart';
import 'package:riden/theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
          // Card at top
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 36),
                child: GradientCard(
                  borderRadius: 23,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(13, 16, 13, 21),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Text(
                          "RIDEN",
                          style: GoogleFonts.audiowide(
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 5.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 13),
                      // Red location pill
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const YourLocationsScreen());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: accentRed,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: accentRed.withOpacity(0.16),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 13, horizontal: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Colors.white,
                                size: 22,
                              ),
                              const SizedBox(width: 9),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Your Location",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.5,
                                      ),
                                    ),
                                    Text(
                                      "Vancouver, British Columbia, Canada",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 13.6,
                                        fontWeight: FontWeight.w400,
                                        height: 1.18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      // Vertical indicator and glassy fields
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          VerticalDotsArrow(
                            totalDotSpace: 46 + 13 + 46,
                            dotColor: Colors.black,
                            dashColor: Colors.white38,
                            arrowColor: accentRed,
                          ),
                          const SizedBox(width: 2),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GlassyField(
                                  icon: Icons.place,
                                  hint: "No. 62/19 Plymade Rd, Punnaiyure",
                                ),
                                const SizedBox(height: 13),
                                GlassyField(
                                  icon: Icons.navigation,
                                  hint: "ENTER Your Destination",
                                  iconColor: accentRed,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],  // Column children
                  ),    // Column
                ),      // Padding (inner)
              ),        // GradientCard
            ),          // Padding (outer)
          ),            // Align
          ),            // SafeArea
          // Right-side arrow button — vertically centered
          Positioned(
            right: 12,
            top: 0,
            bottom: 0,
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Get.to(() => const YourLocationsScreen());
                },
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFFF2B2B),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFF2B2B).withOpacity(0.35),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ],              // Stack children
      ),
    );
  }
}

// --- GradientCard: Uses the SAME dark gradient as the splash screen ---
class GradientCard extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  const GradientCard({required this.child, this.borderRadius = 23, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Stack(
        children: [
          // Use the exact same dark gradient as splash screen
          Positioned.fill(
            child: const RidenDarkBackground(),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(color: Colors.white.withOpacity(0.10), width: 1.1),
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}

// --- Only the fields below are glassy ---
class GlassyField extends StatelessWidget {
  final IconData icon;
  final String hint;
  final Color? iconColor;
  const GlassyField({
    required this.icon,
    required this.hint,
    this.iconColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
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
          const SizedBox(width: 11),
          Icon(
            icon,
            color: iconColor ?? Colors.white.withOpacity(0.76),
            size: 21,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 15.2,
              ),
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
                hintStyle: GoogleFonts.poppins(
                  color: Colors.white.withOpacity(0.82),
                  fontSize: 14.8,
                ),
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---- Vertical indicator widget for dots/dashed/arrow, dynamically fills allotted space ----
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
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Top dot height, arrow height
    const dotSize = 9.0;
    const arrowSize = 22.0;
    return SizedBox(
      width: 22,
      height: totalDotSpace,
      child: Column(
        children: [
          // Top dot
          Container(
            width: dotSize,
            height: dotSize,
            decoration: BoxDecoration(
              color: dotColor,
              shape: BoxShape.circle,
            ),
          ),
          // Dotted line filling all space between dot and arrow
          Expanded(
            child: DottedLine(
              color: dashColor,
              width: 3.0,
              dashHeight: 7.5,
              dashSpacing: 6.3,
            ),
          ),
          // Arrow at the bottom
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
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
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
    });
  }
}

