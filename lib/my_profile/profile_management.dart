// profile_management.dart – fixed imports and mixed navigation
import 'package:Riden/controllers/profile_controllers.dart';
import 'package:Riden/my_profile/about_us/about_us_bottom_sheet.dart';
import 'package:Riden/my_profile/app_setting/app_setting.dart';
import 'package:Riden/my_profile/complaint_ticket/complaint_tickets_screen.dart';
import 'package:Riden/my_profile/contact_support/contact_support_screen.dart';
import 'package:Riden/my_profile/in_app_wallet/in_app_wallet_screen.dart';
import 'package:Riden/my_profile/payment_methods/payment_methods_screen.dart';
import 'package:Riden/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileSidebar extends StatelessWidget {
  ProfileSidebar({super.key});

  final controller = Get.put(ProfileSidebarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RidenColors.backgroundBase,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const RidenDarkBackground(),
          Row(
            children: [
              // Left sidebar
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  border: Border(
                    right: BorderSide(
                      color: Colors.white.withOpacity(0.1),
                      width: 1.5,
                    ),
                  ),
                ),
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Back Button
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: GestureDetector(
                            onTap: () => Get.back(),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.arrow_back_ios,
                                  color: RidenColors.textPrimary,
                                  size: 20,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Back',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: RidenColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.white.withOpacity(0.1),
                          height: 1,
                        ),
                        SizedBox(height: 20),

                        // Profile Section
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: RidenColors.brandRed,
                                    width: 3,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(35),
                                  child: Image.network(
                                    'https://i.pravatar.cc/150?img=33',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                'jesse Showalter',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: RidenColors.textPrimary,
                                ),
                              ),
                              SizedBox(height: 4),
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
                        SizedBox(height: 24),

                        // Menu Items
                        _buildMenuSection(
                          items: [
                            _MenuItem(
                              icon: Icons.person,
                              label: 'Profile Settings',
                              onTap: () {
                                Get.to(() => ProfileSettingsScreen());
                              },
                            ),
                            _MenuItem(
                              icon: Icons.payment,
                              label: 'Payment Methods',
                              onTap: () {
                                Get.to(
                                  () => PaymentMethodsBottomSheet(
                                    scrollController: ScrollController(),
                                  ),
                                );
                              },
                            ),
                            _MenuItem(
                              icon: Icons.wallet,
                              label: 'In App Wallet',
                              onTap: () {
                                Get.to(
                                  () => InAppWalletBottomSheet(
                                    scrollController: ScrollController(),
                                  ),
                                );
                              },
                            ),
                            _MenuItem(
                              icon: Icons.rocket,
                              label: 'Complaint Tickets',
                              onTap: () {
                                Get.to(
                                  () => ComplaintTicketsBottomSheet(
                                    scrollController: ScrollController(),
                                  ),
                                );
                              },
                            ),
                            _MenuItem(
                              icon: Icons.info,
                              label: 'About us',
                              onTap: () {
                                _openAboutUsBottomSheet(context);
                              },
                            ),
                            _MenuItem(
                              icon: Icons.settings,
                              label: 'App Settings',
                              onTap: () {
                                _openAppSettingsBottomSheet(context);
                              },
                            ),
                            _MenuItem(
                              icon: Icons.support_agent,
                              label: 'Contact Support',
                              onTap: () {
                                _openContactSupportBottomSheet(context);
                              },
                            ),
                            _MenuItem(
                              icon: Icons.logout,
                              label: 'Logout',
                              onTap: () {
                                Get.snackbar(
                                  'Logging out',
                                  'Logging out...',
                                  backgroundColor: RidenColors.brandRed,
                                  colorText: Colors.white,
                                  duration: Duration(milliseconds: 800),
                                );
                              },
                            ),
                          ],
                        ),

                        SizedBox(height: 28),

                        // Dark/Light Mode Toggle
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Obx(
                                () => GestureDetector(
                                  onTap: () {
                                    controller.toggleLight();
                                  },
                                  child: Container(
                                    width: 45,
                                    height: 45,
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
                                        size: 22,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              Obx(
                                () => GestureDetector(
                                  onTap: () {
                                    controller.toggleDark();
                                  },
                                  child: Container(
                                    width: 45,
                                    height: 45,
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
                                        size: 22,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),

              // Right side – transparent to show dark gradient
              Expanded(
                child: Container(
                  color: Colors.transparent,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.map,
                          size: 64,
                          color: Colors.white.withOpacity(0.2),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Map View',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white.withOpacity(0.3),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

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

  Widget _buildMenuSection({required List<_MenuItem> items}) {
    return Column(
      children: List.generate(items.length, (index) {
        final item = items[index];
        return Column(
          children: [
            GestureDetector(
              onTap: item.onTap,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
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
                        child: Icon(
                          item.icon,
                          color: RidenColors.brandRed,
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Text(
                      item.label,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: RidenColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (index < items.length - 1)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  color: Colors.white.withOpacity(0.08),
                  height: 1,
                ),
              ),
          ],
        );
      }),
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  _MenuItem({required this.icon, required this.label, required this.onTap});
}

// ------------------------- Profile Settings Screen (full screen) -------------------------
class ProfileSettingsScreen extends StatelessWidget {
  ProfileSettingsScreen({super.key});

  final controller = Get.put(ProfileSettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RidenColors.backgroundBase,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const RidenDarkBackground(),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back Button
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_back_ios,
                            color: RidenColors.textPrimary,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Back',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: RidenColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Title
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Profile Settings',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: RidenColors.textPrimary,
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  // Profile Picture Section
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
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
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              'https://i.pravatar.cc/150?img=33',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'jesse Showalter',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: RidenColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 16),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => EditProfileScreen());
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: RidenColors.brandRed,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: RidenColors.brandRed.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.edit, color: Colors.white, size: 16),
                                SizedBox(width: 8),
                                Text(
                                  'Edit Profile',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32),
                  // Profile Info Section
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        _buildInfoCard(
                          icon: Icons.email,
                          label: 'Email',
                          value: 'example@gmail.com',
                        ),
                        SizedBox(height: 16),
                        _buildInfoCard(
                          icon: Icons.phone,
                          label: 'Phone Number',
                          value: '+1 2345678946',
                        ),
                        SizedBox(height: 16),
                        _buildInfoCard(
                          icon: Icons.wc,
                          label: 'Gender',
                          value: 'Male',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withOpacity(0.12), width: 1.5),
      ),
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: RidenColors.brandRed.withOpacity(0.15),
            ),
            child: Center(
              child: Icon(icon, color: RidenColors.brandRed, size: 22),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: RidenColors.textSecondary,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: RidenColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------------- Edit Profile Screen (full screen) -------------------------
class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final controller = Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RidenColors.backgroundBase,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const RidenDarkBackground(),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back Button
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_back_ios,
                            color: RidenColors.textPrimary,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Back',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: RidenColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Title
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: RidenColors.textPrimary,
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  // Profile Picture with Camera Icon
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
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
                            borderRadius: BorderRadius.circular(50),
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
                            onTap: () {
                              Get.snackbar(
                                'Camera',
                                'Camera: Select new photo',
                                backgroundColor: RidenColors.brandRed,
                                colorText: Colors.white,
                                duration: Duration(milliseconds: 800),
                              );
                            },
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: RidenColors.brandRed,
                                border: Border.all(
                                  color: RidenColors.backgroundBase,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: RidenColors.brandRed.withOpacity(
                                      0.4,
                                    ),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32),
                  // Form Fields
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        _buildFormSection(
                          label: 'Full Name',
                          controller: controller.fullNameController,
                          icon: Icons.person,
                        ),
                        SizedBox(height: 20),
                        _buildFormSection(
                          label: 'Email',
                          controller: controller.emailController,
                          icon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 20),
                        _buildFormSection(
                          label: 'Phone Number',
                          controller: controller.phoneController,
                          icon: Icons.phone,
                          keyboardType: TextInputType.phone,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32),
                  // Update Button
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                      onTap: () {
                        controller.updateProfile();
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: RidenColors.brandRed,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: RidenColors.brandRed.withOpacity(0.4),
                              blurRadius: 15,
                              offset: Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Update',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormSection({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: RidenColors.textSecondary,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withOpacity(0.15),
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                child: Icon(icon, color: RidenColors.brandRed, size: 20),
              ),
              Container(
                width: 1,
                height: 24,
                color: Colors.white.withOpacity(0.1),
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: keyboardType,
                  style: TextStyle(
                    fontSize: 14,
                    color: RidenColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    hintText: label,
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
