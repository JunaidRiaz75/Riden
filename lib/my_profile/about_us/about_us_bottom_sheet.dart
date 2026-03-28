// about_us_bottom_sheet.dart
// ignore_for_file: deprecated_member_use

import 'package:Riden/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(28),
        topRight: Radius.circular(28),
      ),
      child: Stack(
        children: [
          // ── Same dark gradient as Splash ──────────────────
          const Positioned.fill(child: RidenDarkBackground()),

          // ── Sheet content ─────────────────────────────────
          Column(
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
              // Content
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
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Text(
                              'About Us',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
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
        ],
      ),
    );
  }

  void _openSheet(
    BuildContext context,
    Widget Function(ScrollController) builder,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        snap: true,
        snapSizes: const [0.5, 0.85, 0.95],
        builder: (context, sc) => builder(sc),
      ),
    );
  }

  void _openFAQBottomSheet(BuildContext context) =>
      _openSheet(context, (sc) => FAQsBottomSheet(scrollController: sc));

  void _openLegalBottomSheet(BuildContext context) =>
      _openSheet(context, (sc) => LegalBottomSheet(scrollController: sc));

  void _openTermsBottomSheet(BuildContext context) => _openSheet(
    context,
    (sc) => TermsConditionsBottomSheet(scrollController: sc),
  );
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
