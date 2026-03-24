import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:riden/theme/app_colors.dart';
import 'package:riden/my_profile/profile_management.dart';
import 'package:riden/my_profile/payment_methods/add_new_card_screen.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});
  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  final List<Map<String, dynamic>> primaryMethods = [
    {'logo': 'assets/images/visa_logo.png', 'name': 'Visa', 'number': '******234'},
    {'logo': 'assets/images/applepay_logo.png', 'name': 'Apple Pay', 'number': '******234'},
  ];
  final List<Map<String, dynamic>> otherMethods = [
    {'logo': 'assets/images/master_logo.png', 'name': 'Master card', 'number': '******234'},
  ];

  Future<String?> showEditDeletePopup(BuildContext context, Offset offset) async {
    final double screenWidth = MediaQuery.of(context).size.width;
    double popupWidth = 110;
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
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      onTap: () => Get.back(result: 'edit'),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
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
                      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
                      onTap: () => Get.back(result: 'delete'),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
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
    final result = await showEditDeletePopup(
      context, Offset(offset.dx + 46, offset.dy + 46)
    );
    if (result == 'edit') {
      // Edit logic here
    } else if (result == 'delete') {
      setState(() {
        if (section == 0) primaryMethods.removeAt(idx);
        else otherMethods.removeAt(idx);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            // FULLSCREEN GRADIENT: never affected by content height!
            const RidenDarkBackground(),

            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Your Cards',
                        style: GoogleFonts.audiowide(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                        )),
                    const SizedBox(height: 32),
                    Text('Primary Methods',
                        style: GoogleFonts.poppins(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        )),
                    const SizedBox(height: 12),
                    ...List.generate(primaryMethods.length, (idx) {
                      return PaymentCardRow(
                        logo: primaryMethods[idx]['logo'],
                        name: primaryMethods[idx]['name'],
                        number: primaryMethods[idx]['number'],
                        onMenuTap: (context) => _onCardMenuTap(context, 0, idx),
                      );
                    }),
                    const SizedBox(height: 26),
                    Text('Other Methods',
                        style: GoogleFonts.poppins(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        )),
                    const SizedBox(height: 12),
                    ...List.generate(otherMethods.length, (idx) {
                      return PaymentCardRow(
                        logo: otherMethods[idx]['logo'],
                        name: otherMethods[idx]['name'],
                        number: otherMethods[idx]['number'],
                        onMenuTap: (context) => _onCardMenuTap(context, 1, idx),
                      );
                    }),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.15),
                            foregroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                          onPressed: () {
                            Get.to(() => AddNewCardScreen());
                          },
                        ),
                      ],
                    ),
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
    Key? key,
  }) : super(key: key);

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
                Text(name,
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14.4,
                        fontWeight: FontWeight.w600)),
                Text(number,
                    style: GoogleFonts.poppins(
                        color: Colors.white, fontSize: 12.7)),
              ],
            ),
          ),
          Builder(
            builder: (ctx) => IconButton(
                splashRadius: 20,
                icon: const Icon(Icons.more_vert, color: Colors.white70, size: 22),
                onPressed: () => onMenuTap(ctx)),
          ),
        ],
      ),
    );
  }
}