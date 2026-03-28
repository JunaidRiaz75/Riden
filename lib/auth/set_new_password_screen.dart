// ignore_for_file: deprecated_member_use

import 'package:Riden/auth/password_reset_success_screen.dart';
import 'package:Riden/theme/app_colors.dart';
import 'package:Riden/widgets/glass_button.dart';
import 'package:Riden/widgets/glass_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SetNewPasswordScreen extends StatefulWidget {
  const SetNewPasswordScreen({super.key});

  @override
  State<SetNewPasswordScreen> createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const RidenDarkBackground(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Title
                  Text(
                    'Set New Password',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: RidenColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Subtitle
                  Text(
                    "Set your New Password",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: RidenColors.textSecondary,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 28),

                  // New Password Field
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "New Password",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: RidenColors.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  GlassField(
                    child: TextFormField(
                      controller: _newPasswordController,
                      obscureText: _obscureNew,
                      decoration: InputDecoration(
                        hintText: "123456789",
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 12,
                        ),
                        hintStyle: GoogleFonts.poppins(
                          color: RidenColors.textHint,
                          fontSize: 15,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureNew
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: RidenColors.textSecondary,
                          ),
                          onPressed: () =>
                              setState(() => _obscureNew = !_obscureNew),
                        ),
                      ),
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: RidenColors.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Confirm Password Field
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Confirm Password",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: RidenColors.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  GlassField(
                    child: TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: _obscureConfirm,
                      decoration: InputDecoration(
                        hintText: "123456789",
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 12,
                        ),
                        hintStyle: GoogleFonts.poppins(
                          color: RidenColors.textHint,
                          fontSize: 15,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirm
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: RidenColors.textSecondary,
                          ),
                          onPressed: () => setState(
                            () => _obscureConfirm = !_obscureConfirm,
                          ),
                        ),
                      ),
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: RidenColors.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Save Button
                  GlassButton(
                    text: "Save",
                    borderRadius: BorderRadius.circular(30),
                    height: 54,
                    textStyle: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    type: GlassButtonType.primary,
                    onTap: () {
                      final newPass = _newPasswordController.text.trim();
                      final confirmPass = _confirmPasswordController.text
                          .trim();
                      if (newPass.isEmpty || confirmPass.isEmpty) {
                        Get.snackbar(
                          "Error",
                          "Please enter both passwords",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                        return;
                      }
                      if (newPass != confirmPass) {
                        Get.snackbar(
                          "Error",
                          "Passwords do not match",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                        return;
                      }
                      // TODO: Save new password (API logic)
                      Get.to(() => const PasswordResetSuccessScreen());
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

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
