import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riden/auth/forgot_password_screen.dart';
import 'package:riden/auth/sign_up_screen.dart';
import 'package:riden/home/home_screen.dart';
import 'package:riden/theme/app_colors.dart';
import 'package:riden/widgets/glass_button.dart';
import 'package:riden/widgets/glass_field.dart';
// If you use a splash-style background widget:

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
      body: Stack(
        children: [
          const RidenDarkBackground(), // <--- Main dark gradient background
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 22,
                ),
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
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 28),
                      // Email or Phone
                      Text(
                        'Email or Phone Number',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      GlassField(
                        child: TextFormField(
                          controller: _emailOrPhoneController,
                          decoration: InputDecoration(
                            hintText: "Enter your phone number",
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 18,
                              horizontal: 16,
                            ),
                            hintStyle: GoogleFonts.poppins(
                              color: Colors.white70,
                              fontSize: 15,
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      // Password
                      Text(
                        'Password',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      GlassField(
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            hintText: "Enter your password",
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 18,
                              horizontal: 16,
                            ),
                            hintStyle: GoogleFonts.poppins(
                              color: Colors.white70,
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
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => const ForgotPasswordScreen());
                          },
                          child: Text(
                            "Forgot Password?",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.white,
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
                          Get.offAll(() => const HomeScreen());
                        },
                        borderRadius: BorderRadius.circular(30),
                        height: 54,
                        textStyle: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                        type: GlassButtonType.primary,
                      ),

                      const SizedBox(height: 28),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(color: Colors.white24, thickness: 1),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              "or",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(color: Colors.white24, thickness: 1),
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
                              iconColor: Colors.white,
                              text: "",
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
                              iconColor: Colors.white,
                              text: "",
                              type: GlassButtonType.secondary,
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
                              color: Colors.white,
                            ),
                            children: [
                              TextSpan(
                                text: "Sign up",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.to(() => const SignUpScreen());
                                  },
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: Colors.red[400],
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
        ],
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
