import 'package:Riden/auth/sign_up_screen.dart';
import 'package:Riden/theme/app_colors.dart';
import 'package:Riden/theme/theme_controller.dart';
import 'package:Riden/widgets/glass_button.dart';
import 'package:Riden/widgets/glassmorphic_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
// for RidenDarkBackground

class SignUpChoiceScreen extends StatelessWidget {
  SignUpChoiceScreen({super.key});

  final ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = themeController.isDark;
      return Scaffold(
        body: Stack(
          children: [
            const RidenDarkBackground(),
            // Vignette overlay
            Positioned.fill(
              child: IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: const Alignment(0.0, -0.15),
                      radius: 1.1,
                      colors: isDark
                          ? const [Color(0x0011172B), Color(0xB30A1024)]
                          : const [Color(0x00FFFFFF), Color(0x22000000)],
                      stops: const [0.55, 1.0],
                    ),
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Center(
                    child: SizedBox(
                      height: 208,
                      width: 310,
                      child: Image.asset(
                        isDark
                            ? 'assets/images/signup_dark.png'
                            : 'assets/images/signup.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 90),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        _SignUpIconButton(
                          asset: 'assets/images/email.png',
                          text: 'Sign up with email',
                          onTap: () {
                            Get.to(() => const SignUpScreen());
                          },
                        ),
                        const SizedBox(height: 16),
                        _SignUpIconButton(
                          asset: 'assets/images/google.png',
                          text: 'Sign up with Google',
                          onTap: () {
                            Get.to(() => const SignUpScreen());
                          },
                        ),
                        const SizedBox(height: 16),
                        _SignUpIconButton(
                          asset: 'assets/images/facebook.png',
                          text: 'Sign up with Facebook',
                          onTap: () {
                            Get.to(() => const SignUpScreen());
                          },
                        ),
                        const SizedBox(height: 16),
                        _SignUpIconButton(
                          asset: 'assets/images/apple.png',
                          text: 'Sign up with Apple',
                          onTap: () {
                            Get.to(() => const SignUpScreen());
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _SignUpIconButton extends StatelessWidget {
  final String asset;
  final String text;
  final VoidCallback onTap;

  const _SignUpIconButton({
    required this.asset,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Make sure the full area including the glassmorphic background is tappable!
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: GlassmorphicButton(
          leading: Image.asset(asset, width: 24, height: 24),
          text: text,
          textStyle: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
          glassColor: Colors.white.withOpacity(0.08),
          type: GlassButtonType.primary,
        ),
      ),
    );
  }
}
