import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:Riden/controllers/profile_controllers.dart';
import 'package:Riden/my_profile/about_us/about_us_bottom_sheet.dart';
import 'package:Riden/my_profile/app_setting/app_setting.dart';
import 'package:Riden/my_profile/complaint_ticket/complaint_tickets_screen.dart';
import 'package:Riden/my_profile/contact_support/contact_support_screen.dart';
import 'package:Riden/my_profile/in_app_wallet/in_app_wallet_screen.dart';
import 'package:Riden/my_profile/payment_methods/payment_methods_screen.dart';
import 'package:Riden/my_profile/profile_setting/profile_settings_bottom_sheet.dart';
import 'package:Riden/theme/app_colors.dart';
import 'package:Riden/widgets/riden_bottom_nav.dart';

class ProfileSettingBottomSheet extends StatelessWidget {
  final ScrollController scrollController;
  final controller = Get.put(ProfileSidebarController());

  ProfileSettingBottomSheet({required this.scrollController, super.key});

  void _openSheet(BuildContext context, Widget Function(ScrollController) builder) {
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
                // ── 1. Gradient background (Copper to Teal)
                Positioned.fill(
                  child: CustomPaint(painter: _SheetGradientPainter()),
                ),

                // ── 2. Frosted glass blur layer
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

                // ── 3. Foreground content
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
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(2.5),
                          ),
                        ),
                      ),
                    ),

                    // Header
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 4, 20, 10),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Back',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Text(
                            'Settings',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    Expanded(
                      child: SingleChildScrollView(
                        controller: scrollController,
                        physics: const ClampingScrollPhysics(),
                        child: Column(
                          children: [
                            // ── Profile Image & Name
                            Column(
                              children: [
                                Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(45),
                                    child: Image.network(
                                      'https://i.pravatar.cc/150?img=33',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Jesse Showalter',
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 24),

                            // ── Glassy Menu List
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 20),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.58),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.25),
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                children: [
                                  _buildMenuItem(
                                    context: context,
                                    icon: Icons.person,
                                    label: 'Profile Settings',
                                    onTap: () => _openSheet(
                                      context,
                                      (sc) => ProfileSettingsBottomSheet(scrollController: sc),
                                    ),
                                  ),
                                  _buildDivider(),
                                  _buildMenuItem(
                                    context: context,
                                    icon: Icons.calendar_month_rounded,
                                    label: 'Booking History',
                                    onTap: () {},
                                  ),
                                  _buildDivider(),
                                  _buildMenuItem(
                                    context: context,
                                    icon: Icons.paid_rounded,
                                    label: 'Payment Methods',
                                    onTap: () => _openSheet(
                                      context,
                                      (sc) => PaymentMethodsBottomSheet(scrollController: sc),
                                    ),
                                  ),
                                  _buildDivider(),
                                  _buildMenuItem(
                                    context: context,
                                    icon: Icons.account_balance_wallet_rounded,
                                    label: 'In App Wallet',
                                    onTap: () => _openSheet(
                                      context,
                                      (sc) => InAppWalletBottomSheet(scrollController: sc),
                                    ),
                                  ),
                                  _buildDivider(),
                                  _buildMenuItem(
                                    context: context,
                                    icon: Icons.group_rounded,
                                    label: 'Complaint Tickets',
                                    onTap: () => _openSheet(
                                      context,
                                      (sc) => ComplaintTicketsBottomSheet(scrollController: sc),
                                    ),
                                  ),
                                  _buildDivider(),
                                  _buildMenuItem(
                                    context: context,
                                    icon: Icons.person_pin_rounded,
                                    label: 'About us',
                                    onTap: () => _openSheet(
                                      context,
                                      (sc) => AboutUsBottomSheet(scrollController: sc),
                                    ),
                                  ),
                                  _buildDivider(),
                                  _buildMenuItem(
                                    context: context,
                                    icon: Icons.settings_rounded,
                                    label: 'App Settings',
                                    onTap: () => _openSheet(
                                      context,
                                      (sc) => AppSettingsBottomSheet(scrollController: sc),
                                    ),
                                  ),
                                  _buildDivider(),
                                  _buildMenuItem(
                                    context: context,
                                    icon: Icons.person_add_rounded,
                                    label: 'Contact Support',
                                    onTap: () => _openSheet(
                                      context,
                                      (sc) => ContactSupportBottomSheet(scrollController: sc),
                                    ),
                                  ),
                                  _buildDivider(),
                                  _buildMenuItem(
                                    context: context,
                                    icon: Icons.logout_rounded,
                                    label: 'Logout',
                                    onTap: () {
                                      Get.snackbar(
                                        'Logging out',
                                        'Good bye!',
                                        backgroundColor: RidenColors.brandRed,
                                        colorText: Colors.white,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 100), // Space for bottom nav
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                
                // BottomNav
                Align(
                  alignment: Alignment.bottomCenter,
                  child: RidenBottomNav(
                    selectedIndex: 4, // Account
                    isFromSheet: true,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: RidenColors.brandRed, size: 22),
      title: Text(
        label,
        style: GoogleFonts.poppins(
          color: Colors.black87,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: RidenColors.brandRed,
        size: 24,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      visualDensity: VisualDensity.compact,
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Divider(color: Colors.black.withOpacity(0.08), height: 1),
    );
  }
}

class _SheetGradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    canvas.drawRect(
      Rect.fromLTWH(0, 0, w, h),
      Paint()..color = const Color(0xFF1A1B2E),
    );

    _radialBlob(
      canvas,
      center: Offset(w * 0.15, h * 0.30),
      rx: w * 0.80,
      ry: h * 0.60,
      color: const Color(0xFF8B4A35),
      alpha: 170,
    );

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