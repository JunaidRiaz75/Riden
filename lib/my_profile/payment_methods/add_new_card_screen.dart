// add_new_card_bottom_sheet.dart
// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:Riden/widgets/riden_bottom_nav.dart';
import 'package:Riden/theme/app_colors.dart';
import 'package:Riden/widgets/glass_button.dart';
import 'package:Riden/widgets/glassmorphic_button.dart';
import 'package:Riden/widgets/glass_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class AddNewCardBottomSheet extends StatefulWidget {
  final ScrollController scrollController;

  const AddNewCardBottomSheet({required this.scrollController, super.key});

  @override
  State<AddNewCardBottomSheet> createState() => _AddNewCardBottomSheetState();
}

class _AddNewCardBottomSheetState extends State<AddNewCardBottomSheet> {
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardHolderController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();

  @override
  void dispose() {
    cardNumberController.dispose();
    cardHolderController.dispose();
    cvvController.dispose();
    expiryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double sheetH = constraints.maxHeight;
        final double sheetW = constraints.maxWidth;

        final double minH = screenHeight * 0.50;
        final double maxH = screenHeight * 1.00;
        final double progress = ((sheetH - minH) / (maxH - minH)).clamp(0.0, 1.0);

        final double cornerRadius = 32.0 * (1.0 - progress);

        return ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(cornerRadius),
            topRight: Radius.circular(cornerRadius),
          ),
          child: SizedBox(
            width: sheetW,
            height: sheetH,
            child: Stack(
              children: [
                // ── 1. Gradient background ──────────────────
                Positioned.fill(
                  child: CustomPaint(painter: _SheetGradientPainter()),
                ),

                // ── 2. Frosted glass blur layer ──
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        border: Border(
                          top: BorderSide(
                            color: Colors.white.withOpacity(0.15),
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // ── 3. Foreground content ──
                Column(
                  children: [
                    // Drag Handle
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 8),
                      child: Center(
                        child: Container(
                          width: 45,
                          height: 4.5,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(2.5),
                          ),
                        ),
                      ),
                    ),

                    // Header
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Row(
                              children: [
                                const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18),
                                const SizedBox(width: 6),
                                Text(
                                  'Back',
                                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "Add Card",
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 50),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Scrollable content
                    Expanded(
                      child: SingleChildScrollView(
                        controller: widget.scrollController,
                        physics: const ClampingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Center(
                              child: Image.asset(
                                'assets/images/add_card_illustration.png', // Assuming an asset for the central image based on mockup
                                height: 160,
                                errorBuilder: (context, error, stackTrace) =>
                                    const SizedBox(height: 140), // Placeholder if missing
                              ),
                            ),
                            const SizedBox(height: 30),

                            // Card fields
                            GlassyField(
                              controller: cardNumberController,
                              label: "Card Number",
                              hint: "Enter Card Number",
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBox(height: 14),
                            GlassyField(
                              controller: cardHolderController,
                              label: "Card Holder Name", // As seen in image
                              hint: "Enter Card Holder Name",
                            ),
                            const SizedBox(height: 14),
                            Row(
                              children: [
                                Expanded(
                                  child: GlassyField(
                                    controller: cvvController,
                                    label: "CVV",
                                    hint: "Enter CVV", // Or empty based on image
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: GlassyField(
                                    controller: expiryController,
                                    label: "Expiry Date",
                                    hint: "00/00/00",
                                    keyboardType: TextInputType.number,
                                    suffix: const Icon(
                                      Icons.calendar_today,
                                      color: Colors.red,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),

                            // Submit button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  elevation: 0,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Get.snackbar(
                                    "Success",
                                    "Card added successfully",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.green,
                                    colorText: Colors.white,
                                  );
                                },
                                child: Text(
                                  'Submit',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 100),
                          ],
                        ),
                      ),
                    ),

                    // Bottom Nav
                    RidenBottomNav(
                      selectedIndex: 3,
                      isFromSheet: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SheetGradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Base: dark navy
    canvas.drawRect(
      Rect.fromLTWH(0, 0, w, h),
      Paint()..color = const Color(0xFF1A1B2E),
    );

    // Warm copper glow — top-left
    _radialBlob(
      canvas,
      center: Offset(w * 0.15, h * 0.30),
      rx: w * 0.80,
      ry: h * 0.60,
      color: const Color(0xFF8B4A35),
      alpha: 170,
    );

    // Teal glow — bottom-right
    _radialBlob(
      canvas,
      center: Offset(w * 0.85, h * 0.75),
      rx: w * 0.80,
      ry: h * 0.60,
      color: const Color(0xFF2E6B72),
      alpha: 170,
    );
  }

  void _radialBlob(
    Canvas canvas, {
    required Offset center,
    required double rx,
    required double ry,
    required Color color,
    required int alpha,
  }) {
    final solid = Color.fromARGB(alpha, color.red, color.green, color.blue);
    final clear = Color.fromARGB(0, color.red, color.green, color.blue);

    final paint = Paint()
      ..shader = RadialGradient(colors: [solid, clear]).createShader(
        Rect.fromCenter(center: center, width: rx * 2, height: ry * 2),
      );

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.scale(1.0, ry / rx);
    canvas.translate(-center.dx, -center.dy);
    canvas.drawCircle(center, rx, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_SheetGradientPainter _) => false;
}

// ── GlassyField widget ──────────────────────────────────────────────

class GlassyField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final TextInputType keyboardType;
  final Widget? suffix;

  const GlassyField({
    required this.controller,
    required this.label,
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.suffix,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        GlassField(
          height: 56,
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller,
                  keyboardType: keyboardType,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                  decoration: InputDecoration(
                    hintText: hint,
                    border: InputBorder.none,
                    hintStyle: GoogleFonts.poppins(
                      color: Colors.white.withOpacity(0.4),
                      fontSize: 15,
                    ),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 0,
                    ),
                  ),
                ),
              ),
              if (suffix != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: suffix!,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
