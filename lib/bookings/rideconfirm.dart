// rideconfirm.dart
// ignore_for_file: unused_element_parameter, use_super_parameters, deprecated_member_use

import 'dart:ui';

import 'package:Riden/bookings/bookingride_loading.dart';
import 'package:Riden/widgets/riden_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─────────────────────────────────────────────────────────────────────────────
// RIDE CONFIRM SCREEN  —  Simple screen with bottom sheet
// ─────────────────────────────────────────────────────────────────────────────
class RideconfirmScreen extends StatefulWidget {
  final ScrollController scrollController;
  final String selectedCar;

  const RideconfirmScreen({
    super.key,
    required this.scrollController,
    required this.selectedCar,
  });

  @override
  State<RideconfirmScreen> createState() => _RideconfirmScreenState();
}

// ─────────────────────────────────────────────────────────────────────────────
// CONFIRM BOTTOM SHEET
// ─────────────────────────────────────────────────────────────────────────────
class _RideconfirmScreenState extends State<RideconfirmScreen> {
  String selectedPaymentMethod = 'Wallet';

  static const _darkInk = Color(0xFF1A1B2E);
  static const _accentRed = Color(0xFFE53935);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double sheetH = constraints.maxHeight;
        final double sheetW = constraints.maxWidth;
        final double minH = screenHeight * 0.50;
        final double maxH = screenHeight * 1.00;
        final double progress = ((sheetH - minH) / (maxH - minH)).clamp(
          0.0,
          1.0,
        );
        final double cornerRadius = 28.0 * (1.0 - progress);

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
                // ── 1. Gradient background ──────────────────────────────────
                Positioned.fill(
                  child: CustomPaint(painter: _SheetGradientPainter()),
                ),

