import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingRideScreen extends StatefulWidget {
  const BookingRideScreen({super.key});

  @override
  State<BookingRideScreen> createState() => _BookingRideScreenState();
}

class _BookingRideScreenState extends State<BookingRideScreen> {
  Null get googleFonts => null;

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
                children: [
                  SizedBox(height: 20),

                  // Header - RIDEN Logo
                  Text(
                    'RIDEN',
                    style: GoogleFonts.audiowide(
                      fontSize: 22,

                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),

                  SizedBox(height: 40),

                  // Loading Spinner - Circular Progress Indicator
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(
                      value: null,
                      strokeWidth: 8,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        RidenColors.brandRed,
                      ),
                      backgroundColor: Colors.white.withOpacity(0.1),
                    ),
                  ),

                  SizedBox(height: 30),

                  // Booking Text
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'We are booking ride for you',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: RidenColors.textPrimary,
                        height: 1.4,
                      ),
                    ),
                  ),

                  SizedBox(height: 30),

                  // Destination Card
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(20),
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

                  // Ride Details Card
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(20),
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
                            'Ride Details',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: RidenColors.textPrimary,
                            ),
                          ),
                          SizedBox(height: 20),

                          // Total Distance
                          _buildDetailRow('Total Distance', '234km'),

                          SizedBox(height: 18),

                          // Sedan
                          _buildDetailRowWithIcon(
                            'Sedan',
                            Icons.directions_car,
                          ),

                          SizedBox(height: 18),

                          // Payment Method
                          _buildDetailRow('Payment Method', 'Wallet'),

                          SizedBox(height: 18),

                          // Estimated Fare
                          _buildDetailRow(
                            'Estimated Fare',
                            '\$400.00',
                            isFare: true,
                          ),

                          SizedBox(height: 18),

                          // Discount
                          _buildDetailRow(
                            'Discount',
                            '-\$40.00',
                            isDiscount: true,
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
    bool isFare = false,
    bool isDiscount = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: RidenColors.textPrimary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isDiscount ? Color(0xFF4ECDC4) : RidenColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRowWithIcon(String label, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: RidenColors.textPrimary,
          ),
        ),
        Icon(icon, color: Colors.white, size: 24),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════
//  RIDEN COLOR PALETTE
//  All values pixel-sampled from the dark design
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
//
//  Drop this as the first child of any Stack to apply the
//  exact dark gradient from your design.
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

    // 9. Bottom dark overlay — returns to near-black
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
