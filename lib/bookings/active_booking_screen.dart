import 'dart:async';
import 'dart:ui';

import 'package:Riden/bookings/booking_ride_detail.dart';
import 'package:Riden/bookings/cancel_ride_bottom_sheet.dart';
import 'package:Riden/bookings/ridecomplete.dart';
import 'package:Riden/widgets/riden_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─────────────────────────────────────────────────────────────────────────────
// BOTTOM SHEET ENTRY
// ─────────────────────────────────────────────────────────────────────────────
class ActiveBookingBottomSheetEntry extends StatelessWidget {
  final Driver driver;
  final String bookingId;

  const ActiveBookingBottomSheetEntry({
    super.key,
    required this.driver,
    this.bookingId = '2345',
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.92,
      minChildSize: 0.50,
      maxChildSize: 1.0,
      expand: false,
      snap: true,
      snapSizes: const [0.50, 0.92, 1.0],
      builder: (context, scrollController) {
        return ActiveBookingBottomSheet(
          driver: widget.driver,
          bookingId: widget.bookingId,
          scrollController: scrollController,
        );
      },
    );
  }

  // Helper getter to avoid 'widget' error in Stateless
  ActiveBookingBottomSheetEntry get widget => this;
}

// ─────────────────────────────────────────────────────────────────────────────
// MAIN SHEET
// ─────────────────────────────────────────────────────────────────────────────
class ActiveBookingBottomSheet extends StatefulWidget {
  final Driver driver;
  final String bookingId;
  final ScrollController scrollController;

  const ActiveBookingBottomSheet({
    super.key,
    required this.driver,
    required this.bookingId,
    required this.scrollController,
  });

  @override
  State<ActiveBookingBottomSheet> createState() =>
      _ActiveBookingBottomSheetState();
}

class _ActiveBookingBottomSheetState extends State<ActiveBookingBottomSheet> {
  // ── Auto-navigation timer ──────────────────────────────
  Timer? _navTimer;
  int _secondsLeft = 3;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    _navTimer?.cancel();
    super.dispose();
  }

  /// Starts a 1-second tick countdown from 3 → 0, then navigates.
  void _startCountdown() {
    _navTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() => _secondsLeft--);

      if (_secondsLeft <= 0) {
        timer.cancel();
        _navigateToRideComplete();
      }
    });
  }

  /// Pushes to RideCompleteScreen, closing the bottom sheet first.
  void _navigateToRideComplete() {
    if (!mounted) return;

    // Close the bottom sheet
    Navigator.of(context).pop();

    // Then push the ride complete screen
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, _, _) => RideCompletedBottomSheetEntry(
          driver: widget.driver,
          bookingId: widget.bookingId,
        ),
        transitionsBuilder: (_, animation, _, child) =>
            FadeTransition(opacity: animation, child: child),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  // ── Cancel timer if user manually dismisses ───────────
  void _showAccessContactsDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.65),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: Colors.white.withOpacity(0.70),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 28),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE53935).withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Container(
                          width: 58,
                          height: 58,
                          decoration: const BoxDecoration(
                            color: Color(0xFFE53935),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.contact_phone_rounded,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Access Contacts',
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1A1B2E),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'You want to access your contacts while using this app.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: const Color(0xFF1A1B2E).withOpacity(0.6),
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(ctx),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE53935),
                        minimumSize: const Size(double.infinity, 54),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        'Access Contacts',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: () => Navigator.pop(ctx),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        minimumSize: const Size(double.infinity, 54),
                        side: const BorderSide(
                          color: Color(0xFFE53935),
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        'Skip for now',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFE53935),
                        ),
                      ),
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

  void _showCancelRideSheet() {
    // Cancel auto-nav if user is cancelling the ride
    _navTimer?.cancel();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
      builder: (_) => const CancelRideBottomSheetEntry(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double sheetH = constraints.maxHeight;
        final double minH = screenHeight * 0.50;
        final double maxH = screenHeight * 1.00;
        final double progress = ((sheetH - minH) / (maxH - minH)).clamp(
          0.0,
          1.0,
        );
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

                  // ── Auto-nav countdown banner ──────────────────
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _secondsLeft > 0
                        ? Container(
                            key: const ValueKey('banner'),
                            margin: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE53935).withOpacity(0.18),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: const Color(
                                  0xFFE53935,
                                ).withOpacity(0.35),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                // Circular countdown ring
                                SizedBox(
                                  width: 36,
                                  height: 36,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      CircularProgressIndicator(
                                        value: _secondsLeft / 3,
                                        strokeWidth: 3,
                                        backgroundColor: Colors.white
                                            .withOpacity(0.15),
                                        valueColor:
                                            const AlwaysStoppedAnimation<Color>(
                                              Color(0xFFE53935),
                                            ),
                                      ),
                                      Text(
                                        '$_secondsLeft',
                                        style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'Navigating to Ride Complete in $_secondsLeft second${_secondsLeft == 1 ? '' : 's'}...',
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white.withOpacity(0.90),
                                    ),
                                  ),
                                ),
                                // Skip button
                                GestureDetector(
                                  onTap: () {
                                    _navTimer?.cancel();
                                    _navigateToRideComplete();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE53935),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      'Go now',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(key: ValueKey('empty')),
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
                              const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
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

                  // Scrollable Cards
                  Expanded(
                    child: ListView(
                      controller: widget.scrollController,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      children: [
                        // ── Card 1: Driver Info ──
                        _WhiteGlassCard(
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  widget.driver.avatarUrl,
                                  width: 58,
                                  height: 58,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, _, _) => const Icon(
                                    Icons.person,
                                    size: 58,
                                    color: Colors.white24,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.driver.name,
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF1A1B2E),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on,
                                          size: 14,
                                          color: Color(0xFFE53935),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '(${widget.driver.distance})',
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: const Color(
                                              0xFF1A1B2E,
                                            ).withOpacity(0.6),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '${widget.driver.ridesCount} Rides (${widget.driver.reviews} reviews)',
                                      style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        color: const Color(
                                          0xFF1A1B2E,
                                        ).withOpacity(0.5),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              _RoundIconButton(icon: Icons.phone_rounded),
                              const SizedBox(width: 12),
                              _RoundIconButton(icon: Icons.chat_bubble_rounded),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),

                        // ── Card 2: Ride Details ──
                        _WhiteGlassCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Ride Details',
                                    style: GoogleFonts.poppins(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF1A1B2E),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.12),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      'Booking ID : ${widget.bookingId}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(
                                          0xFF1A1B2E,
                                        ).withOpacity(0.7),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 18),
                              Row(
                                children: [
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    '${widget.driver.carModel}, (${widget.driver.plate})',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF1A1B2E),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                height: 28,
                                thickness: 1,
                                color: Colors.black12,
                              ),
                              _DetailRow('Total Distance', '435km'),
                              _DetailRow('Payment Method', 'wallet'),
                              _DetailRow('Estimated Fare', '\$450.00'),
                              _DetailRow('Discount', '\$45.00'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),

                        // ── Card 3: Destination ──
                        _WhiteGlassCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Destination',
                                style: GoogleFonts.poppins(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF1A1B2E),
                                ),
                              ),
                              const SizedBox(height: 20),
                              _RouteStepper(
                                pickup: 'Office',
                                pickupAddress:
                                    '2972 Westheimer Rd. Santa Ana, Illinois 85486',
                                destination: 'Coffee shop',
                                destinationAddress:
                                    '1901 Thornridge Cir. Shiloh, Hawaii 81063',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),

                        // ── Card 4: Manage Ride ──
                        _WhiteGlassCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Manage Ride',
                                style: GoogleFonts.poppins(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF1A1B2E),
                                ),
                              ),
                              const SizedBox(height: 18),
                              _ActionRow(
                                icon: Icons.share_outlined,
                                label: 'Share Ride Details',
                                color: const Color(0xFF1A1B2E),
                                onTap: _showAccessContactsDialog,
                              ),
                              const SizedBox(height: 16),
                              _ActionRow(
                                icon: Icons.cancel_outlined,
                                iconColor: const Color(0xFFE53935),
                                label: 'Cancel Ride',
                                labelColor: const Color(0xFFE53935),
                                color: const Color(0xFFFDECEA),
                                isDanger: true,
                                onTap: _showCancelRideSheet,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),

                  // Bottom Nav
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
// UI HELPERS  (unchanged)
// ─────────────────────────────────────────────────────────────────────────────

