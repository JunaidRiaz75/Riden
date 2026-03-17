// ============================================================
//  RIDEN — Dark Theme Gradient Background
//
//  Pixel-sampled from your uploaded dark design (01.png):
//    Top         → very dark purple-navy   #312A3A → #1B1C2E
//    Left-mid    → warm dark brown/copper  #734337 → #62412E
//    Right-mid   → dark teal/slate         #547483 → #3A5F72
//    Center      → muted dark teal-gray    #627070
//    Bottom      → near-black navy         #18192B
//
//  Usage — drop _RidenDarkBackground() anywhere in a Stack:
//
//    Stack(
//      fit: StackFit.expand,
//      children: [
//        const _RidenDarkBackground(),
//        // ... your content
//      ],
//    )
//
//  pubspec.yaml dependencies needed:
//    google_fonts: ^6.1.0
// ============================================================

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light, // white icons on dark bg
    ),
  );
  runApp(const RidenApp());
}

// ════════════════════════════════════════════════════════════
//  APP
// ════════════════════════════════════════════════════════════

class RidenApp extends StatelessWidget {
  const RidenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riden',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFEA4242),
          brightness: Brightness.dark,
        ),
      ),
      home: const SignUpScreen(),
    );
  }
}

// ════════════════════════════════════════════════════════════
//  SIGN UP SCREEN  (dark theme)
// ════════════════════════════════════════════════════════════

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {

  late final AnimationController _enterCtrl;
  late final List<Animation<double>> _buttonAnims;

  @override
  void initState() {
    super.initState();

    _enterCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _buttonAnims = List.generate(4, (i) {
      final start = (i * 0.15).clamp(0.0, 1.0);
      final end   = (start + 0.55).clamp(0.0, 1.0);
      return CurvedAnimation(
        parent: _enterCtrl,
        curve: Interval(start, end, curve: Curves.easeOutCubic),
      );
    });

    Future.delayed(const Duration(milliseconds: 250), () {
      if (mounted) _enterCtrl.forward();
    });
  }

  @override
  void dispose() {
    _enterCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [

          // ── Dark gradient background ─────────────────────
          const _RidenDarkBackground(),

          // ── Content ─────────────────────────────────────
          SafeArea(
            child: Column(
              children: [

                // Illustration top half
                Expanded(
                  flex: 55,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                    child: Image.asset(
                      'assets/images/signup_illustration.png',
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) =>
                          const _IllustrationFallback(),
                    ),
                  ),
                ),

                // Buttons bottom half
                Expanded(
                  flex: 45,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        _AnimatedButton(
                          animation: _buttonAnims[0],
                          icon: const _EmailIcon(),
                          label: 'Sign up with email',
                          onTap: () {},
                        ),
                        const SizedBox(height: 14),

                        _AnimatedButton(
                          animation: _buttonAnims[1],
                          icon: const _GoogleIcon(),
                          label: 'Sign up with Google',
                          onTap: () {},
                        ),
                        const SizedBox(height: 14),

                        _AnimatedButton(
                          animation: _buttonAnims[2],
                          icon: const Icon(
                            Icons.phone,
                            size: 22,
                            color: Colors.white,
                          ),
                          label: 'Sign up with Phone',
                          onTap: () {},
                        ),
                        const SizedBox(height: 14),

                        _AnimatedButton(
                          animation: _buttonAnims[3],
                          icon: const _AppleIcon(),
                          label: 'Sign up with Apple',
                          onTap: () {},
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // iOS home indicator
          Positioned(
            bottom: 8, left: 0, right: 0,
            child: Center(
              child: Container(
                width: 134, height: 5,
                decoration: BoxDecoration(
                  color: const Color(0x55FFFFFF),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════
//  DARK GRADIENT BACKGROUND  ← main deliverable
//
//  Exact colors pixel-sampled from 01.png:
//
//  Base:        #18192B  (near-black navy — bottom & corners)
//  Top band:    #312A3A  (dark purple-plum, left-heavy)
//  Left blob:   #734337  (warm dark brown/copper, y≈30-50%)
//  Right blob:  #547483  (dark teal/slate,       y≈40-65%)
//  Center glow: #627070  (muted dark teal-gray)
// ════════════════════════════════════════════════════════════

class _RidenDarkBackground extends StatelessWidget {
  const _RidenDarkBackground();

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: CustomPaint(painter: _DarkGradientPainter()),
    );
  }
}

class _DarkGradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // ── 1. Base fill: near-black navy ────────────────────
    canvas.drawRect(
      Rect.fromLTWH(0, 0, w, h),
      Paint()..color = const Color(0xFF18192B),
    );

    // ── 2. Top-left dark purple band ─────────────────────
    //    Fades from #3C3441 (top-left) to transparent
    _blob(canvas,
      center: Offset(w * 0.0, h * 0.0),
      rx: w * 1.0, ry: h * 0.45,
      color: const Color(0xFF3C3441), alpha: 200,
    );

    // ── 3. Top-right dark navy accent ────────────────────
    //    Fades from #1B1C2E toward center
    _blob(canvas,
      center: Offset(w * 1.05, h * 0.0),
      rx: w * 0.70, ry: h * 0.35,
      color: const Color(0xFF1B1C2E), alpha: 220,
    );

    // ── 4. Left warm brown/copper glow ───────────────────
    //    Centered at ~y=35%, x=0 — the reddish-brown region
    _blob(canvas,
      center: Offset(w * -0.05, h * 0.38),
      rx: w * 0.72, ry: h * 0.38,
      color: const Color(0xFF734337), alpha: 190,
    );

    // ── 5. Deeper copper highlight ───────────────────────
    _blob(canvas,
      center: Offset(w * 0.02, h * 0.46),
      rx: w * 0.45, ry: h * 0.22,
      color: const Color(0xFF62412E), alpha: 140,
    );

    // ── 6. Right teal/slate glow ─────────────────────────
    //    Centered at ~y=50%, x=100%
    _blob(canvas,
      center: Offset(w * 1.05, h * 0.50),
      rx: w * 0.72, ry: h * 0.42,
      color: const Color(0xFF3A5F72), alpha: 200,
    );

    // ── 7. Right teal highlight ──────────────────────────
    _blob(canvas,
      center: Offset(w * 0.92, h * 0.55),
      rx: w * 0.45, ry: h * 0.28,
      color: const Color(0xFF547483), alpha: 155,
    );

    // ── 8. Center muted teal-gray glow ───────────────────
    //    The soft glow at the intersection of brown & teal
    _blob(canvas,
      center: Offset(w * 0.50, h * 0.50),
      rx: w * 0.65, ry: h * 0.30,
      color: const Color(0xFF3A4C55), alpha: 100,
    );

    // ── 9. Bottom dark navy overlay ──────────────────────
    //    Brings bottom back to the near-black #18192B
    _blob(canvas,
      center: Offset(w * 0.50, h * 1.08),
      rx: w * 0.90, ry: h * 0.38,
      color: const Color(0xFF18192B), alpha: 255,
    );
  }

  /// Draws an elliptical radial-gradient blob.
  /// [alpha] 0-255 (avoids deprecated withOpacity).
  void _blob(
    Canvas canvas, {
    required Offset center,
    required double rx,
    required double ry,
    required Color  color,
    required int    alpha,
  }) {
    final solidColor =
        Color.fromARGB(alpha, color.red, color.green, color.blue);
    final clearColor =
        Color.fromARGB(0,     color.red, color.green, color.blue);

    final paint = Paint()
      ..shader = RadialGradient(
        colors: [solidColor, clearColor],
      ).createShader(
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

// ════════════════════════════════════════════════════════════
//  FROSTED-GLASS DARK BUTTON
//  Semi-transparent dark glass with subtle white border.
// ════════════════════════════════════════════════════════════

class _AnimatedButton extends StatelessWidget {
  final Animation<double> animation;
  final Widget            icon;
  final String            label;
  final VoidCallback      onTap;

  const _AnimatedButton({
    required this.animation,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, child) => Opacity(
        opacity: animation.value,
        child: Transform.translate(
          offset: Offset(0, 28 * (1 - animation.value)),
          child: child,
        ),
      ),
      child: _DarkGlassButton(icon: icon, label: label, onTap: onTap),
    );
  }
}

class _DarkGlassButton extends StatefulWidget {
  final Widget       icon;
  final String       label;
  final VoidCallback onTap;

  const _DarkGlassButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<_DarkGlassButton> createState() => _DarkGlassButtonState();
}

class _DarkGlassButtonState extends State<_DarkGlassButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown:   (_) => setState(() => _pressed = true),
      onTapUp:     (_) => setState(() => _pressed = false),
      onTapCancel: ()  => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
            child: Container(
              height: 58,
              decoration: BoxDecoration(
                // Dark frosted-glass: sampled button bg ≈ #3A3F48 @ ~60%
                color: const Color(0x993A3F48),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: const Color(0x33FFFFFF),
                  width: 0.8,
                ),
              ),
              child: Row(
                children: [
                  // Icon — fixed-width left zone
                  Container(
                    width: 58,
                    alignment: Alignment.center,
                    child: widget.icon,
                  ),

                  // Label — centred in remaining space
                  Expanded(
                    child: Text(
                      widget.label,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),

                  // Mirror spacer so label is truly centred
                  const SizedBox(width: 58),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════
//  ICON WIDGETS  (white versions for dark theme)
// ════════════════════════════════════════════════════════════

class _EmailIcon extends StatelessWidget {
  const _EmailIcon();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24, height: 24,
      child: CustomPaint(painter: _EnvelopePainter()),
    );
  }
}

class _EnvelopePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.7
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, h * 0.18, w, h * 0.65),
        const Radius.circular(2),
      ),
      paint,
    );
    canvas.drawPath(
      Path()
        ..moveTo(0, h * 0.18)
        ..lineTo(w * 0.50, h * 0.60)
        ..lineTo(w, h * 0.18),
      paint,
    );
  }

  @override
  bool shouldRepaint(_EnvelopePainter _) => false;
}

class _GoogleIcon extends StatelessWidget {
  const _GoogleIcon();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24, height: 24,
      child: CustomPaint(painter: _GooglePainter()),
    );
  }
}

class _GooglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width  / 2;
    final cy = size.height / 2;
    final r  = size.width  / 2;

    _arc(canvas, cx, cy, r, -0.20, 4.75, const Color(0xFF4285F4), 3.2);
    _arc(canvas, cx, cy, r,  3.97, 0.76, const Color(0xFFEA4335), 3.2);
    _arc(canvas, cx, cy, r,  2.36, 1.65, const Color(0xFFFBBC05), 3.2);
    _arc(canvas, cx, cy, r,  1.26, 1.12, const Color(0xFF34A853), 3.2);

    canvas.drawLine(
      Offset(cx, cy),
      Offset(cx + r * 0.82, cy),
      Paint()
        ..color = const Color(0xFF4285F4)
        ..strokeWidth = 3.0
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke,
    );
  }

  void _arc(Canvas canvas, double cx, double cy, double r,
      double start, double sweep, Color color, double sw) {
    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: r * 0.72),
      start, sweep, false,
      Paint()
        ..color = color
        ..strokeWidth = sw
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.butt,
    );
  }

  @override
  bool shouldRepaint(_GooglePainter _) => false;
}

