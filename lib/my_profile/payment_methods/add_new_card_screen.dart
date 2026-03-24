import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:riden/theme/app_colors.dart'; // For RidenDarkBackground
import 'package:riden/widgets/glassmorphic_button.dart';
import 'package:riden/widgets/glass_button.dart';

class AddNewCardScreen extends StatefulWidget {
  const AddNewCardScreen({super.key});

  @override
  State<AddNewCardScreen> createState() => _AddNewCardScreenState();
}

class _AddNewCardScreenState extends State<AddNewCardScreen> {
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardHolderController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Painter-based gradient background
          const RidenDarkBackground(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 23),
                  // Title
                  Center(
                    child: Text(
                      "Add Payment",
                      style: GoogleFonts.audiowide(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 37),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Enter Details of Card",
                      style: GoogleFonts.poppins(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 13),

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
                    label: "Card Holder Name",
                    hint: "Enter Card Holder Name",
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 14),
                  GlassyField(
                    controller: cvvController,
                    label: "CVV",
                    hint: "Enter CVV",
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 14),
                  // Expiry date input with calendar icon
                  GlassyField(
                    controller: expiryController,
                    label: "Expiry Date",
                    hint: "00/00/00",
                    keyboardType: TextInputType.number,
                    suffix: Icon(Icons.calendar_today, color: Colors.redAccent, size: 22),
                  ),
                  const SizedBox(height: 28),

                  // Submit button: glassy, full width, red
                  GlassmorphicButton(
                    text: "Submit",
                    textStyle: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                    ),
                    glassColor: Colors.redAccent,
                    type: GlassButtonType.primary,
                    onTap: () {
                      // Submit logic here
                      Get.back();
                      Get.snackbar("Success", "Card added successfully",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green,
                          colorText: Colors.white);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// --- GlassyField widget ---
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
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 13.6,
          ),
        ),
        const SizedBox(height: 4),
        // Glassy input
        Container(
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.17),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.17)),
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
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: keyboardType,
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
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
              ),
              if (suffix != null) ...[
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: suffix!,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}