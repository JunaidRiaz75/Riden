// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'glass_field.dart';
import 'glass_button.dart';
import 'package:riden/auth/sign_in_screen.dart';

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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF9F6F5),
              Color(0xFFECC9B3),
              Color(0xFFD6DFDF),
              Color(0xFFA7C5C9),
              Color(0xFFE1F3F5),
            ],
            stops: [0.0, 0.23, 0.52, 0.73, 1.0],
          ),
        ),
        child: SafeArea(
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
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Name
                  const Text(
                    'Name*',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 6),
                  GlassField(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Jimmi",
                        border: InputBorder.none,
                        hintStyle: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Email
                  const Text(
                    'Email*',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 6),
                  GlassField(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "example@gmail.com",
                        border: InputBorder.none,
                        hintStyle: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Phone Number (with flag)
                  const Text(
                    'Phone Number*',
                    style: TextStyle(fontWeight: FontWeight.w500),
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
                        const Text(
                          "+1",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
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
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                            keyboardType: TextInputType.phone,
                            style: GoogleFonts.poppins(fontSize: 15),
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Gender dropdown
                  const Text(
                    'Gender*',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 6),
                  GlassField(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedGender,
                        items: _genders
                            .map(
                              (g) => DropdownMenuItem(
                                value: g,
                                child: Text(
                                  g,
                                  style: GoogleFonts.poppins(fontSize: 17),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (g) => setState(() => _selectedGender = g!),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                          size: 28,
                        ),
                        isExpanded: true,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Password
                  const Text(
                    'Password*',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 6),
                  GlassField(
                    child: TextFormField(
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        hintText: "123456789",
                        border: InputBorder.none,
                        hintStyle: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                          onPressed: () => setState(
                            () => _obscurePassword = !_obscurePassword,
                          ),
                        ),
                      ),
                      style: GoogleFonts.poppins(fontSize: 15),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Confirm Password
                  const Text(
                    'Confirm Password*',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 6),
                  GlassField(
                    child: TextFormField(
                      obscureText: _obscureConfirm,
                      decoration: InputDecoration(
                        hintText: "123456789",
                        border: InputBorder.none,
                        hintStyle: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirm
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                          onPressed: () => setState(
                            () => _obscureConfirm = !_obscureConfirm,
                          ),
                        ),
                      ),
                      style: GoogleFonts.poppins(fontSize: 15),
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
                        activeColor: const Color(0xFFFF161F),
                        visualDensity: VisualDensity.compact,
                      ),
                      const Text('Keep me logged in'),
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
                          color: Colors.black87,
                          fontSize: 13,
                        ),
                        children: [
                          TextSpan(
                            text: "Terms of service",
                            style: GoogleFonts.poppins(
                              color: Color(0xFFFF161F),
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                          TextSpan(
                            text: " and ",
                            style: GoogleFonts.poppins(
                              color: Colors.black87,
                              fontSize: 13,
                            ),
                          ),
                          TextSpan(
                            text: "Privacy policy.",
                            style: GoogleFonts.poppins(
                              color: Color(0xFFFF161F),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),

                  // Sign up button glassy - RED
                  Container(
                    width: double.infinity,
                    height: 54,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(
                        0xFFFF161F,
                      ).withOpacity(0.71), // your picker color + 71% opacity!
                      borderRadius: BorderRadius.circular(30), // pill shape
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const SignInScreen(),
                                ),
                              );
                            },
                            child: Center(
                              child: Text(
                                'Sign in',
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                                softWrap: true,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Or divider
                  Row(
                    children: const [
                      Expanded(child: Divider(color: Colors.black26)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text("or"),
                      ),
                      Expanded(child: Divider(color: Colors.black26)),
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
                          glassColor: Colors.white.withOpacity(0.17),
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
                          glassColor: Colors.white.withOpacity(0.10),
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
                        style: GoogleFonts.poppins(color: Colors.black87),
                        children: [
                          TextSpan(
                            text: "Sign in",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: Color(0xFFFF161F),
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
      ),
    );
  }
}
