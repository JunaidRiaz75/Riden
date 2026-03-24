// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:riden/auth/set_new_password_screen.dart';
import 'package:riden/theme/app_colors.dart';
import 'package:riden/widgets/glass_button.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final List<TextEditingController> _otpControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: AppColors.gradientColors,
            stops: AppColors.gradientStops,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Title
                Text(
                  'Verification',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 12),

                // Subtitle
                Text(
                  "Code has been send to ***** ***70",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: AppColors.textDark,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 28),

                // OTP Inputs
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (idx) {
                    return Container(
                      width: 54,
                      height: 54,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: AppColors.glassWhite.withOpacity(0.16),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: AppColors.primaryRed.withOpacity(
                            _otpControllers[idx].text.isNotEmpty ? 0.72 : 0.18,
                          ),
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: TextField(
                          controller: _otpControllers[idx],
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            color: AppColors.textDark,
                            fontWeight: FontWeight.w700,
                          ),
                          decoration: InputDecoration(
                            counterText: "",
                            border: InputBorder.none,
                          ),
                          onChanged: (val) {
                            if (val.isNotEmpty && idx < 3) {
                              FocusScope.of(context).nextFocus();
                            }
                            setState(() {});
                          },
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 32),

                // Resend link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Didn't receive code? ",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: AppColors.textDark,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // TODO: resend code logic
                      },
                      child: Text(
                        "Resend again",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: AppColors.primaryRed,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Verify Button
                GlassButton(
                  text: "Verify",
                  borderRadius: BorderRadius.circular(30),
                  height: 54,
                  textStyle: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  type: GlassButtonType.primary,
                  onTap: () {
                    final code = _otpControllers.map((c) => c.text).join();
                    if (code.length < 4) {
                      Get.snackbar("Error", "Please enter the full code",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white);
                      return;
                    }
                    // TODO: Implement verification logic
                    Get.to(() => const SetNewPasswordScreen());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (final c in _otpControllers) {
      c.dispose();
    }
    super.dispose();
  }
}
