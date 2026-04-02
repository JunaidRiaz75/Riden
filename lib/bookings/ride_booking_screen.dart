// car_selection_screen.dart
// ignore_for_file: use_super_parameters, deprecated_member_use

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'rideconfirm.dart'; // adjust path

// ─────────────────────────────────────────────────────────────────────────────
// ENTRY  — wrap in DraggableScrollableSheet when opening as bottom sheet
//
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     backgroundColor: Colors.transparent,
//     barrierColor: Colors.black54,
//     builder: (_) => DraggableScrollableSheet(
//       initialChildSize: 0.85,
//       minChildSize: 0.50,
//       maxChildSize: 1.0,
//       expand: false,
//       snap: true,
//       snapSizes: const [0.50, 0.85, 1.0],
//       builder: (ctx, sc) => CarSelectionScreen(scrollController: sc),
//     ),
//   );
// ─────────────────────────────────────────────────────────────────────────────

class CarSelectionScreen extends StatefulWidget {
  final ScrollController scrollController;
  final bool showDragHandle;

  const CarSelectionScreen({
    super.key,
    required this.scrollController,
    this.showDragHandle = true,
  });

  @override
  State<CarSelectionScreen> createState() => _CarSelectionScreenState();
}

class _CarSelectionScreenState extends State<CarSelectionScreen> {
  // Track which car is selected by name
  String selectedCar = '';

  // ── Car data ──────────────────────────────────────────────────────────────
  static const _accentRed = Color(0xFFE53935);
  static const _darkInk = Color(0xFF1A1B2E);