                // ── 2. Frosted glass blur ───────────────────────────────────
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.06),
                        border: Border(
                          top: BorderSide(
                            color: Colors.white.withOpacity(0.18),
                            width: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // ── 3. Content ──────────────────────────────────────────────
                Column(
                  children: [
                    // Drag handle
                    AnimatedOpacity(
                      opacity: (1.0 - progress).clamp(0.0, 1.0),
                      duration: const Duration(milliseconds: 150),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 2),
                        child: Center(
                          child: Container(
                            width: 40,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.35),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Expanded(
                      child: SingleChildScrollView(
                        controller: widget.scrollController,
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                        child: Column(
                          children: [
                            // Consolidated route card
                            _WhiteGlassCard(
                              padding: const EdgeInsets.fromLTRB(0, 12, 14, 12),
                              child: Column(
                                children: [
                                  _routeRow(
                                    icon: Image.asset(
                                      'assets/images/pickup.png',
                                      width: 30,
                                      height: 30,
                                    ),
                                    label: 'Pickup',
                                    address:
                                        '2972 Westheimer Rd. Santa Ana, Illinois 85486',
                                  ),
                                  // Grey connector line
                                  Padding(
                                    padding: const EdgeInsets.only(left: 45),
                                    child: Divider(
                                      color: _darkInk.withOpacity(0.04),
                                      height: 1,
                                    ),
                                  ),
                                  _routeRow(
                                    icon: Image.asset(
                                      'assets/images/destination.png',
                                      width: 30,
                                      height: 30,
                                    ),
                                    label: 'Destination',
                                    address:
                                        '1901 Thornridge Cir. Shiloh, Hawaii 81603',
                                    trailing: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _darkInk.withOpacity(0.50),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        'Stops',
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Selected car row (simpler, matches mockup)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 14,
                                horizontal: 4,
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/car.png',
                                    width: 100,
                                    height: 54,
                                    fit: BoxFit.contain,
                                    errorBuilder: (_, _, _) => const Icon(
                                      Icons.directions_car,
                                      size: 50,
                                      color: Colors.white54,
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.selectedCar,
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.schedule,
                                              size: 12,
                                              color: Colors.white.withOpacity(
                                                0.50,
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              '3-4 min',
                                              style: GoogleFonts.poppins(
                                                fontSize: 11,
                                                color: Colors.white.withOpacity(
                                                  0.60,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          'Sedan with AC',
                                          style: GoogleFonts.poppins(
                                            fontSize: 11,
                                            color: Colors.white.withOpacity(
                                              0.45,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    'C\$ 70.00',
                                    style: GoogleFonts.poppins(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),

                            // Coupon field
                            _GlassOutlineField(
                              icon: Icons.local_offer_outlined,
                              label: 'Apply Coupon Code (Optional)',
                            ),
                            const SizedBox(height: 10),

                            // Payment Dropdown
                            _PaymentDropdown(
                              value: selectedPaymentMethod,
                              onChanged: (value) {
                                setState(() {
                                  selectedPaymentMethod = value!;
                                });
                              },
                            ),
                            const SizedBox(height: 20),

                            GestureDetector(
                              onTap: () {
                                Navigator.pop(
                                  context,
                                ); // Close current confirm sheet

                                // Open loading sheet
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  barrierColor: Colors.black54,
                                  builder: (_) =>
                                      const BookingLoadingBottomSheetEntry(),
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                height: 52,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFE53935),
                                      Color(0xFFFF5252),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: _accentRed.withOpacity(0.35),
                                      blurRadius: 14,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    'Request',
                                    style: GoogleFonts.poppins(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ),

                    // Bottom nav (standardized)
                    RidenBottomNav(selectedIndex: 0),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _routeRow({
    required Widget icon,
    required String label,
    required String address,
    Widget? trailing,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: Row(
        children: [
          SizedBox(width: 32, height: 32, child: Center(child: icon)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: _darkInk.withOpacity(0.50),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  address,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: _darkInk,
                  ),
                ),
              ],
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PAYMENT DROPDOWN WIDGET
// ─────────────────────────────────────────────────────────────────────────────
class _PaymentDropdown extends StatelessWidget {
  final String value;
  final ValueChanged<String?> onChanged;

  const _PaymentDropdown({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.10),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withOpacity(0.30), width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.white,
            size: 20,
          ),
          dropdownColor: const Color(0xFF2A2D3E),
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.white.withOpacity(0.85),
            fontWeight: FontWeight.w500,
          ),
          selectedItemBuilder: (BuildContext context) {
            return const ['Wallet', 'Debit/Credit Card'].map<Widget>((
              String item,
            ) {
              return Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Payment via $item',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.85),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList();
          },
          isExpanded: true,
          items: const [
            DropdownMenuItem(
              value: 'Wallet',
              child: Row(
                children: [
                  Icon(
                    Icons.account_balance_wallet,
                    color: Colors.white70,
                    size: 20,
                  ),
                  SizedBox(width: 12),
                  Text('Wallet'),
                ],
              ),
            ),
            DropdownMenuItem(
              value: 'Debit/Credit Card',
              child: Row(
                children: [
                  Icon(Icons.credit_card, color: Colors.white70, size: 20),
                  SizedBox(width: 12),
                  Text('Debit/Credit Card'),
                ],
              ),
            ),
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// WHITE GLASS CARD  — white 0.58, border white 0.70
// ─────────────────────────────────────────────────────────────────────────────
class _WhiteGlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  const _WhiteGlassCard({required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.58),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.70), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// GLASS OUTLINE FIELD  — semi-transparent, glassy border
// ─────────────────────────────────────────────────────────────────────────────
class _GlassOutlineField extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget? trailing;

  const _GlassOutlineField({
    required this.icon,
    required this.label,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.10),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withOpacity(0.30), width: 1),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: Colors.white.withOpacity(0.80),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SHARED GRADIENT PAINTER
// ─────────────────────────────────────────────────────────────────────────────
class _SheetGradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    canvas.drawRect(
      Rect.fromLTWH(0, 0, w, h),
      Paint()..color = const Color(0xFF1A1B2E),
    );

    _blob(
      canvas,
      center: Offset(w * 0.15, h * 0.30),
      rx: w * 0.70,
      ry: h * 0.50,
      color: const Color(0xFF8B4A35),
      alpha: 170,
    );
    _blob(
      canvas,
      center: Offset(w * 0.05, h * 0.55),
      rx: w * 0.50,
      ry: h * 0.35,
      color: const Color(0xFF6B3828),
      alpha: 130,
    );
    _blob(
      canvas,
      center: Offset(w * 0.82, h * 0.68),
      rx: w * 0.70,
      ry: h * 0.52,
      color: const Color(0xFF2E6B72),
      alpha: 165,
    );
    _blob(
      canvas,
      center: Offset(w * 0.90, h * 0.50),
      rx: w * 0.40,
      ry: h * 0.30,
      color: const Color(0xFF3D8A8F),
      alpha: 110,
    );
    _blob(
      canvas,
      center: Offset(w * 0.50, h * 0.50),
      rx: w * 0.55,
      ry: h * 0.40,
      color: const Color(0xFF3A4555),
      alpha: 80,
    );
  }

  void _blob(
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
