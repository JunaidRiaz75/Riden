// ignore_for_file: deprecated_member_use

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riden/auth/sign_in_screen.dart';
import 'package:riden/theme/app_colors.dart';
import 'package:riden/widgets/glass_button.dart';
import 'package:riden/widgets/glass_field.dart';
// Import your Splash gradient widget, assuming this exists:

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _keepLoggedIn = false;
  String _selectedGender = 'Male';
  final List<String> _genders = ['Male', 'Female', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // --- Use your splash dark gradient background ---
          const RidenDarkBackground(),
          // Optionally a vignette or dark overlay for extra depth. Uncomment if needed.
          // Positioned.fill(
          //   child: DecoratedBox(
          //     decoration: BoxDecoration(
          //       gradient: RadialGradient(
          //         center: const Alignment(0.0, -0.15),
          //         radius: 1.1,
          //         colors: const [Color(0x0011172B), Color(0xB30A1024)],
          //         stops: const [0.55, 1.0],
          //       ),
          //     ),
          //   ),
          // ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      'Sign up',
                      style: GoogleFonts.poppins(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Name
                    Text(
                      'Name*',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    GlassField(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Enter your name",
                          border: InputBorder.none,
                          hintStyle: GoogleFonts.poppins(
                            color: Colors.white54,
                            fontSize: 15,
                          ),
                        ),
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    // Email
                    Text(
                      'Email*',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    GlassField(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Enter your email",
                          border: InputBorder.none,
                          hintStyle: GoogleFonts.poppins(
                            color: Colors.white54,
                            fontSize: 15,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    // Phone Number with flag
                    Text(
                      'Phone Number*',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    GlassField(
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            margin: const EdgeInsets.only(left: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.asset(
                              "assets/images/canada_flag.png",
                              width: 28,
                              height: 28,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "+1",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: "00000000",
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                hintStyle: GoogleFonts.poppins(
                                  color: Colors.white54,
                                  fontSize: 15,
                                ),
                              ),
                              keyboardType: TextInputType.phone,
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    // Gender dropdown
                    Text(
                      'Gender*',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    GlassField(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedGender,
                          dropdownColor: const Color(0xFF23232F), // dark menu
                          items: _genders
                              .map(
                                (g) => DropdownMenuItem(
                                  value: g,
                                  child: Text(
                                    g,
                                    style: GoogleFonts.poppins(
                                      fontSize: 17,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (g) =>
                              setState(() => _selectedGender = g!),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                            size: 28,
                          ),
                          isExpanded: true,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    // Password
                    Text(
                      'Password*',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    GlassField(
                      child: TextFormField(
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          hintText: "Enter your password",
                          border: InputBorder.none,
                          hintStyle: GoogleFonts.poppins(
                            color: Colors.white54,
                            fontSize: 15,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: Colors.white,
                            ),
                            onPressed: () => setState(
                              () => _obscurePassword = !_obscurePassword,
                            ),
                          ),
                        ),
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    // Confirm Password
                    Text(
                      'Confirm Password*',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    GlassField(
                      child: TextFormField(
                        obscureText: _obscureConfirm,
                        decoration: InputDecoration(
                          hintText: "Enter your confirm password",
                          border: InputBorder.none,
                          hintStyle: GoogleFonts.poppins(
                            color: Colors.white54,
                            fontSize: 15,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirm
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: Colors.white,
                            ),
                            onPressed: () => setState(
                              () => _obscureConfirm = !_obscureConfirm,
                            ),
                          ),
                        ),
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Keep me logged in
                    Row(
                      children: [
                        Checkbox(
                          value: _keepLoggedIn,
                          onChanged: (val) =>
                              setState(() => _keepLoggedIn = val ?? false),
                          checkColor: Colors.white,
                          activeColor: Colors.red[700],
                          fillColor: MaterialStateProperty.all(Colors.red[700]),
                          side: const BorderSide(color: Colors.white54),
                          visualDensity: VisualDensity.compact,
                        ),
                        Text(
                          'Keep me logged in',
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Terms
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: RichText(
                        text: TextSpan(
                          text: "By signing up, you agree to the ",
                          style: GoogleFonts.poppins(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                          children: [
                            TextSpan(
                              text: "Terms of service",
                              style: GoogleFonts.poppins(
                                color: Colors.red[400],
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                            ),
                            TextSpan(
                              text: " and ",
                              style: GoogleFonts.poppins(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                            TextSpan(
                              text: "Privacy policy.",
                              style: GoogleFonts.poppins(
                                color: Colors.red[400],
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    // Sign in button glassy - RED
                    GlassButton(
                      text: "Sign up",
                      onTap: () {
                        Get.to(() => const SignInScreen());
                      },
                      borderRadius: BorderRadius.circular(30),
                      height: 54,
                      textStyle: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      width: double.infinity,
                      type: GlassButtonType.primary,
                    ),
                    const SizedBox(height: 18),
                    // Or divider
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.white24)),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "or",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.white24)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Social & phone glassy buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: GlassButton(
                            borderRadius: BorderRadius.circular(8),
                            icon: Icons.email,
                            text: "",
                            iconColor: Colors.white,
                            type: GlassButtonType.secondary,
                            onTap: () {},
                          ),
                        ),
                        const SizedBox(width: 18),
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: GlassButton(
                            borderRadius: BorderRadius.circular(8),
                            icon: Icons.phone,
                            text: "",
                            iconColor: Colors.white,
                            type: GlassButtonType.secondary,
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    // Already have account
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Already have an account? ",
                          style: GoogleFonts.poppins(color: Colors.white),
                          children: [
                            TextSpan(
                              text: "Sign in",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.to(() => const SignInScreen());
                                },
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: Colors.red[400],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
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
