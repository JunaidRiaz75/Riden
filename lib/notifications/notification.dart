// notifications_screen.dart
import 'dart:ui';

import 'package:Riden/call_and_chat/chat_screen.dart';
import 'package:Riden/my_profile/profile_setting/profile_settings_bottom_sheet.dart';
import 'package:Riden/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:Riden/widgets/riden_bottom_nav.dart';

// 🔔 NOTIFICATIONS BOTTOM SHEET ENTRY
class NotificationsBottomSheetEntry extends StatelessWidget {
  const NotificationsBottomSheetEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      snap: true,
      snapSizes: const [0.5, 0.85, 0.95],
      builder: (context, sc) => NotificationsBottomSheet(scrollController: sc),
    );
  }
}

// 🔔 NOTIFICATIONS BOTTOM SHEET CONTENT
class NotificationsBottomSheet extends StatefulWidget {
  final ScrollController scrollController;
  const NotificationsBottomSheet({
    super.key,
    required this.scrollController,
  });

  @override
  State<NotificationsBottomSheet> createState() => _NotificationsBottomSheetState();
}

class _NotificationsBottomSheetState extends State<NotificationsBottomSheet> {
  int _selectedNavIndex = 2; // Notifications tab selected

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(28),
        topRight: Radius.circular(28),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          fit: StackFit.expand,
          children: [
            // ✅ Dark glassy background
            const Positioned.fill(child: RidenDarkBackground()),

            // ✅ Blurry overlay for "frosted glass" effect
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
                child: Container(
                  color: Colors.white.withOpacity(0.06),
                ),
              ),
            ),

            Column(
              children: [
                // Drag handle
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
                // Header with Back Button
                Padding(
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
                            const Icon(
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
                        child: const Text(
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
                    controller: widget.scrollController,
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

        // ✅ Standardized Bottom Nav
        bottomNavigationBar: RidenBottomNav(
          selectedIndex: 2,
          isFromSheet: true,
        ),
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


