import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riden/auth/sign_up_screen.dart';
import 'glassmorphic_button.dart'; // Import the new button

class SignUpChoiceScreen extends StatelessWidget {
  const SignUpChoiceScreen({super.key});

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
              Color(0xFFF9F6F5), // soft warm white (top)
              Color(0xFFECC9B3), // peach (top-mid)
              Color(0xFFD6DFDF), // very pale blue/gray (mid)
              Color(0xFFA7C5C9), // blueish (bottom-mid)
              Color(0xFFE1F3F5), // lighter bottom blue/white
            ],
            stops: [0.0, 0.23, 0.52, 0.73, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Center(
                child: SizedBox(
                  height: 208,
                  width: 310,
                  child: Image.asset(
                    'assets/images/signup.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 90),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    GlassmorphicButton(
                      asset: "assets/images/email.png",
                      text: "Sign up with email",
                      textStyle: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Color(0xFF141414),
                        fontWeight: FontWeight.w400,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SignUpScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    GlassmorphicButton(
                      asset: "assets/images/google.png",
                      text: "Sign up with Google",
                      textStyle: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Color(0xFF141414),
                        fontWeight: FontWeight.w400,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SignUpScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    GlassmorphicButton(
                      asset: "assets/images/facebook.png",
                      text: "Sign up with Facebook",
                      textStyle: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Color(0xFF141414),
                        fontWeight: FontWeight.w400,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SignUpScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    GlassmorphicButton(
                      asset: "assets/images/apple.png",
                      text: "Sign up with Apple",
                      textStyle: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Color(0xFF141414),
                        fontWeight: FontWeight.w400,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SignUpScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
