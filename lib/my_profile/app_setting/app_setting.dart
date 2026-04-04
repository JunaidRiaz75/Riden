// app_settings_bottom_sheet.dart
import 'package:Riden/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// For navigating to Change Password
import 'change_password_bottom_sheet.dart';
import 'package:Riden/widgets/riden_bottom_nav.dart';

class AppSettingsBottomSheet extends StatelessWidget {
  final ScrollController scrollController;

  const AppSettingsBottomSheet({required this.scrollController, super.key});

  void _openChangePasswordSheet(BuildContext context) {
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
        builder: (context, sc) =>
            ChangePasswordBottomSheet(scrollController: sc),
      ),
    );
  }

  Widget _buildSettingsRow({required IconData icon, required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: RidenColors.brandRed, size: 22),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.poppins(
                  color: Colors.black87,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: RidenColors.brandRed,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(28),
        topRight: Radius.circular(28),
      ),
      child: Stack(
        children: [
          const Positioned.fill(child: RidenDarkBackground()),
          // Main content
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
              // Header, Rows, etc.
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                            const SizedBox(width: 14),
                            Text(
                              'App Settings',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Unified Settings Container
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.58),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.white.withOpacity(0.8), width: 1.5),
                          ),
                          child: Column(
                            children: [
                              _buildSettingsRow(
                                icon: Icons.lock,
                                label: 'Change Password',
                                onTap: () => _openChangePasswordSheet(context),
                              ),
                              const Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: Divider(color: Colors.black12, height: 1)),
                              _buildSettingsRow(
                                icon: Icons.star,
                                label: 'Rate The App',
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Rate App feature', style: GoogleFonts.poppins()),
                                      backgroundColor: RidenColors.brandRed,
                                      duration: const Duration(milliseconds: 800),
                                    ),
                                  );
                                },
                              ),
                              const Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: Divider(color: Colors.black12, height: 1)),
                              _buildSettingsRow(
                                icon: Icons.share,
                                label: 'Share App',
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Share App feature', style: GoogleFonts.poppins()),
                                      backgroundColor: RidenColors.brandRed,
                                      duration: const Duration(milliseconds: 800),
                                    ),
                                  );
                                },
                              ),
                              const Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: Divider(color: Colors.black12, height: 1)),
                              _buildSettingsRow(
                                icon: Icons.logout,
                                label: 'Logout',
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Logging out...', style: GoogleFonts.poppins()),
                                      backgroundColor: RidenColors.brandRed,
                                      duration: const Duration(milliseconds: 800),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 100), // Spacing for BottomNav
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // ── Standardized Bottom Nav ──
          Align(
            alignment: Alignment.bottomCenter,
            child: RidenBottomNav(selectedIndex: 4, isFromSheet: true),
          ),
        ],
      ),
    );
  }
}
