import 'package:flutter/material.dart';

class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ✨ RIDEN Dark Gradient Background
          const RidenDarkBackground(),

          // Content
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back Button
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_back_ios,
                            color: RidenColors.textPrimary,
                            size: 24,
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
                  ),

                  // Title
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      'Ride is on Its Way',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: RidenColors.textPrimary,
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Driver Card
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          // Driver Avatar
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: AssetImage('assets/driver.jpg'),
                                fit: BoxFit.cover,
                              ),
                              color: Colors.grey.shade800,
                            ),
                            child: Image.network(
                              'https://i.pravatar.cc/150?img=33',
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 16),
                          // Driver Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Sergio',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: RidenColors.textPrimary,
                                  ),
                                ),
                                SizedBox(height: 6),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 14,
                                      color: RidenColors.brandRed,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      '(5mins away)',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: RidenColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 6),
                                Text(
                                  '43 Rides (31 reviews)',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: RidenColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Action Buttons
                          Row(
                            children: [
                              // Call Button
                              GestureDetector(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Calling driver...'),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: RidenColors.brandRed,
                                      width: 2,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.phone,
                                    color: RidenColors.brandRed,
                                    size: 20,
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              // Message Button
                              GestureDetector(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Opening messages...'),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: RidenColors.brandRed,
                                      width: 2,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.chat,
                                    color: RidenColors.brandRed,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Ride Details Card
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header with Booking ID
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Ride Details',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: RidenColors.textPrimary,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: RidenColors.textPrimary,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  'Booking ID: 2345',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: RidenColors.textPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),

                          // Car Details
                          Row(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 12),
                              Text(
                                'Black Suzuki Alto, (BKG-220)',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: RidenColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Divider(
                            color: Colors.grey.withOpacity(0.3),
                            height: 1,
                          ),
                          SizedBox(height: 16),

                          // Total Distance
                          _buildDetailRow('Total Distance', '435km'),
                          SizedBox(height: 16),

                          // Payment Method
                          _buildDetailRow('Payment Method', 'wallet'),
                          SizedBox(height: 16),

                          // Estimated Fare
                          _buildDetailRow('Estimated Fare', '\$450.00'),
                          SizedBox(height: 16),

                          // Discount
                          _buildDetailRow(
                            'Discount',
                            '\$45.00',
                            isDiscount: true,
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Destination Card
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Destination',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: RidenColors.textPrimary,
                            ),
                          ),
                          SizedBox(height: 20),

                          // Office Location
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Container(
                                    width: 2,
                                    height: 60,
                                    color: Colors.grey.withOpacity(0.5),
                                    margin: EdgeInsets.symmetric(vertical: 6),
                                  ),
                                ],
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Office',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: RidenColors.textPrimary,
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      '2972 Westheimer Rd. Santa Ana, Illinois 85486',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: RidenColors.textSecondary,
                                        height: 1.4,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 16),

                          // Coffee Shop Location
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: RidenColors.brandRed,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.navigation,
                                        size: 8,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Coffee shop',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: RidenColors.textPrimary,
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      '1901 Thornridge Cir. Shiloh, Hawaii 81063',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: RidenColors.textSecondary,
                                        height: 1.4,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Manage Ride Card
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Manage Ride',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: RidenColors.textPrimary,
                            ),
                          ),
                          SizedBox(height: 14),

                          // Share Ride Details
                          _buildManageOption(
                            icon: Icons.share,
                            label: 'Share Ride Details',
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Sharing ride details...'),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 8),

                          // Need Support
                          _buildManageOption(
                            icon: Icons.headphones,
                            label: 'Need Support',
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Opening support...')),
                              );
                            },
                          ),
                          SizedBox(height: 12),

                          // Cancel Ride
                          _buildManageOption(
                            icon: Icons.close,
                            label: 'Cancel Ride',
                            isCancel: true,
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Cancelling ride...')),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    bool isDiscount = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: RidenColors.textPrimary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isDiscount ? Color(0xFF4ECDC4) : RidenColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildManageOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isCancel = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCancel ? RidenColors.brandRed : Colors.transparent,
            ),
            child: Icon(
              icon,
              color: isCancel ? Colors.white : RidenColors.textPrimary,
              size: 20,
            ),
          ),
          SizedBox(width: 16),
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: isCancel ? RidenColors.brandRed : RidenColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════
//  RIDEN COLOR PALETTE
// ════════════════════════════════════════════════════════════

abstract class RidenColors {
  // ── Background base ─────────────────────────────────────
  static const Color backgroundBase = Color(0xFF18192B);
  static const Color backgroundTopLeft = Color(0xFF3C3441);
  static const Color backgroundTopRight = Color(0xFF1B1C2E);

