// ignore_for_file: deprecated_member_use

import 'package:Riden/auth/sign_in_screen.dart';
import 'package:Riden/theme/app_colors.dart';
import 'package:Riden/widgets/glass_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordResetSuccessScreen extends StatelessWidget {
  const PasswordResetSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const RidenDarkBackground(),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 26,
                  vertical: 36,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Illustration
                    Image.asset(
                      "assets/images/password_success.png",
                      width: 236.58,
                      height: 180,
                    ),
                    const SizedBox(height: 22),

                    // Title
                    Text(
                      "Congratulations!",
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: RidenColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Subtitle
                    Text(
                      "Your New Password has been\nupdated Successfully",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: RidenColors.textSecondary,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 36),

                    // Continue Button
                    GlassButton(
                      text: "Continue",
                      borderRadius: BorderRadius.circular(30),
                      height: 54,
                      textStyle: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      type: GlassButtonType.primary,
                      onTap: () {
                        Get.offAll(() => const SignInScreen());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
