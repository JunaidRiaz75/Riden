import 'package:Riden/my_profile/profile_setting/edit_profile_bottom_sheet.dart';
import 'package:Riden/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileSettingsBottomSheet extends StatelessWidget {
  final ScrollController scrollController;
  const ProfileSettingsBottomSheet({required this.scrollController, super.key});

  void _openEditProfileSheet(BuildContext context) {
    Navigator.pop(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.88,
        minChildSize: 0.45,
        maxChildSize: 0.95,
        snap: true,
        snapSizes: const [0.45, 0.88, 0.95],
        builder: (context, sc) => EditProfileBottomSheet(scrollController: sc),
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
              // Content
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
                        // Heading and Edit pic
                        Center(
                          child: Stack(
                            children: [
                              // Profile Pic
                              Container(
                                width: 90,
                                height: 90,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: RidenColors.brandRed,
                                    width: 3,
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
                              // Edit Button
                              Positioned(
                                bottom: 2,
                                right: 2,
                                child: GestureDetector(
                                  onTap: () => _openEditProfileSheet(context),
                                  child: Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: RidenColors.brandRed,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: RidenColors.brandRed
                                              .withOpacity(0.28),
                                          blurRadius: 8,
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),
                        Center(
                          child: Text(
                            'jesse Showalter',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontSize: 21,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Center(
                          child: Text(
                            'Columbia, Canada',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.white54,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Example Data
                        ProfileInfoTile(
                          icon: Icons.email,
                          label: 'Email',
                          value: 'jesse@gmail.com',
                        ),
                        const SizedBox(height: 13),
                        ProfileInfoTile(
                          icon: Icons.phone,
                          label: 'Phone Number',
                          value: '+1 2345678901',
                        ),
                        const SizedBox(height: 13),
                        ProfileInfoTile(
                          icon: Icons.wc_rounded,
                          label: 'Gender',
                          value: 'Male',
                        ),
                        const SizedBox(height: 23),
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
}

class ProfileInfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const ProfileInfoTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withOpacity(0.13), width: 1),
      ),
      padding: const EdgeInsets.all(13),
      child: Row(
        children: [
          Icon(icon, color: RidenColors.brandRed, size: 22),
          const SizedBox(width: 11),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