  // ── Left warm glow (copper / brown) ────────────────────
  static const Color warmCopper = Color(0xFF734337);
  static const Color warmCopperDeep = Color(0xFF62412E);
  static const Color warmCopperLight = Color(0xFF69403A);

  // ── Right teal / slate glow ─────────────────────────────
  static const Color tealSlate = Color(0xFF3A5F72);
  static const Color tealSlateLight = Color(0xFF547483);
  static const Color tealSlateDark = Color(0xFF2B4F65);

  // ── Center blend ───────────────────────────────────────
  static const Color centerBlend = Color(0xFF3A4C55);
  static const Color centerBlendLight = Color(0xFF627070);

  // ── Brand / accent ──────────────────────────────────────
  static const Color brandRed = Color(0xFFEA4242);
  static const Color brandRedGlow = Color(0x80EA4242);

  // ── Text ────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFBDBDBD);
  static const Color textHint = Color(0xFF757575);

  // ── Surface / glass ─────────────────────────────────────
  static const Color glassSurface = Color(0x993A3F48);
  static const Color glassBorder = Color(0x33FFFFFF);

  // ── Utility ─────────────────────────────────────────────
  static const Color divider = Color(0x22FFFFFF);
  static const Color homeIndicator = Color(0x55FFFFFF);
  static const Color shadowDark = Color(0x40000000);
}

// ════════════════════════════════════════════════════════════
//  RIDEN DARK BACKGROUND WIDGET
// ════════════════════════════════════════════════════════════

class RidenDarkBackground extends StatelessWidget {
  const RidenDarkBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(child: CustomPaint(painter: _DarkGradientPainter()));
  }
}

// ════════════════════════════════════════════════════════════
//  PAINTER — 9 elliptical gradient blobs stacked
// ════════════════════════════════════════════════════════════

class _DarkGradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // 1. Base fill
    canvas.drawRect(
      Rect.fromLTWH(0, 0, w, h),
      Paint()..color = RidenColors.backgroundBase,
    );

    // 2. Top-left dark purple-plum band
    _blob(
      canvas,
      center: Offset(w * 0.0, h * 0.0),
      rx: w * 1.0,
      ry: h * 0.45,
      color: RidenColors.backgroundTopLeft,
      alpha: 200,
    );

    // 3. Top-right deep navy accent
    _blob(
      canvas,
      center: Offset(w * 1.05, h * 0.0),
      rx: w * 0.70,
      ry: h * 0.35,
      color: RidenColors.backgroundTopRight,
      alpha: 220,
    );

    // 4. Left warm copper/brown glow
    _blob(
      canvas,
      center: Offset(w * -0.05, h * 0.38),
      rx: w * 0.72,
      ry: h * 0.38,
      color: RidenColors.warmCopper,
      alpha: 190,
    );

    // 5. Left deeper copper highlight
    _blob(
      canvas,
      center: Offset(w * 0.02, h * 0.46),
      rx: w * 0.45,
      ry: h * 0.22,
      color: RidenColors.warmCopperDeep,
      alpha: 140,
    );

    // 6. Right teal/slate glow
    _blob(
      canvas,
      center: Offset(w * 1.05, h * 0.50),
      rx: w * 0.72,
      ry: h * 0.42,
      color: RidenColors.tealSlate,
      alpha: 200,
    );

    // 7. Right teal lighter highlight
    _blob(
      canvas,
      center: Offset(w * 0.92, h * 0.55),
      rx: w * 0.45,
      ry: h * 0.28,
      color: RidenColors.tealSlateLight,
      alpha: 155,
    );

    // 8. Center muted teal-gray blend
    _blob(
      canvas,
      center: Offset(w * 0.50, h * 0.50),
      rx: w * 0.65,
      ry: h * 0.30,
      color: RidenColors.centerBlend,
      alpha: 100,
    );

    // 9. Bottom dark overlay
    _blob(
      canvas,
      center: Offset(w * 0.50, h * 1.08),
      rx: w * 0.90,
      ry: h * 0.38,
      color: RidenColors.backgroundBase,
      alpha: 255,
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
    final solidColor = Color.fromARGB(
      alpha,
      color.red,
      color.green,
      color.blue,
    );
    final clearColor = Color.fromARGB(0, color.red, color.green, color.blue);

    final paint = Paint()
      ..shader = RadialGradient(colors: [solidColor, clearColor]).createShader(
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
  bool shouldRepaint(_DarkGradientPainter _) => false;
}
