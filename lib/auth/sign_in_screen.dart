// sign_in_screen.dart
// ignore_for_file: use_super_parameters, deprecated_member_use

import 'dart:ui';

import 'package:Riden/auth/forgot_password_screen.dart';
import 'package:Riden/auth/sign_up_screen.dart';
import 'package:Riden/home/home_screen.dart';
import 'package:Riden/theme/app_colors.dart';
import 'package:Riden/widgets/glass_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailOrPhoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailOrPhoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ── RidenDarkBackground — unchanged ──────────────────────────
          const RidenDarkBackground(),

          SafeArea(
            child: Column(
              children: [
                // ── Back button ──────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 4),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.maybePop(context),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.chevron_left,
                              color: Colors.white, size: 22),
                          Text(
                            'Back',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // ── Scrollable body ──────────────────────────────────────
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 10),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 14),

                          // Title
                          Text(
                            'Sign in',
                            style: GoogleFonts.poppins(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 0.2,
                            ),
                          ),
                          const SizedBox(height: 28),

                          // ── Email / Phone ────────────────────────────────
                          _FieldLabel('Email or Phone Number'),
                          const SizedBox(height: 8),

                          // GlassField wraps the TextFormField — same widget
                          // used in sign_up_screen for consistency
                          GlassField(
                            height: 56,
                            child: TextFormField(
                              controller: _emailOrPhoneController,
                              keyboardType: TextInputType.emailAddress,
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Enter',
                                hintStyle: GoogleFonts.poppins(
                                  color: Colors.white38,
                                  fontSize: 15,
                                ),
                                border: InputBorder.none,
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // ── Password ─────────────────────────────────────
                          _FieldLabel('Password'),
                          const SizedBox(height: 8),

                          GlassField(
                            height: 56,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _passwordController,
                                    obscureText: _obscurePassword,
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: '123456789',
                                      hintStyle: GoogleFonts.poppins(
                                        color: Colors.white38,
                                        fontSize: 15,
                                      ),
                                      border: InputBorder.none,
                                      contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 0),
                                    ),
                                  ),
                                ),
                                // Visibility toggle — sits inside GlassField
                                GestureDetector(
                                  onTap: () => setState(
                                      () => _obscurePassword = !_obscurePassword),
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 4),
                                    child: Icon(
                                      _obscurePassword
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      color: Colors.white60,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),

                          // ── Forgot password ──────────────────────────────
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () =>
                                  Get.to(() => const ForgotPasswordScreen()),
                              child: Text(
                                'Forget Password?',
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 26),

                          // ── Sign In button ───────────────────────────────
                          _SignInButton(
                            onTap: () => Get.offAll(() => const HomeScreen()),
                          ),
                          const SizedBox(height: 28),

                          // ── Divider ──────────────────────────────────────
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: Colors.white.withOpacity(0.20),
                                  thickness: 1,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  'or',
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    color: Colors.white54,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: Colors.white.withOpacity(0.20),
                                  thickness: 1,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 22),

                          // ── Social icon buttons ──────────────────────────
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Google button
                              GestureDetector(
                                onTap: () {
                                  // Google sign‑in logic
                                },
                                child: const GlassContainer(
                                  width: 60,
                                  height: 60,
                                  borderRadius: 8,
                                  child: Center(
                                    child: Image(
                                      image: AssetImage('assets/icons/google.png'),
                                      width: 30,
                                      height: 30,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 18),
                              // Facebook button
                              GestureDetector(
                                onTap: () {
                                  // Facebook sign‑in logic
                                },
                                child: const GlassContainer(
                                  width: 60,
                                  height: 60,
                                  borderRadius: 8,
                                  child: Center(
                                    child: Image(
                                      image: AssetImage('assets/icons/facebook.png'),
                                      width: 30,
                                      height: 30,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),

                          // ── Sign up link ─────────────────────────────────
                          Center(
                            child: RichText(
                              text: TextSpan(
                                text: "Don't have an account? ",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Sign up',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () =>
                                          Get.to(() => const SignUpScreen()),
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: const Color(0xFFE53935),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
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

// ─────────────────────────────────────────────────────────────────────────────
// FIELD LABEL
// ─────────────────────────────────────────────────────────────────────────────
class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SIGN IN BUTTON  — red gradient pill, full width
// ─────────────────────────────────────────────────────────────────────────────
class _SignInButton extends StatelessWidget {
  final VoidCallback onTap;
  const _SignInButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 54,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFE53935), Color(0xFFFF5252)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFE53935).withOpacity(0.40),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Center(
          child: Text(
            'Sign in',
            style: GoogleFonts.poppins(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ),
    );
  }
}
