// congratulations_bottom_sheet.dart
import 'package:Riden/theme/app_colors.dart';
import 'package:Riden/widgets/riden_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CongratulationsBottomSheet extends StatefulWidget {
  final ScrollController scrollController;
  const CongratulationsBottomSheet({
    required this.scrollController,
    super.key,
  });

  @override
  State<CongratulationsBottomSheet> createState() =>
      _CongratulationsBottomSheetState();
}

class _CongratulationsBottomSheetState
    extends State<CongratulationsBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<double> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeIn,
    );
    _slideAnim = Tween<double>(begin: 40, end: 0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic),
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
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
          // Background
          const Positioned.fill(child: RidenDarkBackground()),

          Column(
            children: [
              // Drag handle
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
                child: SingleChildScrollView(
                  controller: widget.scrollController,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    child: AnimatedBuilder(
                      animation: _animController,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _fadeAnim.value,
                          child: Transform.translate(
                            offset: Offset(0, _slideAnim.value),
                            child: child,
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 12),

                          // ── Title ──
                          Text(
                            'Congratulations!',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.4,
                            ),
                          ),
                          const SizedBox(height: 32),

                          // ── Asset illustration ──
                          Image.asset(
                            'assets/images/congratulation.png',
                            height: 180,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 32),

                          // ── Subtitle ──
                          Text(
                            'Your New Password has been\nupdated Successfully',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: Colors.white70,
                              height: 1.6,
                            ),
                          ),
                          const SizedBox(height: 36),

                          // ── Continue button ──
                          GestureDetector(
                            onTap: () {
                              // Pop all 3 stacked bottom sheets at once
                              int count = 0;
                              Navigator.of(context)
                                  .popUntil((_) => count++ >= 3);
                            },
                            child: Container(
                              width: double.infinity,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                color: RidenColors.brandRed,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: RidenColors.brandRed
                                        .withOpacity(0.45),
                                    blurRadius: 18,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'Continue',
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Bottom nav
          Align(
            alignment: Alignment.bottomCenter,
            child: RidenBottomNav(selectedIndex: 4, isFromSheet: true),
          ),
        ],
      ),
    );
  }
}