  void _onRequest() {
    if (selectedCar.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a car'),
          backgroundColor: _accentRed,
        ),
      );
      return;
    }
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.50,
        maxChildSize: 1.0,
        expand: false,
        snap: true,
        snapSizes: const [0.50, 0.85, 1.0],
        builder: (ctx, sc) =>
            RideconfirmScreen(scrollController: sc, selectedCar: selectedCar),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double sheetH = constraints.maxHeight;
        final double sheetW = constraints.maxWidth;

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
          child: SizedBox(
            width: sheetW,
            height: sheetH,
            child: Stack(
              children: [
                // ── 1. Gradient background ──────────────────────────────────
                Positioned.fill(
                  child: CustomPaint(painter: _SheetGradientPainter()),
                ),

                // ── 2. Frosted glass blur ───────────────────────────────────
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

                // ── 3. Content ──────────────────────────────────────────────
                Column(
                  children: [
                    // Drag handle
                    if (widget.showDragHandle)
                      AnimatedOpacity(
                        opacity: (1.0 - progress).clamp(0.0, 1.0),
                        duration: const Duration(milliseconds: 150),
                        child: Padding(
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
                      ),

                    // Scrollable body
                    Expanded(
                      child: SingleChildScrollView(
                        controller: widget.scrollController,
                        physics: const ClampingScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Route summary card
                            _RouteCard(),
                            const SizedBox(height: 20),

                            // ── Standard Cars group ──────────────────────────
                            _CarGroupCard(
                              title: 'Standard Cars',
                              icon: Image.asset(
                                'assets/images/standard_car_icon.png',
                                width: 30,
                                height: 30,
                              ),
                              isGroupSelected: [
                                'Riden Standard',
                                'Riden SUV',
                                'Riden Van',
                              ].contains(selectedCar),
                              cars: [
                                _CarItem(
                                  name: 'Riden Standard',
                                  time: '3-4 min',
                                  price: r'C$ 70.00',
                                  description: 'Sedan with AC',
                                ),
                                _CarItem(
                                  name: 'Riden SUV',
                                  time: '3-4 min',
                                  price: r'C$ 70.00',
                                  description: 'SUV with AC',
                                ),
                                _CarItem(
                                  name: 'Riden Van',
                                  time: '3-4 min',
                                  price: r'C$ 70.00',
                                  description: 'Van with AC',
                                ),
                              ],
                              selectedCar: selectedCar,
                              onSelect: (name) =>
                                  setState(() => selectedCar = name),
                            ),
                            const SizedBox(height: 16),

                            // ── Premium Cars group ───────────────────────────
                            _CarGroupCard(
                              title: 'Premium Cars',
                              icon: Image.asset(
                                'assets/images/premium_car_icon.png',
                                width: 30,
                                height: 30,
                              ),
                              isPremium: true,
                              isGroupSelected: [
                                'Riden Premium',
                                'SUV Premium',
                              ].contains(selectedCar),
                              cars: [
                                _CarItem(
                                  name: 'Riden Premium',
                                  time: '3-4 min',
                                  price: r'C$ 110.00',
                                  description: 'Premium Sedan with AC',
                                ),
                                _CarItem(
                                  name: 'SUV Premium',
                                  time: '3-4 min',
                                  price: r'C$ 125.00',
                                  description: 'Premium SUV with AC',
                                ),
                              ],
                              selectedCar: selectedCar,
                              onSelect: (name) =>
                                  setState(() => selectedCar = name),
                            ),
                            const SizedBox(height: 16),

                            // ── Handicap Cars group ──────────────────────────
                            _CarGroupCard(
                              title: 'Handicap Cars',
                              icon: Image.asset(
                                'assets/images/handicap_car_icon.png',
                                width: 30,
                                height: 30,
                              ),
                              isGroupSelected:
                                  selectedCar == 'Riden Wheel Chair',
                              cars: [
                                _CarItem(
                                  name: 'Riden Wheel Chair',
                                  time: '3-4 min',
                                  price: r'C$ 80.00',
                                  description: 'Wheelchair accessible',
                                ),
                              ],
                              selectedCar: selectedCar,
                              onSelect: (name) =>
                                  setState(() => selectedCar = name),
                            ),
                            const SizedBox(height: 24),

                            // Request button
                            _RequestButton(onTap: _onRequest),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),

                    // Bottom nav
                    _SharedBottomNav(
                      selectedIndex: 0,
                      onChanged: (_) => Navigator.pop(context),
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
}

// ─────────────────────────────────────────────────────────────────────────────
// CAR ITEM DATA CLASS
// ─────────────────────────────────────────────────────────────────────────────
class _CarItem {
  final String name;
  final String time;
  final String price;
  final String description;

  const _CarItem({
    required this.name,
    required this.time,
    required this.price,
    required this.description,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// CAR GROUP CARD
//
// Behaviour (matching the screenshot exactly):
//   • Outer card = white 0.58 / border white 0.70  (same as bottom nav)
//   • When ANY car in this group is selected:
//       – Outer card border turns RED (1.8px)
//   • The selected car ROW inside the card gets a solid white background
//     (full opacity white, matching the screenshot's bright selected row)
//   • Unselected rows stay transparent (no background)
// ─────────────────────────────────────────────────────────────────────────────
class _CarGroupCard extends StatelessWidget {
  final String title;
  final Widget icon;
  final bool isPremium;
  final bool isGroupSelected;
  final List<_CarItem> cars;
  final String selectedCar;
  final ValueChanged<String> onSelect;

  const _CarGroupCard({
    required this.title,
    required this.icon,
    required this.isGroupSelected,
    required this.cars,
    required this.selectedCar,
    required this.onSelect,
    this.isPremium = false,
  });

  static const _accentRed = Color(0xFFE53935);
  static const _darkInk = Color(0xFF1A1B2E);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        // White 0.58 — identical to bottom nav
        color: Colors.white.withOpacity(0.58),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          // Red when any car in group is selected, white otherwise
          color: isGroupSelected ? _accentRed : Colors.white.withOpacity(0.70),
          width: isGroupSelected ? 2.0 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: isGroupSelected
                ? _accentRed.withOpacity(0.12)
                : Colors.black.withOpacity(0.07),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Group header ────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
            child: Row(
              children: [
                SizedBox(
                  width: 30,
                  height: 30,
                  child: FittedBox(fit: BoxFit.contain, child: icon),
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _darkInk,
                  ),
                ),
              ],
            ),
          ),

          // ── Car rows ────────────────────────────────────────────────
          ...cars.asMap().entries.map((entry) {
            final i = entry.key;
            final car = entry.value;
            final bool isRowSelected = selectedCar == car.name;
            final bool isLast = i == cars.length - 1;

            return Column(
              children: [
                // Divider above each row (except first)
                if (i != 0)
                  Divider(
                    color: _darkInk.withOpacity(0.08),
                    height: 1,
                    indent: 0,
                    endIndent: 0,
                  ),

                // ── Single car row ────────────────────────────────────
                GestureDetector(
                  onTap: () => onSelect(car.name),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      // White when selected (bright, as in screenshot)
                      // Transparent when not selected
                      color: isRowSelected ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: isRowSelected
                          ? [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : [],
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        // Car image placeholder
                        SizedBox(
                          width: 80,
                          height: 48,
                          child: Image.asset(
                            'assets/images/car.png',
                            fit: BoxFit.contain,
                            errorBuilder: (_, _, _) => Icon(
                              Icons.directions_car,
                              size: 36,
                              color: isRowSelected ? _accentRed : _darkInk,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),

                        // Car info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                car.name,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: _darkInk,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Row(
                                children: [
                                  Icon(
                                    Icons.schedule,
                                    size: 12,
                                    color: _darkInk.withOpacity(0.55),
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    car.time,
                                    style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      color: _darkInk.withOpacity(0.60),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                car.description,
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  color: _darkInk.withOpacity(0.50),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Price
                        Text(
                          car.price,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: isRowSelected ? _accentRed : _darkInk,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Bottom padding inside last row
                if (isLast) const SizedBox(height: 4),
              ],
            );
          }),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ROUTE CARD  — white 0.58, identical to other cards
// ─────────────────────────────────────────────────────────────────────────────
class _RouteCard extends StatelessWidget {
  static const _accentRed = Color(0xFFE53935);
  static const _darkInk = Color(0xFF1A1B2E);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.58),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.70), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        children: [
          // Pickup
          Row(
            children: [
              Image.asset('assets/images/pickup.png', width: 30, height: 30),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pickup',
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: _darkInk.withOpacity(0.55),
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '2972 Westheimer Rd. Santa Ana, Illinois 85486',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _darkInk,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Divider(color: _darkInk.withOpacity(0.08), height: 1),
          const SizedBox(height: 10),
          // Destination
          Row(
            children: [
              Image.asset(
                'assets/images/destination.png',
                width: 30,
                height: 30,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Destination',
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: _darkInk.withOpacity(0.55),
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '1901 Thorndige Cir. Shiloh, Hawaii 81603',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _darkInk,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: _darkInk.withOpacity(0.80),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Stops',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// REQUEST BUTTON
// ─────────────────────────────────────────────────────────────────────────────
class _RequestButton extends StatelessWidget {
  final VoidCallback onTap;
  const _RequestButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFE53935), Color(0xFFFF5252)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFE53935).withOpacity(0.35),
              blurRadius: 14,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Center(
          child: Text(
            'Request',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SHARED GRADIENT PAINTER  (identical across all sheets)
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
      center: Offset(w * 0.05, h * 0.55),
      rx: w * 0.50,
      ry: h * 0.35,
      color: const Color(0xFF6B3828),
      alpha: 130,
    );
    _blob(
      canvas,
      center: Offset(w * 0.82, h * 0.68),
      rx: w * 0.70,
      ry: h * 0.52,
      color: const Color(0xFF2E6B72),
      alpha: 165,
    );
    _blob(
      canvas,
      center: Offset(w * 0.90, h * 0.50),
      rx: w * 0.40,
      ry: h * 0.30,
      color: const Color(0xFF3D8A8F),
      alpha: 110,
    );
    _blob(
      canvas,
      center: Offset(w * 0.50, h * 0.50),
      rx: w * 0.55,
      ry: h * 0.40,
      color: const Color(0xFF3A4555),
      alpha: 80,
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

// ─────────────────────────────────────────────────────────────────────────────
// SHARED BOTTOM NAV  (identical across all sheets)
// ─────────────────────────────────────────────────────────────────────────────
class _SharedBottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const _SharedBottomNav({
    required this.selectedIndex,
    required this.onChanged,
  });

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
              color: Colors.white.withOpacity(0.58),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: Colors.white.withOpacity(0.70),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.10),
                  blurRadius: 12,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.only(top: 14),
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
    final Color col = active
        ? const Color(0xFFE53935)
        : const Color.fromARGB(255, 24, 30, 36);
    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(index),
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 1),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: col, size: 24),
              const SizedBox(height: 5),
              Text(
                label,
                style: TextStyle(
                  color: col,
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
