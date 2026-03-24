import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:riden/theme/app_colors.dart'; // For RidenDarkBackground
import 'package:riden/my_profile/about_us/faqs_screen.dart';
import 'package:riden/my_profile/about_us/legal_screen.dart';
import 'package:riden/my_profile/about_us/terms_conditions_screen.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      {
        'icon': Icons.library_books_rounded,
        'label': "FAQ's",
        'onTap': () {
          Get.to(() => FAQsScreen());
        },
      },
      {
        'icon': Icons.help_outline_rounded,
        'label': "Help",
        'onTap': () {
          
        },
      },
      {
        'icon': Icons.gavel_rounded,
        'label': "Legal",
        'onTap': () {
          Get.to(() => LegalScreen());
        },
      },
      {
        'icon': Icons.menu_book_rounded,
        'label': "Terms & Conditions",
        'onTap': () {
          Get.to(() => TermsConditionsScreen());
        },
      },
    ];

    return Scaffold(
      body: Stack(
        children: [
          const RidenDarkBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    "About us",
                    style: GoogleFonts.audiowide(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.7,
                    ),
                  ),
                  const SizedBox(height: 28),
                  ...menuItems.map((item) => GlassyAboutRow(
                    icon: item['icon'] as IconData,
                    label: item['label'] as String,
                    onTap: item['onTap'] as VoidCallback,
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


/// Glassy row for About Us menu
class GlassyAboutRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const GlassyAboutRow({
    required this.icon,
    required this.label,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.11),
        borderRadius: BorderRadius.circular(13),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        leading: Icon(icon, color: Colors.red, size: 28),
        title: Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 15.3,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(Icons.chevron_right_rounded,
            color: Colors.white, size: 27),
        onTap: onTap,
      ),
    );
  }
}