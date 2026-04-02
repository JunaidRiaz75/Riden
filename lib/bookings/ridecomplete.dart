// ride_completed_bottom_sheet.dart
// ============================================================
// Draggable bottom sheet for the ride‑completed screen
// ============================================================

import 'dart:ui';

import 'package:Riden/bookings/booking_ride_detail.dart';
import 'package:Riden/theme/app_colors.dart';
import 'package:Riden/widgets/riden_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ─────────────────────────────────────────────────────────────
// ENTRY – use this in showModalBottomSheet
// ─────────────────────────────────────────────────────────────
class RideCompletedBottomSheetEntry extends StatelessWidget {
  final Driver? driver;
  final String? bookingId;

  const RideCompletedBottomSheetEntry({super.key, this.driver, this.bookingId});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: DraggableScrollableSheet(
        initialChildSize: 0.92,
        minChildSize: 0.50,
        maxChildSize: 1.0,
        expand: false,
        snap: true,
        snapSizes: const [0.50, 0.92, 1.0],
        builder: (context, scrollController) {
          return RideCompletedBottomSheet(
            scrollController: scrollController,
            driver: driver,
            bookingId: bookingId,
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// MAIN SHEET CONTENT (draggable)
// ─────────────────────────────────────────────────────────────
class RideCompletedBottomSheet extends StatefulWidget {
  final ScrollController scrollController;
  final Driver? driver;
  final String? bookingId;

  const RideCompletedBottomSheet({
    super.key,
    required this.scrollController,
    this.driver,
    this.bookingId,
  });

  @override
  State<RideCompletedBottomSheet> createState() =>
      _RideCompletedBottomSheetState();
}

class _RideCompletedBottomSheetState extends State<RideCompletedBottomSheet> {
  bool _isTipPressed = false;
  bool _isRatePressed = false;
  int _selectedTip = 1;
  int _selectedRating = 0;
  final TextEditingController _reviewCtrl = TextEditingController();
  final TextEditingController _customTipCtrl = TextEditingController();

  // Thumbnail map – static demo route
  static const LatLng _pickup = LatLng(51.5074, -0.1278);
  static const LatLng _destination = LatLng(51.5155, -0.0922);
  final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId('pickup'),
      position: _pickup,
      infoWindow: InfoWindow(title: 'Office'),
    ),
    const Marker(
      markerId: MarkerId('destination'),
      position: _destination,
      infoWindow: InfoWindow(title: 'Coffee shop'),
    ),
  };
  final Set<Polyline> _polylines = {
    const Polyline(
      polylineId: PolylineId('route'),
      points: [_pickup, _destination],
      color: Color(0xFFFF161F),
      width: 4,
    ),
  };

  @override
  void dispose() {
    _reviewCtrl.dispose();
    _customTipCtrl.dispose();
    super.dispose();
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
              // Gradient background
              Positioned.fill(
                child: CustomPaint(painter: _SheetGradientPainter()),
              ),
              // Frosted glass blur
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                  child: Container(color: Colors.white.withOpacity(0.05)),
                ),
              ),
              // Content
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
                  // Header
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 6, 16, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Back',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Text(
                          'Sun, 23 May 2025',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  // Scrollable content
                  Expanded(
                    child: ListView(
                      controller: widget.scrollController,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      children: [
                        // Thumbnail map (non‑interactive)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            height: 180,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white.withOpacity(0.18),
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: GoogleMap(
                              initialCameraPosition: const CameraPosition(
                                target: LatLng(51.5114, -0.1100),
                                zoom: 13,
                              ),
                              markers: _markers,
                              polylines: _polylines,
                              myLocationButtonEnabled: false,
                              zoomControlsEnabled: false,
                              scrollGesturesEnabled: false,
                              zoomGesturesEnabled: false,
                              style: _darkMapStyle,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Booking ID
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.58),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'Booking ID : ${widget.bookingId ?? '2345'}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Route stepper
                        _RouteStepper(
                          pickup: 'Office',
                          pickupAddress:
                              '2972 Westheimer Rd. Santa Ana, Illinois 85486',
                          destination: 'Coffee shop',
                          destinationAddress:
                              '1901 Thornridge Cir. Shiloh, Hawaii 81063',
                        ),
                        const SizedBox(height: 16),
                        // Duration & Distance
                        Divider(color: Colors.white.withOpacity(0.3)),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            
                            children: [
                              Icon(Icons.schedule, color: RidenColors.brandRed),
                              const SizedBox(width: 12),  
                              const Text('Duration : 34 mins', style: TextStyle(color: Colors.white)),
                              const SizedBox(width: 155),
                              Icon(Icons.location_on, color: RidenColors.brandRed),const SizedBox(width: 12), 
                              const Text('Distance : 5.2km', style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Divider(color: Colors.white.withOpacity(0.3)),
                        // Driver info
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                widget.driver?.avatarUrl ??
                                    'https://i.pravatar.cc/150?img=33',
                                width: 56,
                                height: 56,
                                fit: BoxFit.cover,
                                errorBuilder: (_, _, _) => const Icon(
                                  Icons.person,
                                  size: 56,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.driver?.name ?? 'Sergio',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  widget.driver?.carModel ??
                                      'Black Suzuki Alto',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // Buttons row
                        Row(
                          children: [
                            Expanded(
                              child: _AnimatedButton(
                                onTap: _showTipDialog,
                                label: 'Tip your Driver',
                                color: RidenColors.brandRed,

                                isHover: _isTipPressed,
                                onHoverChanged: (val) =>
                                    setState(() => _isTipPressed = val),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _AnimatedButton(
                                onTap: _showRatingDialog,
                                label: 'Rate your Driver',
                                color: Colors.white.withOpacity(0.58),
                                textColor: RidenColors.brandRed,
                                isOutline: false,
                                isHover: _isRatePressed,
                                onHoverChanged: (val) =>
                                    setState(() => _isRatePressed = val),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                  // Bottom navigation bar
                  RidenBottomNav(selectedIndex: 3, isFromSheet: true),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // ─────────────────────────────────────────────────────────────
  //  DIALOGS
  // ─────────────────────────────────────────────────────────────
  void _showTipDialog() {
    setState(() => _selectedTip = 1);
    _customTipCtrl.clear();
    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (ctx, setD) => Dialog(
          backgroundColor: Colors.white.withOpacity(0.58),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.58),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.black.withOpacity(0.15),
                width: 1.5,
              ),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Tip Your Driver',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _tipOption(setD, '15%', 0),
                    _tipOption(setD, '20%', 1),
                    _tipOption(setD, '25%', 2),
                    _tipOption(setD, 'Custom', 3),
                  ],
                ),
                const SizedBox(height: 24),
                _redBtn('Confirm', () => Navigator.pop(ctx)),
                const SizedBox(height: 12),
                _outlineBtn('Skip for now', () => Navigator.pop(ctx)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showRatingDialog() {
    setState(() => _selectedRating = 0);
    _reviewCtrl.clear();
    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (ctx, setD) {
          final bool showReviewField =
              _selectedRating <= 4 && _selectedRating > 0;
          return Dialog(
            backgroundColor: Colors.white.withOpacity(0.58),
            insetPadding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.58),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.black.withOpacity(0.15),
                  width: 1.5,
                ),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(ctx),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade300,
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.black87,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                      (i) => GestureDetector(
                        onTap: () => setD(() => _selectedRating = i + 1),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Icon(
                            Icons.star_rounded,
                            size: 36,
                            color: i < _selectedRating
                                ? RidenColors.brandRed
                                : Colors.black26,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _ratingTitle(_selectedRating),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _selectedRating > 0
                        ? 'You rated ${widget.driver?.name ?? 'Sergio'} $_selectedRating star${_selectedRating != 1 ? 's' : ''}'
                        : 'Tap a star to rate',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (showReviewField) ...[
                    const Text(
                      'Please share your feedback',
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _reviewCtrl,
                      maxLines: 4,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Write your review...',
                        hintStyle: const TextStyle(
                          color: Colors.black54,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.black26),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.black26),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: RidenColors.brandRed,
                            width: 2,
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(16),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                  _redBtn('Submit', () => Navigator.pop(ctx)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _ratingTitle(int r) => switch (r) {
    1 => 'Poor',
    2 => 'Good',
    3 => 'Very Good',
    4 => 'Excellent',
    5 => 'Excellent',
    _ => 'Rate',
  };

  Widget _tipOption(StateSetter setD, String label, int index) {
    final sel = _selectedTip == index;
    return GestureDetector(
      onTap: () => setD(() => _selectedTip = index),
      child: Container(
        width: 70,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: sel ? RidenColors.brandRed : Colors.black26,
            width: sel ? 2 : 1.5,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: sel ? RidenColors.brandRed : Colors.black87,
              fontWeight: sel ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _redBtn(String label, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: RidenColors.brandRed,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white, // Keeping white text since bg is bright red
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  );

  Widget _outlineBtn(String label, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black45),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(color: Colors.black87),
        ),
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
//  HELPER WIDGETS
// ─────────────────────────────────────────────────────────────
class _RouteStepper extends StatelessWidget {
  final String pickup, pickupAddress, destination, destinationAddress;
  const _RouteStepper({
    required this.pickup,
    required this.pickupAddress,
    required this.destination,
    required this.destinationAddress,
  });

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Column(
        children: [
          const Icon(Icons.circle, size: 10, color: Colors.white),
          Container(width: 1.5, height: 40, color: Colors.white30),
          const Icon(Icons.navigation, size: 18, color: Colors.red),
        ],
      ),
      const SizedBox(width: 16),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              pickup,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              pickupAddress,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
            const SizedBox(height: 16),
            const Divider(color: Colors.white24),
            const SizedBox(height: 8),
            Text(
              destination,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              destinationAddress,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
    ],
  );
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label, value;
  const _StatItem(this.icon, this.label, this.value);

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: RidenColors.brandRed.withOpacity(0.2),
        ),
        child: Icon(icon, color: RidenColors.brandRed, size: 16),
      ),
      const SizedBox(width: 10),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ],
  );
}

class _AnimatedButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final Color color;
  final Color? textColor;
  final bool isOutline, isHover;
  final ValueChanged<bool> onHoverChanged;
  const _AnimatedButton({
    required this.onTap,
    required this.label,
    required this.color,
    this.textColor,
    this.isOutline = false,
    this.isHover = false,
    required this.onHoverChanged,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    onTapDown: (_) => onHoverChanged(true),
    onTapUp: (_) => onHoverChanged(false),
    onTapCancel: () => onHoverChanged(false),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: isOutline
            ? (isHover ? color.withOpacity(0.15) : Colors.transparent)
            : (isHover ? color.withOpacity(0.85) : color),
        border: isOutline ? Border.all(color: color, width: 2) : null,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: isOutline ? color : (textColor ?? Colors.white),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
//  GRADIENT PAINTER (exact copy from active sheet)
// ─────────────────────────────────────────────────────────────
class _SheetGradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    canvas.drawRect(
      Rect.fromLTWH(0, 0, w, h),
      Paint()..color = const Color(0xFF1A1B2E),
    );
    _blob(
      canvas,
      Offset(w * 0.15, h * 0.30),
      w * 0.70,
      h * 0.50,
      const Color(0xFF8B4A35),
      170,
    );
    _blob(
      canvas,
      Offset(w * 0.82, h * 0.68),
      w * 0.70,
      h * 0.52,
      const Color(0xFF2E6B72),
      165,
    );
  }

  void _blob(
    Canvas canvas,
    Offset center,
    double rx,
    double ry,
    Color color,
    int alpha,
  ) {
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

const String _darkMapStyle = '''
[
  {"elementType":"geometry","stylers":[{"color":"#1d2c4d"}]},
  {"elementType":"labels.text.fill","stylers":[{"color":"#8ec3b9"}]},
  {"featureType":"road","elementType":"geometry","stylers":[{"color":"#304a7d"}]},
  {"featureType":"water","elementType":"geometry","stylers":[{"color":"#0e1626"}]}
]
''';