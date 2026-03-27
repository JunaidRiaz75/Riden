// in_app_wallet_bottom_sheet.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riden/theme/app_colors.dart';

class InAppWalletBottomSheet extends StatelessWidget {
  final ScrollController scrollController;

  const InAppWalletBottomSheet({required this.scrollController, super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> transactions = [
      {
        'date': '25 May, 2025 09:00pm',
        'bookingId': '3452',
        'logo': 'assets/images/visa_logo.png',
        'card': 'Visa',
        'number': '******234',
        'amount': 45900.00,
      },
      {
        'date': '25 May, 2025 09:00pm',
        'bookingId': '3452',
        'logo': 'assets/images/master_logo.png',
        'card': 'Master card',
        'number': '******234',
        'amount': 45900.00,
      },
      {
        'date': '25 May, 2025 09:00pm',
        'bookingId': '3452',
        'logo': 'assets/images/visa_logo.png',
        'card': 'Visa',
        'number': '******234',
        'amount': 45900.00,
      },
    ];

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
                  controller: scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    vertical: 18,
                    horizontal: 20,
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
                          Expanded(
                            child: Center(
                              child: Text(
                                "In App Wallet",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 36),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Wallet Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 26,
                          horizontal: 18,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.3),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Available Balance",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 15.7,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "\$45,900.00",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 24.5,
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 32,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  elevation: 0,
                                ),
                                onPressed: () {},
                                child: Text(
                                  "Add Funds",
                                  style: GoogleFonts.poppins(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.5,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Transaction history header
                      Text(
                        "Transaction History",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Transactions
                      ...transactions.map(
                        (tx) => WalletTransactionTile(
                          date: tx['date'],
                          bookingId: tx['bookingId'],
                          logo: tx['logo'],
                          card: tx['card'],
                          number: tx['number'],
                          amount: tx['amount'],
                        ),
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

// ── WalletTransactionTile ───────────────────────────────────────────

class WalletTransactionTile extends StatelessWidget {
  final String date;
  final String bookingId;
  final String logo;
  final String card;
  final String number;
  final double amount;

  const WalletTransactionTile({
    required this.date,
    required this.bookingId,
    required this.logo,
    required this.card,
    required this.number,
    required this.amount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 9),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.10),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                date,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.4,
                ),
              ),
              const Spacer(),
              Text(
                "\$${amount.toStringAsFixed(2)}",
                style: GoogleFonts.poppins(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            "Booking ID : $bookingId",
            style: GoogleFonts.poppins(
              color: Colors.white70,
              fontSize: 12.4,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 7),
          Row(
            children: [
              Image.asset(logo, width: 28, height: 28),
              const SizedBox(width: 6),
              Text(
                card,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.2,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                number,
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: 12.1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
