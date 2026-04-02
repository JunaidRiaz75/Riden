// notifications_screen.dart
import 'dart:ui';

import 'package:Riden/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:Riden/widgets/riden_bottom_nav.dart';

// 🔔 NOTIFICATIONS BOTTOM SHEET ENTRY
class NotificationsBottomSheetEntry extends StatelessWidget {
  const NotificationsBottomSheetEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.50,
      maxChildSize: 1.0,
      expand: false,
      snap: true,
      snapSizes: const [0.50, 0.85, 1.0],
      builder: (context, scrollController) {
        return NotificationsBottomSheet(scrollController: scrollController);
      },
    );
  }
}

// 🔔 NOTIFICATIONS BOTTOM SHEET CONTENT
class NotificationsBottomSheet extends StatefulWidget {
  final ScrollController scrollController;
  const NotificationsBottomSheet({super.key, required this.scrollController});

  @override
  State<NotificationsBottomSheet> createState() =>
      _NotificationsBottomSheetState();
}

class _NotificationsBottomSheetState extends State<NotificationsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double sheetH = constraints.maxHeight;
        final double sheetW = constraints.maxWidth;

        // progress: 0.0 = min collapsed, 1.0 = full screen
        final double minH = screenHeight * 0.50;
        final double maxH = screenHeight * 1.00;
        final double progress =
            ((sheetH - minH) / (maxH - minH)).clamp(0.0, 1.0);

        // Corners flatten as sheet goes full screen
        final double cornerRadius = 32.0 * (1.0 - progress);

        return ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(cornerRadius),
            topRight: Radius.circular(cornerRadius),
          ),
          child: SizedBox(
            width: sheetW,
            height: sheetH,
            child: Stack(
              children: [
                // ── 1. Gradient background ──
                Positioned.fill(
                  child: CustomPaint(painter: _SheetGradientPainter()),
                ),

                // ── 2. Frosted glass blur layer ──
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        border: Border(
                          top: BorderSide(
                            color: Colors.white.withOpacity(0.15),
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // ── 3. Foreground content ──
                Column(
                  children: [
                    // Drag handle
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 8),
                      child: Center(
                        child: Container(
                          width: 45,
                          height: 4.5,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(2.5),
                          ),
                        ),
                      ),
                    ),

                    // Header: "< Back  Notifications  Mark all as read"
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      child: Row(
                        children: [
                          // Back button
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.chevron_left,
                                  color: Colors.white,
                                  size: 26,
                                ),
                                Text(
                                  'Back',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Title centered
                          Expanded(
                            child: Center(
                              child: Text(
                                'Notifications',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
                          // Mark all as read
                          GestureDetector(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('All notifications marked as read'),
                                  backgroundColor: RidenColors.brandRed,
                                  duration: Duration(milliseconds: 800),
                                ),
                              );
                            },
                            child: Text(
                              'Mark all as read',
                              style: GoogleFonts.poppins(
                                fontSize: 9,
                                fontWeight: FontWeight.w500,
                                color: RidenColors.brandRed,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

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
                              const SizedBox(height: 16),
                              _buildNotificationItem(
                                icon: Icons.account_balance_wallet_rounded,
                                title: 'Payment Successfully!',
                                description:
                                    'Lorem ipsum dolor sit amet consectetur. Ultrici es tincidunt eleifend vitae',
                                time: '8:29 pm',
                              ),
                              _buildNotificationItem(
                                icon: Icons.local_offer_rounded,
                                title: '30% Special Discount!',
                                description:
                                    'Lorem ipsum dolor sit amet consectetur. Ultrici es tincidunt eleifend vitae',
                                time: '8:29 pm',
                              ),

                              const SizedBox(height: 24),

                              // 📅 YESTERDAY SECTION
                              _buildSectionHeader('Yesterday'),
                              const SizedBox(height: 16),
                              _buildNotificationItem(
                                icon: Icons.account_balance_wallet_rounded,
                                title: 'Payment Successfully!',
                                description:
                                    'Lorem ipsum dolor sit amet consectetur. Ultrici es tincidunt eleifend vitae',
                                time: '8:29 pm',
                              ),
                              _buildNotificationItem(
                                icon: Icons.credit_card_rounded,
                                title: 'Credit Card added!',
                                description:
                                    'Lorem ipsum dolor sit amet consectetur. Ultrici es tincidunt eleifend vitae',
                                time: '8:29 pm',
                              ),
                              _buildNotificationItem(
                                icon: Icons.account_balance_wallet_rounded,
                                title: 'Added Money wallet Successfully!',
                                description:
                                    'Lorem ipsum dolor sit amet consectetur. Ultrici es tincidunt eleifend vitae',
                                time: '8:29 pm',
                              ),
                              _buildNotificationItem(
                                icon: Icons.local_offer_rounded,
                                title: '5% Special Discount!',
                                description:
                                    'Lorem ipsum dolor sit amet consectetur. Ultrici es tincidunt eleifend vitae',
                                time: '8:29 pm',
                              ),

                              const SizedBox(height: 100), // Space for bottom nav
                            ],
                          ),
                        ),
                      ),
                    ),

                    // ✅ Standardized Bottom Nav
                    RidenBottomNav(
                      selectedIndex: 2,
                      isFromSheet: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ✅ Section Header Widget
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  // ✅ Notification Item Widget
  Widget _buildNotificationItem({
    required IconData icon,
    required String title,
    required String description,
    required String time,
  }) {
    return GestureDetector(
      onTap: () {
        // Handle notification tap
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Icon Container
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: RidenColors.brandRed.withOpacity(0.12),
              ),
              child: Center(
                child: Icon(icon, color: RidenColors.brandRed, size: 24),
              ),
            ),

            const SizedBox(width: 14),

            // ✅ Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Description
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.white.withOpacity(0.5),
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            // ✅ Time
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                time,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// GRADIENT PAINTER — consistency with Chat/Call screens
// ─────────────────────────────────────────────────────────────────────────────
class _SheetGradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Base: dark navy
    canvas.drawRect(
      Rect.fromLTWH(0, 0, w, h),
      Paint()..color = const Color(0xFF1A1B2E),
    );

    // Warm copper glow — top-left
    _radialBlob(
      canvas,
      center: Offset(w * 0.15, h * 0.30),
      rx: w * 0.80,
      ry: h * 0.60,
      color: const Color(0xFF8B4A35),
      alpha: 170,
    );

    // Teal glow — bottom-right
    _radialBlob(
      canvas,
      center: Offset(w * 0.85, h * 0.75),
      rx: w * 0.80,
      ry: h * 0.60,
      color: const Color(0xFF2E6B72),
      alpha: 170,
    );
  }

  void _radialBlob(
    Canvas canvas, {
    required Offset center,
    required double rx,
    required double ry,
    required Color color,
    required int alpha,
  }) {
    final solid = Color.fromARGB(alpha, color.red, color.green, color.blue);
    final clear = Color.fromARGB(0, color.red, color.green, color.blue);

    final paint = Paint()
      ..shader = RadialGradient(colors: [solid, clear]).createShader(
        Rect.fromCenter(center: center, width: rx * 2, height: ry * 2),
      );

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.scale(1.0, ry / rx);
    canvas.translate(-center.dx, -center.dy);
    canvas.drawCircle(center, rx, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_SheetGradientPainter _) => false;
}
