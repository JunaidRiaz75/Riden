// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

// ─────────────── LIGHT THEME COLORS ────────────────
class AppColors {
  static const gradientColors = [
    Color(0xFFF9F6F5),
    Color(0xFFECC9B3),
    Color(0xFFD6DFDF),
    Color(0xFFA7C5C9),
    Color(0xFFE1F3F5),
  ];
  static const gradientStops = [0.0, 0.23, 0.52, 0.73, 1.0];
  static const primaryRed = Color(0xFFFF161F);
  static const textDark = Color(0xFF141414);
  static const divider = Colors.black26;
  static const glassWhite = Colors.white;

  static Color glassShadow = Colors.white.withOpacity(0.2);
}

// ─────────────── DARK THEME COLORS ────────────────
class AppColorsDark {
  static const gradientColors = [
    Color(0xFF2B3146),
    Color(0xFF242B40),
    Color(0xFF1C2438),
    Color(0xFF162033),
    Color(0xFF10192D),
    Color(0xFF0D1528),
    Color(0xFF0A1124),
  ];
  static const gradientStops = [0.0, 0.18, 0.38, 0.58, 0.76, 0.9, 1.0];
  static const primaryRed = Color(0xFFFF161F);
  static const textDark = Colors.white;
  static const divider = Colors.white24;
  static const glassWhite = Colors.white;
}

// ─────────────── RIDEN CUSTOM DARK PALETTE ────────────────
abstract class RidenColors {
  static const Color backgroundBase = Color(0xFF18192B);
  static const Color backgroundTopLeft = Color(0xFF3C3441);
  static const Color backgroundTopRight = Color(0xFF1B1C2E);
  static const Color warmCopper = Color(0xFF734337);
  static const Color warmCopperDeep = Color(0xFF62412E);
  static const Color warmCopperLight = Color(0xFF69403A);
  static const Color tealSlate = Color(0xFF3A5F72);
  static const Color tealSlateLight = Color(0xFF547483);
  static const Color tealSlateDark = Color(0xFF2B4F65);
  static const Color centerBlend = Color(0xFF3A4C55);
  static const Color centerBlendLight = Color(0xFF627070);

  static const Color brandRed = Color(0xFFEA4242);
  static const Color brandRedGlow = Color(0x80EA4242);

  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFBDBDBD);
  static const Color textHint = Color(0xFF757575);

  static const Color glassSurface = Color(0x993A3F48);
  static const Color glassBorder = Color(0x33FFFFFF);

  static const Color divider = Color(0x22FFFFFF);
  static const Color homeIndicator = Color(0x55FFFFFF);
  static const Color shadowDark = Color(0x40000000);
}

// ─────────────── RIDEN DARK BACKGROUND WIDGET ────────────────

class RidenDarkBackground extends StatelessWidget {
  const RidenDarkBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(child: CustomPaint(painter: _DarkGradientPainter()));
  }
}

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

  /// Draws one elliptical radial-gradient blob.
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

    // Scale vertically to create an ellipse from a circle
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
