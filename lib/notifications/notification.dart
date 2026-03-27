// notifications_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riden/bookings/my_bookings_screen.dart'; // Import the chat bottom sheet
import 'package:riden/call_and_chat/chat_screen.dart';
import 'package:riden/my_profile/profile_setting/profile_settings_bottom_sheet.dart';
import 'package:riden/theme/app_colors.dart';
import 'package:riden/widgets/glass_bottom_nav.dart';

// 🔔 NOTIFICATIONS SCREEN - DARK GLASSY THEME
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

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

      // ✅ BOTTOM NAVIGATION BAR
      bottomNavigationBar: GlassBottomNav(
        selectedIndex: _selectedNavIndex,
        onTap: (index) {
          setState(() {
            _selectedNavIndex = index;
          });

          // Handle navigation
          if (index == 0) {
            Get.offAllNamed('/home');
          } else if (index == 1) {
            Get.to(() => const MyBookingsScreen());
          } else if (index == 2) {
            // Already on notifications
          } else if (index == 3) {
            // Open Chat as Bottom Sheet instead of using Get.to()
            _openChatBottomSheet(context);
          } else if (index == 4) {
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
