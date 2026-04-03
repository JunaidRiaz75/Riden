// in_app_wallet_bottom_sheet.dart
// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:Riden/theme/app_colors.dart';
import 'package:Riden/widgets/riden_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InAppWalletBottomSheet extends StatelessWidget {
  final ScrollController scrollController;

  const InAppWalletBottomSheet({required this.scrollController, super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> transactions = [
      {
        'date': '25 May, 2025',
        'time': '09:00pm',
        'bookingId': '3452',
        'logo': 'assets/images/visa_logo.png',
        'card': 'Visa',
        'number': '******234',
        'amount': 45.00,
      },
      {
        'date': '25 May, 2025',
        'time': '09:00pm',
        'bookingId': '3452',
        'logo': 'assets/images/master_logo.png',
        'card': 'Visa', // The image says "Visa" for both despite the mastercard logo
        'number': '******234',
        'amount': 45.00,
      },
      {
        'date': '25 May, 2025',
        'time': '09:00pm',
        'bookingId': '3452',
        'logo': 'assets/images/visa_logo.png',
        'card': 'Visa',
        'number': '******234',
        'amount': 45.00,
      },
    ];

    final screenHeight = MediaQuery.of(context).size.height;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double sheetH = constraints.maxHeight;
        final double minH = screenHeight * 0.50; // Reference min height
        final double maxH = screenHeight * 1.00;
        final double progress = ((sheetH - minH) / (maxH - minH)).clamp(0.0, 1.0);
        final double cornerRadius = 28.0 * (1.0 - progress);

        return ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(cornerRadius),
            topRight: Radius.circular(cornerRadius),
          ),
          child: Stack(
            children: [
              // ── Dark gradient background ──────────────────────
              Positioned.fill(
                child: CustomPaint(painter: SheetGradientPainter()),
              ),
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                  child: Container(color: Colors.white.withOpacity(0.05)),
                ),
              ),

              // ── Sheet content ─────────────────────────────────
              Column(
                children: [
                   // Drag Handle
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
                  
                  // Scrollable Content
                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      children: [
                        // Header
                        Row(
                          children: [
                            GestureDetector(
                               onTap: () => Navigator.pop(context),
                               child: Row(
                                 children: [
                                   const Icon(
                                     Icons.arrow_back_ios_new_rounded,
                                     color: Colors.white,
                                     size: 16,
                                   ),
                                   const SizedBox(width: 4),
                                   Text(
                                     "Back",
                                     style: GoogleFonts.poppins(
                                       color: Colors.white,
                                       fontSize: 13,
                                     ),
                                   ),
                                 ]
                               )
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  "In App Wallet",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 60), // To balance the back button conceptually
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Wallet Card
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE53935),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                right: 20,
                                bottom: 20,
                                top: 20,
                                child: Image.asset(
                                  'assets/images/add_card_illustration.png',
                                  fit: BoxFit.contain,
                                  width: 140,
                                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.account_balance_wallet, color: Colors.white30, size: 80),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(26),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "\$45,900.00",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 22,
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    SizedBox(
                                      height: 32,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          foregroundColor: const Color(0xFFE53935),
                                          padding: const EdgeInsets.symmetric(horizontal: 16),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          elevation: 0,
                                        ),
                                        onPressed: () {},
                                        child: Text(
                                          "Add Funds",
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xFFE53935),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Transaction history header
                        Text(
                          "Transaction History",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Transactions
                        ...transactions.asMap().entries.map((entry) {
                          final int idx = entry.key;
                          final tx = entry.value;
                          final bool isLast = idx == transactions.length - 1;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              WalletTransactionTile(
                                date: tx['date'],
                                time: tx['time'],
                                bookingId: tx['bookingId'],
                                logo: tx['logo'],
                                card: tx['card'],
                                number: tx['number'],
                                amount: tx['amount'],
                              ),
                              if (!isLast)
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 20),
                                  child: Divider(color: Colors.white.withOpacity(0.4), thickness: 1, height: 1),
                                ),
                              if (isLast)
                                const SizedBox(height: 40),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                  
                  // Bottom Nav
                  RidenBottomNav(selectedIndex: 3),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

// ── WalletTransactionTile ───────────────────────────────────────────

class WalletTransactionTile extends StatelessWidget {
  final String date;
  final String time;
  final String bookingId;
  final String logo;
  final String card;
  final String number;
  final double amount;

  const WalletTransactionTile({
    required this.date,
    required this.time,
    required this.bookingId,
    required this.logo,
    required this.card,
    required this.number,
    required this.amount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              date,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              time,
              style: GoogleFonts.poppins(
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          "Booking ID : $bookingId",
          style: GoogleFonts.poppins(
            color: Colors.white.withOpacity(0.6),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(logo, width: 34, height: 24, fit: BoxFit.contain,
              errorBuilder: (_,__,___) => const Icon(Icons.credit_card, size: 24, color: Colors.white)
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  card,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                Text(
                  number,
                  style: GoogleFonts.poppins(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              "\$${amount.toStringAsFixed(2)}",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SHARED GRADIENT PAINTER
// ─────────────────────────────────────────────────────────────────────────────
class SheetGradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Base dark navy
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
  bool shouldRepaint(SheetGradientPainter _) => false;
}
