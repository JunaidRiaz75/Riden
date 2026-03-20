import 'package:flutter/material.dart';
import 'package:riden/theme/riden_theme.dart';

// 🔔 NOTIFICATIONS SCREEN - DARK GLASSY THEME
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RidenColors.backgroundBase,
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
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('All marked as read'),
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
                padding: EdgeInsets.symmetric(horizontal: 20),
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

              SizedBox(height: 24),

              // ✅ Notifications List
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 📅 TODAY SECTION
                        _buildSectionHeader('Today'),
                        SizedBox(height: 12),
                        _buildNotificationItem(
                          icon: Icons.wallet,
                          title: 'Payment Successfully!',
                          description:
                              'Lorem ipsum dolor sit amet consectetur. Ultricies tincidunt eifend vitae',
                          time: '8:29 pm',
                          context: context,
                        ),
                        SizedBox(height: 12),
                        _buildNotificationItem(
                          icon: Icons.local_offer,
                          title: '30% Special Discount!',
                          description:
                              'Lorem ipsum dolor sit amet consectetur. Ultricies tincidunt eifend vitae',
                          time: '8:29 pm',
                          context: context,
                        ),

                        SizedBox(height: 24),

                        // 📅 YESTERDAY SECTION
                        _buildSectionHeader('Yesterday'),
                        SizedBox(height: 12),
                        _buildNotificationItem(
                          icon: Icons.wallet,
                          title: 'Payment Successfully!',
                          description:
                              'Lorem ipsum dolor sit amet consectetur. Ultricies tincidunt eifend vitae',
                          time: '8:29 pm',
                          context: context,
                        ),
                        SizedBox(height: 12),
                        _buildNotificationItem(
                          icon: Icons.credit_card,
                          title: 'Credit Card added!',
                          description:
                              'Lorem ipsum dolor sit amet consectetur. Ultricies tincidunt eifend vitae',
                          time: '8:29 pm',
                          context: context,
                        ),
                        SizedBox(height: 12),
                        _buildNotificationItem(
                          icon: Icons.account_balance_wallet,
                          title: 'Added Money wallet Successfully!',
                          description:
                              'Lorem ipsum dolor sit amet consectetur. Ultricies tincidunt eifend vitae',
                          time: '8:29 pm',
                          context: context,
                        ),
                        SizedBox(height: 12),
                        _buildNotificationItem(
                          icon: Icons.local_offer,
                          title: '5% Special Discount!',
                          description:
                              'Lorem ipsum dolor sit amet consectetur. Ultricies tincidunt eifend vitae',
                          time: '8:29 pm',
                          context: context,
                        ),

                        SizedBox(height: 24),

                        // 📅 DATE SECTION
                        _buildSectionHeader('May, 27 2023'),
                        SizedBox(height: 12),
                        _buildNotificationItem(
                          icon: Icons.wallet,
                          title: 'Payment Successfully!',
                          description:
                              'Lorem ipsum dolor sit amet consectetur. Ultricies tincidunt eifend vitae',
                          time: '8:29 pm',
                          context: context,
                        ),

                        SizedBox(height: 80), // Space for bottom nav
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

      // ✅ BOTTOM NAVIGATION BAR - SAMPLE (DARK GLASSY THEME)
      bottomNavigationBar: _buildBottomNavigationBar(context),
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
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(title),
            backgroundColor: RidenColors.brandRed,
            duration: Duration(milliseconds: 800),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white.withOpacity(0.12), width: 1.5),
        ),
        padding: EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Icon Container
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

            SizedBox(width: 12),

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
                      fontWeight: FontWeight.w700,
                      color: RidenColors.textPrimary,
                    ),
                  ),

                  SizedBox(height: 4),

                  // Description
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: RidenColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: 8),

            // ✅ Time
            Text(
              time,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: RidenColors.textHint,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ BOTTOM NAVIGATION BAR - SAMPLE
  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        border: Border(
          top: BorderSide(color: Colors.white.withOpacity(0.1), width: 1.5),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Bookings
              _buildNavItem(
                icon: Icons.calendar_today,
                label: 'Bookings',
                isActive: false,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Bookings'),
                      backgroundColor: RidenColors.brandRed,
                      duration: Duration(milliseconds: 800),
                    ),
                  );
                },
              ),

              // Support
              _buildNavItem(
                icon: Icons.support_agent,
                label: 'Support',
                isActive: false,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Support'),
                      backgroundColor: RidenColors.brandRed,
                      duration: Duration(milliseconds: 800),
                    ),
                  );
                },
              ),

              // Notifications (Active)
              _buildNavItem(
                icon: Icons.notifications,
                label: 'Notifications',
                isActive: true,
                onTap: () {},
              ),

              // Account
              _buildNavItem(
                icon: Icons.account_circle,
                label: 'Account',
                isActive: false,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Account'),
                      backgroundColor: RidenColors.brandRed,
                      duration: Duration(milliseconds: 800),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ✅ Navigation Item Widget
  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive
                  ? RidenColors.brandRed.withOpacity(0.2)
                  : Colors.transparent,
            ),
            child: Icon(
              icon,
              color: isActive
                  ? RidenColors.brandRed
                  : RidenColors.textSecondary,
              size: 24,
            ),
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: isActive
                  ? RidenColors.brandRed
                  : RidenColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
