// profile_bottom_sheet.dart - Complete Fixed Version
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riden/controllers/profile_controllers.dart';
import 'package:riden/my_profile/about_us/about_us_bottom_sheet.dart';
import 'package:riden/my_profile/app_setting/app_setting.dart';
import 'package:riden/theme/app_colors.dart';

// Import the EditProfileScreen from profile_management.dart
import 'profile_management.dart';

class ProfileBottomSheet extends StatelessWidget {
  final ScrollController scrollController;

  const ProfileBottomSheet({required this.scrollController, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            RidenColors.backgroundBase.withOpacity(0.98),
            RidenColors.backgroundBase.withOpacity(0.95),
            RidenColors.backgroundBase.withOpacity(0.92),
          ],
          stops: const [0.0, 0.6, 1.0],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 25,
            offset: const Offset(0, -5),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
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
          // Profile Content
          Expanded(
            child: ProfileBottomSheetContent(
              scrollController: scrollController,
            ),
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

  void _openAppSettingsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          snap: true,
          snapSizes: const [0.5, 0.85, 0.95],
          builder: (context, scrollController) {
            return AppSettingsBottomSheet(scrollController: scrollController);
          },
        );
      },
    );
  }

  void _openContactSupportBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          snap: true,
          snapSizes: const [0.5, 0.85, 0.95],
          builder: (context, scrollController) {
            return ContactSupportBottomSheet(
              scrollController: scrollController,
            );
          },
        );
      },
    );
  }

  void _openComplaintTicketsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          snap: true,
          snapSizes: const [0.5, 0.85, 0.95],
          builder: (context, scrollController) {
            return ComplaintTicketsBottomSheet(
              scrollController: scrollController,
            );
          },
        );
      },
    );
  }

  void _openInAppWalletBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          snap: true,
          snapSizes: const [0.5, 0.85, 0.95],
          builder: (context, scrollController) {
            return InAppWalletBottomSheet(scrollController: scrollController);
          },
        );
      },
    );
  }

  void _openPaymentMethodsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          snap: true,
          snapSizes: const [0.5, 0.85, 0.95],
          builder: (context, scrollController) {
            return PaymentMethodsBottomSheet(
              scrollController: scrollController,
            );
          },
        );
      },
    );
  }

  void _openProfileSettingsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          snap: true,
          snapSizes: const [0.5, 0.85, 0.95],
          builder: (context, scrollController) {
            return ProfileSettingsBottomSheet(
              scrollController: scrollController,
            );
          },
        );
      },
    );
  }

  void _openAboutUsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          snap: true,
          snapSizes: const [0.5, 0.85, 0.95],
          builder: (context, scrollController) {
            return AboutUsBottomSheet(scrollController: scrollController);
          },
        );
      },
    );
  }

  void _openEditProfileScreen(BuildContext context) {
    Get.to(() => EditProfileScreen());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      physics: const ClampingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Section
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
            child: Column(
              children: [
                // Profile Picture with Edit Button
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
                    // Edit Profile Button
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          _openEditProfileScreen(context);
                        },
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

                // Name
                Text(
                  'jesse Showalter',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: RidenColors.textPrimary,
                  ),
                ),

                const SizedBox(height: 4),

                // Location
                Text(
                  'Columbia, Canada',
                  style: TextStyle(
                    fontSize: 13,
                    color: RidenColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          const Divider(color: Colors.white24, height: 24, thickness: 1),

          // Menu Items
          _buildMenuItem(
            icon: Icons.person,
            label: 'Profile Settings',
            onTap: () => _openProfileSettingsBottomSheet(context),
          ),
          _buildMenuItem(
            icon: Icons.payment,
            label: 'Payment Methods',
            onTap: () => _openPaymentMethodsBottomSheet(context),
          ),
          _buildMenuItem(
            icon: Icons.wallet,
            label: 'In App Wallet',
            onTap: () => _openInAppWalletBottomSheet(context),
          ),
          _buildMenuItem(
            icon: Icons.rocket,
            label: 'Complaint Tickets',
            onTap: () => _openComplaintTicketsBottomSheet(context),
          ),
          _buildMenuItem(
            icon: Icons.info,
            label: 'About us',
            onTap: () => _openAboutUsBottomSheet(context),
          ),
          _buildMenuItem(
            icon: Icons.settings,
            label: 'App Settings',
            onTap: () => _openAppSettingsBottomSheet(context),
          ),
          _buildMenuItem(
            icon: Icons.support_agent,
            label: 'Contact Support',
            onTap: () => _openContactSupportBottomSheet(context),
          ),

          const Divider(color: Colors.white24, height: 24, thickness: 1),

          // Dark/Light Mode Toggle
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              children: [
                Text(
                  'Theme Mode',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: RidenColors.textPrimary,
                  ),
                ),
                const Spacer(),
                // Light Mode
                Obx(
                  () => GestureDetector(
                    onTap: () {
                      controller.toggleLight();
                    },
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
                // Dark Mode
                Obx(
                  () => GestureDetector(
                    onTap: () {
                      controller.toggleDark();
                    },
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

          // Logout Button
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
                      style: TextStyle(
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
                style: TextStyle(
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

// ==================== PLACEHOLDER BOTTOM SHEETS ====================

class ProfileSettingsBottomSheet extends StatelessWidget {
  final ScrollController scrollController;

  const ProfileSettingsBottomSheet({required this.scrollController, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            RidenColors.backgroundBase.withOpacity(0.98),
            RidenColors.backgroundBase.withOpacity(0.95),
            RidenColors.backgroundBase.withOpacity(0.92),
          ],
          stops: const [0.0, 0.6, 1.0],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 25,
            offset: const Offset(0, -5),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
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
            child: Center(
              child: Text(
                'Profile Settings',
                style: TextStyle(color: RidenColors.textPrimary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentMethodsBottomSheet extends StatelessWidget {
  final ScrollController scrollController;

  const PaymentMethodsBottomSheet({required this.scrollController, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            RidenColors.backgroundBase.withOpacity(0.98),
            RidenColors.backgroundBase.withOpacity(0.95),
            RidenColors.backgroundBase.withOpacity(0.92),
          ],
          stops: const [0.0, 0.6, 1.0],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 25,
            offset: const Offset(0, -5),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
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
            child: Center(
              child: Text(
                'Payment Methods',
                style: TextStyle(color: RidenColors.textPrimary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InAppWalletBottomSheet extends StatelessWidget {
  final ScrollController scrollController;

  const InAppWalletBottomSheet({required this.scrollController, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            RidenColors.backgroundBase.withOpacity(0.98),
            RidenColors.backgroundBase.withOpacity(0.95),
            RidenColors.backgroundBase.withOpacity(0.92),
          ],
          stops: const [0.0, 0.6, 1.0],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 25,
            offset: const Offset(0, -5),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
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
            child: Center(
              child: Text(
                'In App Wallet',
                style: TextStyle(color: RidenColors.textPrimary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ComplaintTicketsBottomSheet extends StatelessWidget {
  final ScrollController scrollController;

  const ComplaintTicketsBottomSheet({
    required this.scrollController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            RidenColors.backgroundBase.withOpacity(0.98),
            RidenColors.backgroundBase.withOpacity(0.95),
            RidenColors.backgroundBase.withOpacity(0.92),
          ],
          stops: const [0.0, 0.6, 1.0],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 25,
            offset: const Offset(0, -5),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
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
            child: Center(
              child: Text(
                'Complaint Tickets',
                style: TextStyle(color: RidenColors.textPrimary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContactSupportBottomSheet extends StatelessWidget {
  final ScrollController scrollController;

  const ContactSupportBottomSheet({required this.scrollController, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            RidenColors.backgroundBase.withOpacity(0.98),
            RidenColors.backgroundBase.withOpacity(0.95),
            RidenColors.backgroundBase.withOpacity(0.92),
          ],
          stops: const [0.0, 0.6, 1.0],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 25,
            offset: const Offset(0, -5),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
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
            child: Center(
              child: Text(
                'Contact Support',
                style: TextStyle(color: RidenColors.textPrimary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