class _AppleIcon extends StatelessWidget {
  const _AppleIcon();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 22, height: 24,
      child: CustomPaint(painter: _ApplePainter()),
    );
  }
}

class _ApplePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final body = Path()
      ..moveTo(w * 0.50, h * 0.28)
      ..cubicTo(w * 0.38, h * 0.28, w * 0.08, h * 0.42, w * 0.08, h * 0.72)
      ..cubicTo(w * 0.08, h * 0.90, w * 0.20, h * 1.02, w * 0.32, h * 0.98)
      ..cubicTo(w * 0.42, h * 0.94, w * 0.46, h * 0.90, w * 0.50, h * 0.90)
      ..cubicTo(w * 0.54, h * 0.90, w * 0.58, h * 0.94, w * 0.68, h * 0.98)
      ..cubicTo(w * 0.80, h * 1.02, w * 0.92, h * 0.90, w * 0.92, h * 0.72)
      ..cubicTo(w * 0.92, h * 0.42, w * 0.62, h * 0.28, w * 0.50, h * 0.28)
      ..close();
    canvas.drawPath(body, paint);

    final leaf = Path()
      ..moveTo(w * 0.50, h * 0.28)
      ..cubicTo(w * 0.50, h * 0.18, w * 0.62, h * 0.06, w * 0.72, h * 0.06)
      ..cubicTo(w * 0.72, h * 0.16, w * 0.60, h * 0.24, w * 0.50, h * 0.28)
      ..close();
    canvas.drawPath(leaf, paint);
  }

  @override
  bool shouldRepaint(_ApplePainter _) => false;
}

// ════════════════════════════════════════════════════════════
//  ILLUSTRATION FALLBACK
// ════════════════════════════════════════════════════════════

class _IllustrationFallback extends StatelessWidget {
  const _IllustrationFallback();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 180, height: 160,
        decoration: BoxDecoration(
          color: const Color(0x22EA4242),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.directions_car_rounded,
                size: 64, color: Color(0xFFEA4242)),
            const SizedBox(height: 8),
            Text(
              'Add your illustration to\nassets/images/',
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: 11,
                color: const Color(0xFF9E9E9E),
              ),
            ),
          ],
        ),
      ),
    );
  }
}