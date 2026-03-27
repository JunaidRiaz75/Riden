// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'glass_field.dart';
import 'glass_button.dart';

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
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 22),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),

                    // Title
                    Text(
                      'Sign in',
                      style: GoogleFonts.poppins(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Email or Phone
                    Text(
                      'Email or Phone Number',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    GlassField(
                      child: TextFormField(
                        controller: _emailOrPhoneController,
                        decoration: InputDecoration(
                          hintText: "Enter",
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 16,
                          ),
                          hintStyle: GoogleFonts.poppins(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        style: GoogleFonts.poppins(fontSize: 15),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Password
                    Text(
                      'Password',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    GlassField(
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          hintText: "123456789",
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 16,
                          ),
                          hintStyle: GoogleFonts.poppins(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: Colors.black54,
                            ),
                            onPressed: () => setState(
                              () => _obscurePassword = !_obscurePassword,
                            ),
                          ),
                        ),
                        style: GoogleFonts.poppins(fontSize: 15),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {}, // Add your route here
                        child: Text(
                          "Forgot Password?",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),

                    // Glassy pill Sign In Button (matches Sign Up)
                    GlassButton(
                      text: "Sign in",
                      onTap: () {
                        // Add sign-in logic
                      },
                      borderRadius: BorderRadius.circular(30),
                      height: 54,
                      textStyle: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 28),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(color: Colors.black26, thickness: 1),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "or",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(color: Colors.black26, thickness: 1),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // Social buttons
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
                            glassColor: Colors.white.withOpacity(0.17),
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an account? ",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.black87,
                          ),
                          children: [
                            TextSpan(
                              text: "Sign up",
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: Color(0xFFFF161F),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailOrPhoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
