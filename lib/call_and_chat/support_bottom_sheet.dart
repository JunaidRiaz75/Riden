// support_bottom_sheet.dart
// ignore_for_file: use_super_parameters, deprecated_member_use

import 'dart:ui';

import 'package:Riden/call_and_chat/chat_screen.dart';
import 'package:Riden/call_and_chat/complaint_ticket_bottom_sheet.dart';
import 'package:Riden/call_and_chat/helpline_bottom_sheet.dart';
import 'package:Riden/widgets/riden_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ENTRY — used by showModalBottomSheet
// ─────────────────────────────────────────────────────────────────────────────
class SupportBottomSheetEntry extends StatelessWidget {
  const SupportBottomSheetEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.45,
      minChildSize: 0.35,
      maxChildSize: 1.0,
      expand: false,
      snap: true,
      snapSizes: const [0.35, 0.45, 1.0],
      builder: (context, scrollController) {
        return SupportBottomSheet(scrollController: scrollController);
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// MAIN SHEET
// ─────────────────────────────────────────────────────────────────────────────
class SupportBottomSheet extends StatelessWidget {
  final ScrollController scrollController;
  const SupportBottomSheet({required this.scrollController, super.key});

  void _openSheet(BuildContext context, Widget sheet) {
    Navigator.pop(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
      builder: (_) => sheet,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double sheetH = constraints.maxHeight;
        final double minH = screenHeight * 0.35;
        final double maxH = screenHeight * 1.00;
        final double progress =
            ((sheetH - minH) / (maxH - minH)).clamp(0.0, 1.0);
        final double cornerRadius = 28.0 * (1.0 - progress);

        return ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(cornerRadius),
            topRight: Radius.circular(cornerRadius),
          ),
          child: Stack(
            children: [
              // ── 1. Gradient background ──
              Positioned.fill(
                child: CustomPaint(painter: _SupportGradientPainter()),
              ),

              // ── 2. Frosted glass blur ──
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.06),
                      border: Border(
                        top: BorderSide(
                          color: Colors.white.withOpacity(0.18),
                          width: 1.2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // ── 3. Content ──
              Column(
                children: [
                  // Drag handle
                  AnimatedOpacity(
                    opacity: (1.0 - progress).clamp(0.0, 1.0),
                    duration: const Duration(milliseconds: 150),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 4),
                      child: Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.35),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ── Grid of action buttons ──
                          Row(
                            children: [
                              // 911 Call
                              Expanded(
                                child: _SupportActionCard(
                                  icon: Icons.phone_rounded,
                                  label: '911 Call',
                                  iconBg: const Color(0xFFE53935),
                                  onTap: () => _openSheet(
                                    context,
                                    const HelplineBottomSheetEntry(),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              // Instant Support
                              Expanded(
                                child: _SupportActionCard(
                                  icon: Icons.help_rounded,
                                  label: 'Instant Support',
                                  iconBg: const Color(0xFFE53935),
                                  onTap: () => _openSheet(
                                    context,
                                    const ChatBottomSheetEntry(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // Submit Complaint Ticket (full width)
                          _SupportActionCard(
                            icon: Icons.receipt_long_rounded,
                            label: 'Submit Complaint Ticket',
                            iconBg: const Color(0xFFE53935),
                            fullWidth: true,
                            onTap: () => _openSheet(
                              context,
                              const ComplaintTicketBottomSheetEntry(),
                            ),
                          ),

                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),

                  // Bottom Nav
                  RidenBottomNav(selectedIndex: 1),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SUPPORT ACTION CARD
// ─────────────────────────────────────────────────────────────────────────────
class _SupportActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconBg;
  final bool fullWidth;
  final VoidCallback onTap;

  const _SupportActionCard({
    required this.icon,
    required this.label,
    required this.iconBg,
    required this.onTap,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: fullWidth ? double.infinity : null,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.10),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: Colors.white.withOpacity(0.18),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                label,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// GRADIENT PAINTER — identical to chat/booking sheets
// ─────────────────────────────────────────────────────────────────────────────
class _SupportGradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    canvas.drawRect(
      Rect.fromLTWH(0, 0, w, h),
      Paint()..color = const Color(0xFF1A1B2E),
    );

    _blob(canvas,
        center: Offset(w * 0.15, h * 0.30),
        rx: w * 0.70,
        ry: h * 0.50,
        color: const Color(0xFF8B4A35),
        alpha: 170);
    _blob(canvas,
        center: Offset(w * 0.05, h * 0.55),
        rx: w * 0.50,
        ry: h * 0.35,
        color: const Color(0xFF6B3828),
        alpha: 130);
    _blob(canvas,
        center: Offset(w * 0.82, h * 0.68),
        rx: w * 0.70,
        ry: h * 0.52,
        color: const Color(0xFF2E6B72),
        alpha: 165);
    _blob(canvas,
        center: Offset(w * 0.90, h * 0.50),
        rx: w * 0.40,
        ry: h * 0.30,
        color: const Color(0xFF3D8A8F),
        alpha: 110);
    _blob(canvas,
        center: Offset(w * 0.50, h * 0.50),
        rx: w * 0.55,
        ry: h * 0.40,
        color: const Color(0xFF3A4555),
        alpha: 80);
  }

  void _blob(Canvas canvas,
      {required Offset center,
      required double rx,
      required double ry,
      required Color color,
      required int alpha}) {
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
  bool shouldRepaint(_SupportGradientPainter _) => false;
}