class _WhiteGlassCard extends StatelessWidget {
  final Widget child;
  const _WhiteGlassCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.62),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white.withOpacity(0.70), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(18),
      child: child,
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  final IconData icon;
  const _RoundIconButton({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: const BoxDecoration(
        color: Color(0xFFE53935),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white, size: 22),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF1A1B2E).withOpacity(0.7),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1A1B2E).withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}

class _RouteStepper extends StatelessWidget {
  final String pickup;
  final String pickupAddress;
  final String destination;
  final String destinationAddress;

  const _RouteStepper({
    required this.pickup,
    required this.pickupAddress,
    required this.destination,
    required this.destinationAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            const Icon(Icons.circle, size: 10, color: Colors.black),
            SizedBox(
              width: 1.5,
              height: 45,
              child: Column(
                children: List.generate(
                  8,
                  (i) => Expanded(
                    child: Container(
                      width: 1.5,
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      color: i % 2 == 0 ? Colors.black26 : Colors.transparent,
                    ),
                  ),
                ),
              ),
            ),
            const Icon(Icons.navigation, size: 18, color: Color(0xFFE53935)),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _LocationInfo(pickup, pickupAddress),
              const SizedBox(height: 25),
              _LocationInfo(destination, destinationAddress),
            ],
          ),
        ),
      ],
    );
  }
}

class _LocationInfo extends StatelessWidget {
  final String title;
  final String address;
  const _LocationInfo(this.title, this.address);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1A1B2E),
          ),
        ),
        Text(
          address,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: const Color(0xFF1A1B2E).withOpacity(0.55),
          ),
        ),
      ],
    );
  }
}

class _ActionRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color? iconColor;
  final Color? labelColor;
  final bool isDanger;
  final VoidCallback? onTap;

  const _ActionRow({
    required this.icon,
    required this.label,
    required this.color,
    this.iconColor,
    this.labelColor,
    this.isDanger = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          Icon(icon, color: iconColor ?? color, size: 22),
          const SizedBox(width: 14),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: labelColor ?? color,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// GRADIENT PAINTER  (unchanged)
// ─────────────────────────────────────────────────────────────────────────────

class _SheetGradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    canvas.drawRect(
      Rect.fromLTWH(0, 0, w, h),
      Paint()..color = const Color(0xFF1A1B2E),
    );
    _blob(
      canvas,
      center: Offset(w * 0.15, h * 0.30),
      rx: w * 0.70,
      ry: h * 0.50,
      color: const Color(0xFF8B4A35),
      alpha: 170,
    );
    _blob(
      canvas,
      center: Offset(w * 0.82, h * 0.68),
      rx: w * 0.70,
      ry: h * 0.52,
      color: const Color(0xFF2E6B72),
      alpha: 165,
    );
  }

  void _blob(
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
