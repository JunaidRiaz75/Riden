// app_settings_bottom_sheet.dart
import 'package:flutter/material.dart';
import 'package:riden/theme/app_colors.dart';

class AppSettingsBottomSheet extends StatelessWidget {
  final ScrollController scrollController;

  const AppSettingsBottomSheet({required this.scrollController, super.key});

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
          // App Settings Content
          Expanded(
            child: AppSettingsBottomSheetContent(
              scrollController: scrollController,
            ),
          ),
        ],
      ),
    );
  }
}

class AppSettingsBottomSheetContent extends StatefulWidget {
  final ScrollController scrollController;

  const AppSettingsBottomSheetContent({
    required this.scrollController,
    super.key,
  });

  @override
  State<AppSettingsBottomSheetContent> createState() =>
      _AppSettingsBottomSheetContentState();
}

class _AppSettingsBottomSheetContentState
    extends State<AppSettingsBottomSheetContent> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.scrollController,
      physics: const ClampingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
            child: Text(
              'App Settings',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: RidenColors.textPrimary,
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Menu Items
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                // Change Password
                _buildMenuItemWithArrow(
                  icon: Icons.lock,
                  label: 'Change Password',
                  onTap: () {
                    _openChangePasswordSheet(context);
                  },
                ),

                const SizedBox(height: 12),

                // Share App
                _buildMenuItemWithArrow(
                  icon: Icons.share,
                  label: 'Share App',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Share App feature'),
                        backgroundColor: RidenColors.brandRed,
                        duration: Duration(milliseconds: 800),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 12),

                // Rate the app
                _buildMenuItemWithArrow(
                  icon: Icons.star,
                  label: 'Rate the app',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Rate App feature'),
                        backgroundColor: RidenColors.brandRed,
                        duration: Duration(milliseconds: 800),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 12),

                // Logout
                _buildMenuItemWithArrow(
                  icon: Icons.logout,
                  label: 'Logout',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Logging out...'),
                        backgroundColor: RidenColors.brandRed,
                        duration: Duration(milliseconds: 800),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItemWithArrow({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.12), width: 1.5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
                child: Icon(icon, color: RidenColors.brandRed, size: 20),
              ),
            ),

            const SizedBox(width: 14),

            // Label
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: RidenColors.textPrimary,
                ),
              ),
            ),

            // Arrow
            Icon(
              Icons.arrow_forward_ios,
              color: RidenColors.textSecondary,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  void _openChangePasswordSheet(BuildContext context) {
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
            return ChangePasswordBottomSheet(
              scrollController: scrollController,
            );
          },
        );
      },
    );
  }
}

// Change Password Bottom Sheet
class ChangePasswordBottomSheet extends StatelessWidget {
  final ScrollController scrollController;

  const ChangePasswordBottomSheet({required this.scrollController, super.key});

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
          // Change Password Content
          Expanded(
            child: ChangePasswordContent(scrollController: scrollController),
          ),
        ],
      ),
    );
  }
}

// Change Password Content
class ChangePasswordContent extends StatefulWidget {
  final ScrollController scrollController;

  const ChangePasswordContent({required this.scrollController, super.key});

  @override
  State<ChangePasswordContent> createState() => _ChangePasswordContentState();
}

class _ChangePasswordContentState extends State<ChangePasswordContent> {
  late TextEditingController _phoneController;
  bool _isSendOtpPressed = false;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.scrollController,
      physics: const ClampingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Change Password',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: RidenColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter your Phone Number to change Your Password',
                  style: TextStyle(
                    fontSize: 14,
                    color: RidenColors.textSecondary,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Phone Input
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Phone Number',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: RidenColors.textSecondary,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 10),
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                        child: Row(
                          children: [
                            const Text('🇨🇦', style: TextStyle(fontSize: 18)),
                            const SizedBox(width: 6),
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
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          style: TextStyle(
                            fontSize: 14,
                            color: RidenColors.textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            hintText: '00000000',
                            hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.4),
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
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
          ),

          const SizedBox(height: 28),

          // Send OTP Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTapDown: (_) {
                setState(() {
                  _isSendOtpPressed = true;
                });
              },
              onTapUp: (_) {
                setState(() {
                  _isSendOtpPressed = false;
                });
                _openVerificationSheet(context);
              },
              onTapCancel: () {
                setState(() {
                  _isSendOtpPressed = false;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: _isSendOtpPressed
                      ? RidenColors.brandRed.withOpacity(0.85)
                      : RidenColors.brandRed,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: RidenColors.brandRed.withOpacity(
                        _isSendOtpPressed ? 0.6 : 0.4,
                      ),
                      blurRadius: _isSendOtpPressed ? 20 : 15,
                      offset: Offset(0, _isSendOtpPressed ? 10 : 8),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'Send OTP',
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

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  void _openVerificationSheet(BuildContext context) {
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
            return VerificationBottomSheet(scrollController: scrollController);
          },
        );
      },
    );
  }
}

// Verification Bottom Sheet (simplified version)
class VerificationBottomSheet extends StatelessWidget {
  final ScrollController scrollController;

  const VerificationBottomSheet({required this.scrollController, super.key});

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
                'Verification Screen',
                style: TextStyle(color: RidenColors.textPrimary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
