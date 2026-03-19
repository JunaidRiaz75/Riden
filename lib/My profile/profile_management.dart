import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riden/My%20profile/appsetting.dart';
import 'package:riden/controllers/profile_controllers.dart'; // Import controllers
import 'package:riden/theme/riden_theme.dart';

// ✅ MAIN PROFILE SIDEBAR SCREEN - GETX
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
          // ✅ Dark glassy background
          const RidenDarkBackground(),

          Row(
            children: [
              // ✅ Left Sidebar
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
                              // Profile Picture
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

                              // Name
                              Text(
                                'jesse Showalter',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: RidenColors.textPrimary,
                                ),
                              ),

                              SizedBox(height: 4),

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
                                Get.snackbar(
                                  'Payment Methods',
                                  'Payment Methods',
                                  backgroundColor: RidenColors.brandRed,
                                  colorText: Colors.white,
                                  duration: Duration(milliseconds: 800),
                                );
                              },
                            ),
                            _MenuItem(
                              icon: Icons.wallet,
                              label: 'In App Wallet',
                              onTap: () {
                                Get.snackbar(
                                  'In App Wallet',
                                  'In App Wallet',
                                  backgroundColor: RidenColors.brandRed,
                                  colorText: Colors.white,
                                  duration: Duration(milliseconds: 800),
                                );
                              },
                            ),
                            _MenuItem(
                              icon: Icons.rocket,
                              label: 'Complaint Tickets',
                              onTap: () {
                                Get.snackbar(
                                  'Complaint Tickets',
                                  'Complaint Tickets',
                                  backgroundColor: RidenColors.brandRed,
                                  colorText: Colors.white,
                                  duration: Duration(milliseconds: 800),
                                );
                              },
                            ),
                            _MenuItem(
                              icon: Icons.info,
                              label: 'About us',
                              onTap: () {
                                Get.snackbar(
                                  'About us',
                                  'About us',
                                  backgroundColor: RidenColors.brandRed,
                                  colorText: Colors.white,
                                  duration: Duration(milliseconds: 800),
                                );
                              },
                            ),
                            _MenuItem(
                              icon: Icons.settings,
                              label: 'App Settings',
                              onTap: () {
                                Get.to(() => AppSettingsScreen());
                              },
                            ),
                            _MenuItem(
                              icon: Icons.support_agent,
                              label: 'Contact Support',
                              onTap: () {
                                Get.snackbar(
                                  'Contact Support',
                                  'Contact Support',
                                  backgroundColor: RidenColors.brandRed,
                                  colorText: Colors.white,
                                  duration: Duration(milliseconds: 800),
                                );
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
                              // Light Mode
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

                              // Dark Mode
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

              // ✅ Right side area
              Expanded(
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.map,
                          size: 64,
                          color: Colors.white.withOpacity(0.2),
                        ),
                        SizedBox(height: 16),
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
                    // Icon
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

                    // Label
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

// ✅ PROFILE SETTINGS SCREEN - GETX
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
          // ✅ Dark glassy background
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
                        // Profile Picture
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

                        // Name
                        Text(
                          'jesse Showalter',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: RidenColors.textPrimary,
                          ),
                        ),

                        SizedBox(height: 16),

                        // Edit Profile Button
                        Obx(
                          () => GestureDetector(
                            onTapDown: (_) {
                              controller.editProfileTap();
                            },
                            onTapUp: (_) {
                              controller.editProfileRelease();
                              Get.to(() => EditProfileScreen());
                            },
                            onTapCancel: () {
                              controller.editProfileCancel();
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 150),
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: controller.isEditHovered.value
                                    ? RidenColors.brandRed.withOpacity(0.85)
                                    : RidenColors.brandRed,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: RidenColors.brandRed.withOpacity(
                                      controller.isEditHovered.value
                                          ? 0.5
                                          : 0.3,
                                    ),
                                    blurRadius: controller.isEditHovered.value
                                        ? 12
                                        : 8,
                                    offset: Offset(
                                      0,
                                      controller.isEditHovered.value ? 6 : 4,
                                    ),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 16,
                                  ),
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
                        // Email Card
                        _buildInfoCard(
                          icon: Icons.email,
                          label: 'Email',
                          value: 'example@gmail.com',
                        ),

                        SizedBox(height: 16),

                        // Phone Number Card
                        _buildInfoCard(
                          icon: Icons.phone,
                          label: 'Phone Number',
                          value: '+1 2345678946',
                        ),

                        SizedBox(height: 16),

                        // Gender Card
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
          // Icon
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

          // Info
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

// ✅ EDIT PROFILE SCREEN - GETX
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
          // ✅ Dark glassy background
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

                  // Profile Picture Section with Camera Icon
                  Center(
                    child: Stack(
                      children: [
                        // Profile Picture
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

                        // Camera Icon Button
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ✅ Full Name - READ ONLY with dialog trigger
                        GestureDetector(
                          onTap: () {
                            controller.showNameEditDialog();
                          },
                          child: _buildFormSection(
                            label: 'Full Name',
                            controller: controller.fullNameController,
                            icon: Icons.person,
                            isReadOnly: true,
                            onTap: () {
                              controller.showNameEditDialog();
                            },
                          ),
                        ),

                        SizedBox(height: 20),

                        // Email
                        _buildFormSection(
                          label: 'Email',
                          controller: controller.emailController,
                          icon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                        ),

                        SizedBox(height: 20),

                        // Phone Number
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Phone Number*',
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
                                  // Country Code
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 14,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          '🇨🇦',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        SizedBox(width: 6),
                                        Text(
                                          '+1',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: RidenColors.textPrimary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Divider
                                  Container(
                                    width: 1,
                                    height: 24,
                                    color: Colors.white.withOpacity(0.1),
                                  ),

                                  // Phone Input
                                  Expanded(
                                    child: TextField(
                                      controller: controller.phoneController,
                                      keyboardType: TextInputType.phone,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: RidenColors.textPrimary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Phone number',
                                        hintStyle: TextStyle(
                                          color: Colors.white.withOpacity(0.4),
                                        ),
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
                        ),

                        SizedBox(height: 20),

                        // Gender Dropdown
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Gender',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: RidenColors.textSecondary,
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(height: 10),
                            Obx(
                              () => Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.15),
                                    width: 1.5,
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: controller.selectedGender.value,
                                    isExpanded: true,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: RidenColors.textPrimary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    dropdownColor: Color(0xFF2a2a3a),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 14,
                                    ),
                                    items: [
                                      DropdownMenuItem(
                                        value: 'Male',
                                        child: Text('Male'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Female',
                                        child: Text('Female'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Other',
                                        child: Text('Other'),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      if (value != null) {
                                        controller.setGender(value);
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 32),

                  // Update Button
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Obx(
                      () => GestureDetector(
                        onTapDown: (_) {
                          controller.setUpdatePressed(true);
                        },
                        onTapUp: (_) {
                          controller.setUpdatePressed(false);
                          controller.updateProfile();
                        },
                        onTapCancel: () {
                          controller.setUpdatePressed(false);
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 150),
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: controller.isUpdatePressed.value
                                ? RidenColors.brandRed.withOpacity(0.85)
                                : RidenColors.brandRed,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: RidenColors.brandRed.withOpacity(
                                  controller.isUpdatePressed.value ? 0.6 : 0.4,
                                ),
                                blurRadius: controller.isUpdatePressed.value
                                    ? 20
                                    : 15,
                                offset: Offset(
                                  0,
                                  controller.isUpdatePressed.value ? 10 : 8,
                                ),
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
    bool isReadOnly = false,
    VoidCallback? onTap,
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
        GestureDetector(
          onTap: isReadOnly ? onTap : null,
          child: Container(
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
                // Icon
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  child: Icon(icon, color: RidenColors.brandRed, size: 20),
                ),

                // Divider
                Container(
                  width: 1,
                  height: 24,
                  color: Colors.white.withOpacity(0.1),
                ),

                // Input Field or Text
                Expanded(
                  child: isReadOnly
                      ? // ✅ Read-only text display
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 14,
                          ),
                          child: Text(
                            controller.text,
                            style: TextStyle(
                              fontSize: 14,
                              color: RidenColors.textPrimary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      : // Editable text field
                        TextField(
                          controller: controller,
                          keyboardType: keyboardType,
                          style: TextStyle(
                            fontSize: 14,
                            color: RidenColors.textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            hintText: label,
                            hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.4),
                            ),
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
        ),
      ],
    );
  }
}
