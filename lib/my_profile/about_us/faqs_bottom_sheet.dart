// faqs_bottom_sheet.dart
// ignore_for_file: deprecated_member_use

import 'package:Riden/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Riden/widgets/riden_bottom_nav.dart';

class FAQsBottomSheet extends StatefulWidget {
  final ScrollController scrollController;

  const FAQsBottomSheet({required this.scrollController, super.key});

  @override
  State<FAQsBottomSheet> createState() => _FAQsBottomSheetState();
}

class _FAQsBottomSheetState extends State<FAQsBottomSheet> {
  int? expandedIndex;

  final List<Map<String, String>> faqs = [
    {
      'question': 'How do I book a ride?',
      'answer':
          'You can book a ride by entering your pickup location and destination in the search fields at the bottom of the home screen.',
    },
    {
      'question': 'How do I cancel my ride?',
      'answer':
          'You can cancel your ride from the ride details screen by tapping the "Cancel Ride" button.',
    },
    {
      'question': 'How do I add a payment method?',
      'answer':
          'Go to Profile > Payment Methods to add or manage your payment methods.',
    },
    {
      'question': 'How do I contact support?',
      'answer':
          'You can contact support from Profile > Contact Support section.',
    },
    {
      'question': 'How do I change my password?',
      'answer':
          'Go to Profile > App Settings > Change Password to update your password.',
    },
  ];

  @override
  Widget build(BuildContext context) {
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
                  controller: widget.scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header with Back Button
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
                            const SizedBox(width: 12),
                            Text(
                              "FAQ'S",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // FAQ List
                        ...List.generate(faqs.length, (index) {
                          final isExpanded = expandedIndex == index;
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(
                                isExpanded ? 0.15 : 0.08,
                              ),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isExpanded
                                    ? Colors.red
                                    : Colors.white.withOpacity(0.15),
                                width: isExpanded ? 1.5 : 1,
                              ),
                            ),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      expandedIndex = isExpanded ? null : index;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 14,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "Q: ${faqs[index]['question']}",
                                            style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          isExpanded
                                              ? Icons.keyboard_arrow_up_rounded
                                              : Icons
                                                    .keyboard_arrow_down_rounded,
                                          color: Colors.white,
                                          size: 22,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (isExpanded)
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                      16,
                                      0,
                                      16,
                                      16,
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        faqs[index]['answer']!,
                                        style: GoogleFonts.poppins(
                                          color: Colors.white70,
                                          fontSize: 13,
                                          height: 1.4,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        }),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // ── Standardized Bottom Nav ──
          Align(
            alignment: Alignment.bottomCenter,
            child: RidenBottomNav(selectedIndex: 1, isFromSheet: true),
          ),
        ],
      ),
    );
  }
}
