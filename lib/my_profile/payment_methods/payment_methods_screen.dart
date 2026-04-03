// payment_methods_bottom_sheet.dart
// ignore_for_file: deprecated_member_use

import 'package:Riden/my_profile/payment_methods/add_new_card_screen.dart';
import 'dart:ui';
import 'package:Riden/widgets/riden_bottom_nav.dart';
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
    Navigator.pop(context);
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
    final screenHeight = MediaQuery.of(context).size.height;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double sheetH = constraints.maxHeight;
        final double sheetW = constraints.maxWidth;

        final double minH = screenHeight * 0.50;
        final double maxH = screenHeight * 1.00;
        final double progress = ((sheetH - minH) / (maxH - minH)).clamp(0.0, 1.0);

        final double cornerRadius = 32.0 * (1.0 - progress);

        return ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(cornerRadius),
            topRight: Radius.circular(cornerRadius),
          ),
          child: SizedBox(
            width: sheetW,
            height: sheetH,
            child: Stack(
              children: [
                // ── 1. Gradient background ──────────────────
                Positioned.fill(
                  child: CustomPaint(painter: _SheetGradientPainter()),
                ),

                // ── 2. Frosted glass blur layer ──
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        border: Border(
                          top: BorderSide(
                            color: Colors.white.withOpacity(0.15),
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // ── 3. Foreground content ──
                Column(
                  children: [
                    // Drag handle
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 8),
                      child: Center(
                        child: Container(
                          width: 45,
                          height: 4.5,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(2.5),
                          ),
                        ),
                      ),
                    ),

                    // Header
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Row(
                              children: [
                                const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18),
                                const SizedBox(width: 6),
                                Text(
                                  'Back',
                                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Your Cards',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 50),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    Expanded(
                      child: SingleChildScrollView(
                        controller: widget.scrollController,
                        physics: const ClampingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            // White box
                            Container(
                              padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.85),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Primary Methods',
                                    style: GoogleFonts.poppins(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
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
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    child: Divider(color: Colors.black26),
                                  ),
                                  Text(
                                    'Other Methods',
                                    style: GoogleFonts.poppins(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
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
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            
                            // Add New button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  elevation: 0,
                                ),
                                onPressed: () => _openAddNewCardSheet(context),
                                child: Text(
                                  'Add New',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 100),
                          ],
                        ),
                      ),
                    ),

                    // Bottom Nav
                    RidenBottomNav(
                      selectedIndex: 3,
                      isFromSheet: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

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
      margin: const EdgeInsets.only(bottom: 8, top: 4),
      child: Row(
        children: [
          Image.asset(logo, width: 40, height: 40),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 14.4,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  number,
                  style: GoogleFonts.poppins(
                    color: Colors.black54,
                    fontSize: 12.7,
                  ),
                ),
              ],
            ),
          ),
          Builder(
            builder: (ctx) => GestureDetector(
              onTap: () => onMenuTap(ctx),
              child: const Icon(
                Icons.more_vert,
                color: Colors.red,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SheetGradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Base: dark navy
    canvas.drawRect(
      Rect.fromLTWH(0, 0, w, h),
      Paint()..color = const Color(0xFF1A1B2E),
    );

    // Warm copper glow — top-left
    _radialBlob(
      canvas,
      center: Offset(w * 0.15, h * 0.30),
      rx: w * 0.80,
      ry: h * 0.60,
      color: const Color(0xFF8B4A35),
      alpha: 170,
    );

    // Teal glow — bottom-right
    _radialBlob(
      canvas,
      center: Offset(w * 0.85, h * 0.75),
      rx: w * 0.80,
      ry: h * 0.60,
      color: const Color(0xFF2E6B72),
      alpha: 170,
    );
  }

  void _radialBlob(
    Canvas canvas, {
    required Offset center,
    required double rx,
    required double ry,
    required Color color,
    required int alpha,
  }) {
    final solid = Color.fromARGB(alpha, color.red, color.green, color.blue);
    final clear = Color.fromARGB(0, color.red, color.green, color.blue);

    final paint = Paint()
      ..shader = RadialGradient(colors: [solid, clear]).createShader(
        Rect.fromCenter(center: center, width: rx * 2, height: ry * 2),
      );

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.scale(1.0, ry / rx);
    canvas.translate(-center.dx, -center.dy);
    canvas.drawCircle(center, rx, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_SheetGradientPainter _) => false;
}
