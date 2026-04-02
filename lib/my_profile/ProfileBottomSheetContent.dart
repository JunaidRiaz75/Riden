// profile_bottom_sheet.dart
// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:Riden/controllers/profile_controllers.dart';
import 'package:Riden/my_profile/about_us/about_us_bottom_sheet.dart';
import 'package:Riden/my_profile/app_setting/app_setting.dart';
import 'package:Riden/my_profile/complaint_ticket/complaint_tickets_screen.dart';
import 'package:Riden/my_profile/contact_support/contact_support_screen.dart';
import 'package:Riden/my_profile/in_app_wallet/in_app_wallet_screen.dart';
import 'package:Riden/my_profile/payment_methods/payment_methods_screen.dart';
import 'package:Riden/my_profile/profile_setting/profile_settings_bottom_sheet.dart';
import 'package:Riden/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileBottomSheet extends StatelessWidget {
  final ScrollController scrollController;

  const ProfileBottomSheet({required this.scrollController, super.key});

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
              Expanded(
                child: ProfileBottomSheetContent(
                  scrollController: scrollController,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProfileBottomSheetContent extends StatelessWidget {
  final ScrollController scrollController;
  final controller = Get.put(ProfileSidebarController());

  ProfileBottomSheetContent({required this.scrollController, super.key});

  /// Opens any sheet using the standard DraggableScrollableSheet pattern.
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ✅ Background Gradient
          const Positioned.fill(child: RidenDarkBackground()),

          // ✅ Blurry overlay
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
              child: Container(color: Colors.white.withOpacity(0.06)),
            ),
          ),

          SingleChildScrollView(
            controller: scrollController,
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                // Drag handle
                Padding(
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
                // ── Settings Header ─────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 10),
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
                                size: 20,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Back',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
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
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // ── Profile Image & Name ───────────────────────
                Column(
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
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
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // ── Glassy Menu List ──────────────────────────
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(
                      0.58,
                    ), // MATCHED TO BOTTOM NAV
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.15),
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
                          (sc) =>
                              ProfileSettingsBottomSheet(scrollController: sc),
                        ),
                      ),
                      _buildDivider(),
                      _buildMenuItem(
                        context: context,
                        icon: Icons.calendar_month_rounded,
                        label: 'Ride History',
                        onTap: () {},
                      ),
                      _buildDivider(),
                      _buildMenuItem(
                        context: context,
                        icon: Icons.paid_rounded,
                        label: 'Payment Methods',
                        onTap: () => _openSheet(
                          context,
                          (sc) =>
                              PaymentMethodsBottomSheet(scrollController: sc),
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
                          (sc) =>
                              ComplaintTicketsBottomSheet(scrollController: sc),
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
                          (sc) =>
                              ContactSupportBottomSheet(scrollController: sc),
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
        ],
      ),
      bottomNavigationBar: RidenBottomNav(selectedIndex: 3, isFromSheet: true),
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
      leading: Icon(icon, color: Colors.red, size: 22),
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
        color: Colors.red,
        size: 24,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      visualDensity: VisualDensity.compact,
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Divider(color: Colors.black.withOpacity(0.08), height: 1),
    );
  }
}


