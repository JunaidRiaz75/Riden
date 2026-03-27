// ignore_for_file: deprecated_member_use

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riden/auth/sign_in_screen.dart';
import 'package:riden/theme/app_colors.dart';
import 'package:riden/widgets/glass_button.dart';
import 'package:riden/widgets/glass_field.dart';

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

  // Country code dropdown data
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
          const RidenDarkBackground(),
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
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          hintText: "Enter your name",
                          border: InputBorder.none,
                          hintStyle: GoogleFonts.poppins(
                            color: Colors.white54,
                            fontSize: 15,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 12,
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
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          hintText: "Enter your email",
                          border: InputBorder.none,
                          hintStyle: GoogleFonts.poppins(
                            color: Colors.white54,
                            fontSize: 15,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 12,
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

                    // Phone Number with country code dropdown
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
                                color: Colors.white,
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
                          Container(
                            width: 1,
                            height: 28,
                            color: Colors.white24,
                          ),
                          const SizedBox(width: 8),
                          // Phone number input
                          Expanded(
                            child: TextFormField(
                              textAlign: TextAlign.start,
                              decoration: InputDecoration(
                                hintText: "Phone number",
                                border: InputBorder.none,
                                hintStyle: GoogleFonts.poppins(
                                  color: Colors.white54,
                                  fontSize: 15,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                  horizontal: 8,
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
                          dropdownColor: const Color(0xFF2a2a3a),
                          items: _genders
                              .map(
                                (g) => DropdownMenuItem(
                                  value: g,
                                  child: Text(
                                    g,
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
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
                        textAlign: TextAlign.start,
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
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 12,
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
                        textAlign: TextAlign.start,
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
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 12,
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

                    // Sign up button
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

                    // Google & Facebook buttons (replacing email & phone)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Google button
                        GestureDetector(
                          onTap: () {
                            // Google sign‑in logic
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.11),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.white12,
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/icons/google.png',
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
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.11),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.white12,
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/icons/facebook.png',
                                width: 30,
                                height: 30,
                              ),
                            ),
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
