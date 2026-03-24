import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riden/theme/app_colors.dart';

class InAppWalletScreen extends StatelessWidget {
  const InAppWalletScreen({super.key});

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

    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            const RidenDarkBackground(),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back arrow + title
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 22),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              "In App Wallet",
                              style: GoogleFonts.audiowide(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 22,
                                letterSpacing: 1.1,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 36), // Fills space for symmetry
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Wallet Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 18),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withOpacity(0.13),
                            blurRadius: 15,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Available Balance",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 15.7,
                                fontWeight: FontWeight.w500,
                              )),
                          const SizedBox(height: 6),
                          Text(
                            "\$45,900.00",
                            style: GoogleFonts.audiowide(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 24.5,
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 30,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.red,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                elevation: 0,
                              ),
                              onPressed: () {
                                // Add funds logic
                              },
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
                    const SizedBox(height: 30),

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
                    ...transactions.map((tx) => WalletTransactionTile(
                      date: tx['date'],
                      bookingId: tx['bookingId'],
                      logo: tx['logo'],
                      card: tx['card'],
                      number: tx['number'],
                      amount: tx['amount'],
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
    Key? key,
  }) : super(key: key);

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
          // Date
          Row(
            children: [
              Text(date,
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 13.4)),
              const Spacer(),
              Text(
                "\$${amount.toStringAsFixed(2)}",
                style: GoogleFonts.poppins(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.3,
                ),
              )
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
              Text(card,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 13.2,
                  )),
              const SizedBox(width: 6),
              Text(number,
                  style: GoogleFonts.poppins(
                    color: Colors.white70,
                    fontSize: 12.1,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}