// ignore_for_file: deprecated_member_use

import 'package:Riden/auth/verification_screen.dart';
import 'package:Riden/theme/app_colors.dart';
import 'package:Riden/widgets/glass_button.dart';
import 'package:Riden/widgets/glass_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _phoneController = TextEditingController();

  // Country code dropdown data (optional)
  final List<Map<String, String>> _countryList = [
    {'code': '+1', 'flag': '🇨🇦', 'name': 'Canada'},
    {'code': '+91', 'flag': '🇮🇳', 'name': 'India'},
    {'code': '+44', 'flag': '🇬🇧', 'name': 'UK'},
    {'code': '+61', 'flag': '🇦🇺', 'name': 'Australia'},
    {'code': '+92', 'flag': '🇵🇰', 'name': 'Pakistan'},
  ];
  String _selectedCountryCode = '+1';
  String _selectedCountryFlag = '🇨🇦';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const RidenDarkBackground(), // Dark gradient background
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  // Title
                  Center(
                    child: Text(
                      'Forgot Password',
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: RidenColors.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Subtitle
                  Center(
                    child: Text(
                      "Enter your Phone Number to Reset\nYour Password",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: RidenColors.textSecondary,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Phone Number label
                  Text(
                    "Phone Number",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: RidenColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Glass phone number field with country dropdown
                  GlassField(
                    child: Row(
                      children: [
                        // Country Code Dropdown
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: DropdownButton<String>(
                            value: _selectedCountryCode,
                            dropdownColor: const Color(0xFF2a2a3a),
                            underline: const SizedBox(),
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                            style: GoogleFonts.poppins(
                              color: RidenColors.textPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            items: _countryList.map((country) {
                              return DropdownMenuItem<String>(
                                value: country['code'],
                                child: Row(
                                  children: [
                                    Text(
                                      country['flag']!,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(country['code']!),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (newCode) {
                              if (newCode != null) {
                                setState(() {
                                  _selectedCountryCode = newCode;
                                  final selected = _countryList.firstWhere(
                                    (c) => c['code'] == newCode,
                                  );
                                  _selectedCountryFlag = selected['flag']!;
                                });
                              }
                            },
                          ),
                        ),
                        // Divider
                        Container(width: 1, height: 28, color: Colors.white24),
                        const SizedBox(width: 8),
                        // Phone number input
                        Expanded(
                          child: TextFormField(
                            controller: _phoneController,
                            decoration: InputDecoration(
                              hintText: "Phone number",
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 14,
                                horizontal: 8,
                              ),
                              hintStyle: GoogleFonts.poppins(
                                color: RidenColors.textHint,
                                fontSize: 15,
                              ),
                            ),
                            keyboardType: TextInputType.phone,
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: RidenColors.textPrimary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Send OTP Button
                  GlassButton(
                    text: "Send OTP",
                    borderRadius: BorderRadius.circular(30),
                    height: 54,
                    textStyle: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                    type: GlassButtonType.primary,
                    onTap: () {
                      final phone = _phoneController.text.trim();
                      if (phone.isEmpty) {
                        Get.snackbar(
                          "Error",
                          "Please enter phone number",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                        return;
                      }
                      // TODO: Implement OTP sending logic.
                      Get.to(() => const VerificationScreen());
                    },
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
}
