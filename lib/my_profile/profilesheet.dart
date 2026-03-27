// profile_bottom_sheet.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riden/controllers/profile_controllers.dart';
import 'package:riden/my_profile/complaint_ticket/complaint_tickets_screen.dart';
import 'package:riden/my_profile/contact_support/contact_support_screen.dart';
import 'package:riden/my_profile/in_app_wallet/in_app_wallet_screen.dart';
import 'package:riden/my_profile/payment_methods/payment_methods_screen.dart';
import 'package:riden/my_profile/profile_setting/profile_settings_bottom_sheet.dart';
import 'package:riden/theme/app_colors.dart';

// All sub-sheets — every menu item opens a bottom sheet
import 'package:riden/my_profile/about_us/about_us_bottom_sheet.dart';
import 'package:riden/my_profile/app_setting/app_setting.dart';

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
    return SingleChildScrollView(
      controller: scrollController,
      physics: const ClampingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Profile Section ─────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: RidenColors.brandRed,
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: RidenColors.brandRed.withOpacity(0.3),
                            blurRadius: 15,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.network(
                          'https://i.pravatar.cc/150?img=33',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () => _openSheet(
                          context,
                          (sc) =>
                              ProfileSettingsBottomSheet(scrollController: sc),
                        ),
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: RidenColors.brandRed,
                            border: Border.all(
                              color: RidenColors.backgroundBase,
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: RidenColors.brandRed.withOpacity(0.4),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Jesse Showalter',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: RidenColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Columbia, Canada',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: RidenColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          const Divider(color: Colors.white24, height: 24, thickness: 1),

          // ── Menu Items (all 7 wired) ─────────────────────
          _buildMenuItem(
            icon: Icons.person_outline,
            label: 'Profile Settings',
            onTap: () => _openSheet(
              context,
              (sc) => ProfileSettingsBottomSheet(scrollController: sc),
            ),
          ),
          _buildMenuItem(
            icon: Icons.payment,
            label: 'Payment Methods',
            onTap: () => _openSheet(
              context,
              (sc) => PaymentMethodsBottomSheet(scrollController: sc),
            ),
          ),
          _buildMenuItem(
            icon: Icons.wallet,
            label: 'In App Wallet',
            onTap: () => _openSheet(
              context,
              (sc) => InAppWalletBottomSheet(scrollController: sc),
            ),
          ),
          _buildMenuItem(
            icon: Icons.confirmation_number_outlined,
            label: 'Complaint Tickets',
            onTap: () => _openSheet(
              context,
              (sc) => ComplaintTicketsBottomSheet(scrollController: sc),
            ),
          ),
          _buildMenuItem(
            icon: Icons.info_outline,
            label: 'About Us',
            onTap: () => _openSheet(
              context,
              (sc) => AboutUsBottomSheet(scrollController: sc),
            ),
          ),
          _buildMenuItem(
            icon: Icons.settings_outlined,
            label: 'App Settings',
            onTap: () => _openSheet(
              context,
              (sc) => AppSettingsBottomSheet(scrollController: sc),
            ),
          ),
          _buildMenuItem(
            icon: Icons.support_agent_outlined,
            label: 'Contact Support',
            onTap: () => _openSheet(
              context,
              (sc) => ContactSupportBottomSheet(scrollController: sc),
            ),
          ),

          const Divider(color: Colors.white24, height: 24, thickness: 1),

          // ── Theme Toggle ─────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              children: [
                Text(
                  'Theme Mode',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: RidenColors.textPrimary,
                  ),
                ),
                const Spacer(),
                Obx(
                  () => GestureDetector(
                    onTap: controller.toggleLight,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: !controller.isDarkMode.value
                            ? RidenColors.brandRed
                            : Colors.white.withOpacity(0.08),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1.5,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.light_mode,
                          color: !controller.isDarkMode.value
                              ? Colors.white
                              : RidenColors.textSecondary,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Obx(
                  () => GestureDetector(
                    onTap: controller.toggleDark,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: controller.isDarkMode.value
                            ? RidenColors.brandRed
                            : Colors.white.withOpacity(0.08),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1.5,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.dark_mode,
                          color: controller.isDarkMode.value
                              ? Colors.white
                              : RidenColors.textSecondary,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Divider(color: Colors.white24, height: 24, thickness: 1),

          // ── Logout ───────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: GestureDetector(
              onTap: () {
                Get.snackbar(
                  'Logging out',
                  'Logging out...',
                  backgroundColor: RidenColors.brandRed,
                  colorText: Colors.white,
                  duration: const Duration(milliseconds: 800),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: RidenColors.brandRed, width: 1.5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, color: RidenColors.brandRed, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Logout',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: RidenColors.brandRed,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: RidenColors.brandRed.withOpacity(0.15),
              ),
              child: Center(
                child: Icon(icon, color: RidenColors.brandRed, size: 20),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: RidenColors.textPrimary,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white.withOpacity(0.4),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
