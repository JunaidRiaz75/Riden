// about_us_bottom_sheet.dart - COMPLETE FIXED VERSION
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riden/theme/app_colors.dart';

import 'faqs_bottom_sheet.dart';
import 'legal_bottom_sheet.dart';
import 'terms_conditions_bottom_sheet.dart';

class AboutUsBottomSheet extends StatelessWidget {
  final ScrollController scrollController;

  const AboutUsBottomSheet({required this.scrollController, super.key});

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      {
        'icon': Icons.library_books_rounded,
        'label': "FAQ's",
        'onTap': () => _openFAQBottomSheet(context),
      },
      {
        'icon': Icons.help_outline_rounded,
        'label': "Help",
        'onTap': () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Help section coming soon'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 1),
            ),
          );
        },
      },
      {
        'icon': Icons.gavel_rounded,
        'label': "Legal",
        'onTap': () => _openLegalBottomSheet(context),
      },
      {
        'icon': Icons.menu_book_rounded,
        'label': "Terms & Conditions",
        'onTap': () => _openTermsBottomSheet(context),
      },
    ];

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            RidenColors.backgroundBase.withOpacity(0.98),
            RidenColors.backgroundBase.withOpacity(0.95),
            RidenColors.backgroundBase.withOpacity(0.92),
          ],
          stops: const [0.0, 0.6, 1.0],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 25,
            offset: const Offset(0, -5),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          // Drag Handle
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Center(
              child: Container(
                width: 45,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
            ),
          ),
          // Content - FIXED STRUCTURE
          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    const Text(
                      "About us",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Menu Items
                    ...menuItems.map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: GlassyAboutRow(
                          icon: item['icon'] as IconData,
                          label: item['label'] as String,
                          onTap: item['onTap'] as VoidCallback,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openFAQBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          snap: true,
          snapSizes: const [0.5, 0.85, 0.95],
          builder: (context, scrollController) {
            return FAQsBottomSheet(scrollController: scrollController);
          },
        );
      },
    );
  }

  void _openLegalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          snap: true,
          snapSizes: const [0.5, 0.85, 0.95],
          builder: (context, scrollController) {
            return LegalBottomSheet(scrollController: scrollController);
          },
        );
      },
    );
  }

  void _openTermsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          snap: true,
          snapSizes: const [0.5, 0.85, 0.95],
          builder: (context, scrollController) {
            return TermsConditionsBottomSheet(
              scrollController: scrollController,
            );
          },
        );
      },
    );
  }
}

class GlassyAboutRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const GlassyAboutRow({
    required this.icon,
    required this.label,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.red, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Colors.white54,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
