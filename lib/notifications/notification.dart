// notifications_screen.dart
import 'dart:ui';

import 'package:Riden/call_and_chat/chat_screen.dart';
import 'package:Riden/my_profile/profile_setting/profile_settings_bottom_sheet.dart';
import 'package:Riden/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 🔔 NOTIFICATIONS SCREEN - DARK GLASSY THEME
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({
    super.key,
    required ScrollController scrollController,
  });

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  int _selectedNavIndex = 2; // Notifications tab selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RidenColors.backgroundBase,
      extendBody: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ✅ Dark glassy background
          const RidenDarkBackground(),

          Column(
            children: [
              // ✅ Header with Back Button
              SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_back_ios,
                              color: RidenColors.textPrimary,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
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
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('All notifications marked as read'),
                              backgroundColor: RidenColors.brandRed,
                              duration: Duration(milliseconds: 800),
                            ),
                          );
                        },
                        child: Text(
                          'Mark all as read',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: RidenColors.brandRed,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ✅ Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Notifications',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: RidenColors.textPrimary,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ✅ Notifications List
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 📅 TODAY SECTION
                        _buildSectionHeader('Today'),
                        const SizedBox(height: 12),
                        _buildNotificationItem(
                          icon: Icons.wallet_rounded,
                          title: 'Payment Successfully!',
                          description:
                              'Your payment of \$45.00 has been processed successfully for your ride.',
                          time: '8:29 pm',
                          isRead: false,
                          context: context,
                        ),
                        const SizedBox(height: 12),
                        _buildNotificationItem(
                          icon: Icons.local_offer_rounded,
                          title: '30% Special Discount!',
                          description:
                              'Enjoy 30% off on your next ride. Limited time offer!',
                          time: '8:29 pm',
                          isRead: false,
                          context: context,
                        ),

                        const SizedBox(height: 24),

                        // 📅 YESTERDAY SECTION
                        _buildSectionHeader('Yesterday'),
                        const SizedBox(height: 12),
                        _buildNotificationItem(
                          icon: Icons.wallet_rounded,
                          title: 'Payment Successfully!',
                          description:
                              'Your payment of \$35.00 has been processed successfully for your ride.',
                          time: '8:29 pm',
                          isRead: true,
                          context: context,
                        ),
                        const SizedBox(height: 12),
                        _buildNotificationItem(
                          icon: Icons.credit_card_rounded,
                          title: 'Credit Card added!',
                          description:
                              'Your credit card ending in 1234 has been successfully added.',
                          time: '8:29 pm',
                          isRead: true,
                          context: context,
                        ),
                        const SizedBox(height: 12),
                        _buildNotificationItem(
                          icon: Icons.account_balance_wallet_rounded,
                          title: 'Added Money wallet Successfully!',
                          description:
                              '\$50.00 has been added to your wallet successfully.',
                          time: '8:29 pm',
                          isRead: true,
                          context: context,
                        ),
                        const SizedBox(height: 12),
                        _buildNotificationItem(
                          icon: Icons.local_offer_rounded,
                          title: '5% Special Discount!',
                          description:
                              'Get 5% cashback on your next ride. Limited time offer!',
                          time: '8:29 pm',
                          isRead: true,
                          context: context,
                        ),

                        const SizedBox(height: 24),

                        // 📅 DATE SECTION
                        _buildSectionHeader('May, 27 2023'),
                        const SizedBox(height: 12),
                        _buildNotificationItem(
                          icon: Icons.wallet_rounded,
                          title: 'Payment Successfully!',
                          description:
                              'Your payment of \$25.00 has been processed successfully for your ride.',
                          time: '8:29 pm',
                          isRead: true,
                          context: context,
                        ),

                        const SizedBox(height: 100), // Space for bottom nav
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

      // ✅ BOTTOM NAVIGATION BAR (custom, matching ride sheet)
      bottomNavigationBar: _HomeBottomNav(
        selectedIndex: _selectedNavIndex,
        onChanged: (index) {
          setState(() {
            _selectedNavIndex = index;
          });

          // Handle navigation
          if (index == 0) {
            // Ride tab – go to home screen
            Get.offAllNamed('/home');
          } else if (index == 1) {
            // Support tab – open chat bottom sheet
            _openChatBottomSheet(context);
          } else if (index == 2) {
            // Already on notifications
          } else if (index == 3) {
            // Account tab – open profile settings bottom sheet
            Get.to(
              () => ProfileSettingsBottomSheet(
                scrollController: ScrollController(),
              ),
            );
          }
        },
      ),
    );
  }

  void _openChatBottomSheet(BuildContext context) {
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
            return ChatBottomSheet(scrollController: scrollController);
          },
        );
      },
    );
  }

  // ✅ Section Header Widget
  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: RidenColors.textSecondary,
        letterSpacing: 0.5,
      ),
    );
  }

  // ✅ Notification Item Widget
  Widget _buildNotificationItem({
    required IconData icon,
    required String title,
    required String description,
    required String time,
    required bool isRead,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: () {
        // Mark as read when tapped
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(title),
            backgroundColor: RidenColors.brandRed,
            duration: const Duration(milliseconds: 800),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: isRead
              ? Colors.white.withOpacity(0.05)
              : Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isRead
                ? Colors.white.withOpacity(0.08)
                : RidenColors.brandRed.withOpacity(0.3),
            width: isRead ? 1 : 1.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ Icon Container with unread indicator
              Stack(
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
                  if (!isRead)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: RidenColors.brandRed,
                          border: Border.all(
                            color: RidenColors.backgroundBase,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(width: 12),

              // ✅ Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isRead ? FontWeight.w600 : FontWeight.w700,
                        color: RidenColors.textPrimary,
                      ),
                    ),

                    const SizedBox(height: 4),

                    // Description
                    Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: isRead
                            ? RidenColors.textSecondary.withOpacity(0.8)
                            : RidenColors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // ✅ Time
              Text(
                time,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: isRead
                      ? RidenColors.textHint.withOpacity(0.7)
                      : RidenColors.textHint,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// BOTTOM NAVIGATION BAR – dark icons/text, centered, no overflow
// ─────────────────────────────────────────────────────────────────────────────
class _HomeBottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const _HomeBottomNav({required this.selectedIndex, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 17),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(
                0.58,
              ), // bright white for dark text
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: Colors.white.withOpacity(0.7),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 12,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  children: [
                    _NItem(
                      0,
                      Icons.directions_car_rounded,
                      'Ride',
                      selectedIndex,
                      onChanged,
                    ),
                    _NItem(
                      1,
                      Icons.support_agent_rounded,
                      'Support',
                      selectedIndex,
                      onChanged,
                    ),
                    _NItem(
                      2,
                      Icons.receipt_long_rounded,
                      'Bookings',
                      selectedIndex,
                      onChanged,
                    ),
                    _NItem(
                      3,
                      Icons.person_outline_rounded,
                      'Account',
                      selectedIndex,
                      onChanged,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NItem extends StatelessWidget {
  final int index;
  final IconData icon;
  final String label;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const _NItem(
    this.index,
    this.icon,
    this.label,
    this.selectedIndex,
    this.onChanged,
  );

  @override
  Widget build(BuildContext context) {
    final bool active = selectedIndex == index;
    final Color iconColor = active
        ? const Color(0xFFE53935) // red when active
        : const Color.fromARGB(255, 24, 30, 36); // dark blue‑grey when inactive
    final Color labelColor = active
        ? const Color(0xFFE53935)
        : const Color.fromARGB(255, 24, 30, 36);

    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(index),
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 1,
          ), // reduced to prevent overflow
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, color: iconColor, size: 24),
              const SizedBox(height: 6),
              Text(
                label,
                style: TextStyle(
                  color: labelColor,
                  fontSize: 12,
                  fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
