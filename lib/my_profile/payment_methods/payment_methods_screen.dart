// payment_methods_bottom_sheet.dart
// ignore_for_file: deprecated_member_use

import 'package:Riden/my_profile/payment_methods/add_new_card_screen.dart';
import 'package:Riden/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentMethodsBottomSheet extends StatefulWidget {
  final ScrollController scrollController;

  const PaymentMethodsBottomSheet({required this.scrollController, super.key});

  @override
  State<PaymentMethodsBottomSheet> createState() =>
      _PaymentMethodsBottomSheetState();
}

class _PaymentMethodsBottomSheetState extends State<PaymentMethodsBottomSheet> {
  final List<Map<String, dynamic>> primaryMethods = [
    {
      'logo': 'assets/images/visa_logo.png',
      'name': 'Visa',
      'number': '******234',
    },
    {
      'logo': 'assets/images/applepay_logo.png',
      'name': 'Apple Pay',
      'number': '******234',
    },
  ];
  final List<Map<String, dynamic>> otherMethods = [
    {
      'logo': 'assets/images/master_logo.png',
      'name': 'Master card',
      'number': '******234',
    },
  ];

  Future<String?> _showEditDeletePopup(
    BuildContext context,
    Offset offset,
  ) async {
    final double screenWidth = MediaQuery.of(context).size.width;
    const double popupWidth = 110;
    double left = offset.dx;
    if (left + popupWidth > screenWidth) left = screenWidth - popupWidth - 10;

    return await Get.dialog<String>(
      Stack(
        children: [
          Positioned(
            left: left,
            top: offset.dy,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: popupWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.22),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      onTap: () => Get.back(result: 'edit'),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        alignment: Alignment.center,
                        child: Text(
                          'Edit',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.5,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(12),
                      ),
                      onTap: () => Get.back(result: 'delete'),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(12),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        alignment: Alignment.center,
                        child: Text(
                          'Delete',
                          style: GoogleFonts.poppins(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      barrierColor: Colors.transparent,
    );
  }

  void _onCardMenuTap(BuildContext context, int section, int idx) async {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset offset = box.localToGlobal(Offset.zero);
    final result = await _showEditDeletePopup(
      context,
      Offset(offset.dx + 46, offset.dy + 46),
    );
    if (result == 'edit') {
      // Edit logic here
    } else if (result == 'delete') {
      setState(() {
        if (section == 0) {
          primaryMethods.removeAt(idx);
        } else {
          otherMethods.removeAt(idx);
        }
      });
    }
  }

  void _openAddNewCardSheet(BuildContext context) {
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
        builder: (context, sc) => AddNewCardBottomSheet(scrollController: sc),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(28),
        topRight: Radius.circular(28),
      ),
      child: Stack(
        children: [
          // ── Dark gradient background ──────────────────────
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
              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  controller: widget.scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
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
                            'Your Cards',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),

                      // Primary Methods
                      Text(
                        'Primary Methods',
                        style: GoogleFonts.poppins(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...List.generate(primaryMethods.length, (idx) {
                        return PaymentCardRow(
                          logo: primaryMethods[idx]['logo'],
                          name: primaryMethods[idx]['name'],
                          number: primaryMethods[idx]['number'],
                          onMenuTap: (ctx) => _onCardMenuTap(ctx, 0, idx),
                        );
                      }),
                      const SizedBox(height: 22),

                      // Other Methods
                      Text(
                        'Other Methods',
                        style: GoogleFonts.poppins(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...List.generate(otherMethods.length, (idx) {
                        return PaymentCardRow(
                          logo: otherMethods[idx]['logo'],
                          name: otherMethods[idx]['name'],
                          number: otherMethods[idx]['number'],
                          onMenuTap: (ctx) => _onCardMenuTap(ctx, 1, idx),
                        );
                      }),
                      const SizedBox(height: 26),

                      // Add New button
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.15),
                          foregroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                        ),
                        icon: const Icon(Icons.add, color: Colors.red),
                        label: Text(
                          'Add New',
                          style: GoogleFonts.poppins(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.5,
                          ),
                        ),
                        onPressed: () => _openAddNewCardSheet(context),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── PaymentCardRow (unchanged widget, kept here for self-containment) ──

class PaymentCardRow extends StatelessWidget {
  final String logo;
  final String name;
  final String number;
  final void Function(BuildContext context) onMenuTap;

  const PaymentCardRow({
    required this.logo,
    required this.name,
    required this.number,
    required this.onMenuTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.19),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Image.asset(logo, width: 33, height: 33),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14.4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  number,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 12.7,
                  ),
                ),
              ],
            ),
          ),
          Builder(
            builder: (ctx) => IconButton(
              splashRadius: 20,
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white70,
                size: 22,
              ),
              onPressed: () => onMenuTap(ctx),
            ),
          ),
        ],
      ),
    );
  }
}
