// cancel_ride_bottom_sheet.dart
// ignore_for_file: use_super_parameters, deprecated_member_use

import 'dart:ui';

import 'package:Riden/widgets/riden_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ENTRY
// ─────────────────────────────────────────────────────────────────────────────
class CancelRideBottomSheetEntry extends StatelessWidget {
  const CancelRideBottomSheetEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      minChildSize: 0.50,
      maxChildSize: 1.0,
      expand: false,
      snap: true,
      snapSizes: const [0.50, 0.95, 1.0],
      builder: (context, scrollController) {
        return CancelRideBottomSheet(scrollController: scrollController);
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// MAIN SHEET
// ─────────────────────────────────────────────────────────────────────────────
class CancelRideBottomSheet extends StatefulWidget {
  final ScrollController scrollController;

  const CancelRideBottomSheet({required this.scrollController, super.key});

  @override
  State<CancelRideBottomSheet> createState() => _CancelRideBottomSheetState();
}

class _CancelRideBottomSheetState extends State<CancelRideBottomSheet> {
  String _selectedReason = 'I don\'t need a ride anymore';

  final List<String> _reasons = [
    'I don\'t need a ride anymore',
    'Driver asked me to cancel',
    'I found another ride',
    'I booked by mistake',
    'other',
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double sheetH = constraints.maxHeight;
        final double minH = screenHeight * 0.50;
        final double maxH = screenHeight * 1.00;
        final double progress = ((sheetH - minH) / (maxH - minH)).clamp(0.0, 1.0);
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
                child: CustomPaint(painter: _SheetGradientPainter()),
              ),

              // ── 2. Frosted glass blur ──
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                  child: Container(color: Colors.white.withOpacity(0.05)),
                ),
              ),

              // ── 3. Content ──
              Column(
                children: [
                  // Drag handle
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 2),
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

                  // Header with Back
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 6, 16, 8),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Row(
                            children: [
                              const Icon(Icons.arrow_back_ios_new_rounded,
                                  color: Colors.white, size: 18),
                              const SizedBox(width: 8),
                              Text(
                                'Back',
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Scrollable Content
                  Expanded(
                    child: ListView(
                      controller: widget.scrollController,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      children: [
                        const SizedBox(height: 12),
                        Text(
                          'You need to tell us why you\nwant to cancel your ride',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 32),
                        
                        // Selection List
                        ..._reasons.map((reason) => _RadioOption(
                          label: reason,
                          isSelected: _selectedReason == reason,
                          onTap: () {
                            setState(() {
                              _selectedReason = reason;
                            });
                          },
                        )),
                        
                        const SizedBox(height: 32),
                        
                        // Submit Button
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE53935),
                            minimumSize: const Size(double.infinity, 54),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                          ),
                          child: Text(
                            'Submit',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),

                  // Shared Bottom Nav Bar
                  RidenBottomNav(selectedIndex: 0),
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
// UI HELPERS
// ─────────────────────────────────────────────────────────────────────────────

class _RadioOption extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _RadioOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? const Color(0xFFE53935) : Colors.white70,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFE53935),
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: isSelected ? Colors.white : Colors.white70,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    ).animateClick();
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SHARED PAINTERS & NAV (Adapted from current system)
// ─────────────────────────────────────────────────────────────────────────────

class _SheetGradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), Paint()..color = const Color(0xFF1A1B2E));
    _blob(canvas, center: Offset(w * 0.15, h * 0.30), rx: w * 0.70, ry: h * 0.50, color: const Color(0xFF8B4A35), alpha: 170);
    _blob(canvas, center: Offset(w * 0.82, h * 0.68), rx: w * 0.70, ry: h * 0.52, color: const Color(0xFF2E6B72), alpha: 165);
  }
  void _blob(Canvas canvas, {required Offset center, required double rx, required double ry, required Color color, required int alpha}) {
    final solid = Color.fromARGB(alpha, color.red, color.green, color.blue);
    final clear = Color.fromARGB(0, color.red, color.green, color.blue);
    final paint = Paint()..shader = RadialGradient(colors: [solid, clear]).createShader(Rect.fromCenter(center: center, width: rx * 2, height: ry * 2));
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

// ─────────────────────────────────────────────────────────────────────────────
// ANIMATION EXTENSION (Simple helper)
// ─────────────────────────────────────────────────────────────────────────────
extension ClickScale on Widget {
  Widget animateClick() {
    return _ClickAnimator(child: this);
  }
}

class _ClickAnimator extends StatefulWidget {
  final Widget child;
  const _ClickAnimator({required this.child});
  @override
  State<_ClickAnimator> createState() => _ClickAnimatorState();
}
class _ClickAnimatorState extends State<_ClickAnimator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 100), lowerBound: 0.95, upperBound: 1.0, value: 1.0);
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => _controller.reverse(),
      onPointerUp: (_) => _controller.forward(),
      onPointerCancel: (_) => _controller.forward(),
      child: ScaleTransition(scale: _controller, child: widget.child),
    );
  }
}
