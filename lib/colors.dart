// ============================================================
//  RIDEN — Dark Theme Colors & Gradient Background
//
//  Usage:
//    1. Import this file wherever needed
//    2. Use RidenColors.xxx for individual color values
//    3. Drop RidenDarkBackground() inside any Stack as the
//       very first child to get the full gradient background
//
//  Example:
//    Stack(
//      fit: StackFit.expand,
//      children: [
//        const RidenDarkBackground(),
//        // ... your screen content
//      ],
//    )
// ============================================================

import 'package:flutter/material.dart';

// ════════════════════════════════════════════════════════════
//  RIDEN COLOR PALETTE
//  All values pixel-sampled from the dark design (01.png)
// ════════════════════════════════════════════════════════════

abstract class RidenColors {

  // ── Background base ─────────────────────────────────────
  /// Near-black navy — the darkest base (bottom & corners)
  static const Color backgroundBase       = Color(0xFF18192B);

  /// Dark purple-plum — top-left region
  static const Color backgroundTopLeft    = Color(0xFF3C3441);

  /// Deep navy — top-right region
  static const Color backgroundTopRight   = Color(0xFF1B1C2E);

  // ── Left warm glow (copper / brown) ────────────────────
  /// Warm dark brown/copper — primary left glow
  static const Color warmCopper           = Color(0xFF734337);

  /// Deeper copper — secondary left highlight
  static const Color warmCopperDeep       = Color(0xFF62412E);

  /// Lightest copper tone (top of left region)
  static const Color warmCopperLight      = Color(0xFF69403A);

  // ── Right teal / slate glow ─────────────────────────────
  /// Dark teal-slate — primary right glow
  static const Color tealSlate            = Color(0xFF3A5F72);

  /// Brighter teal — secondary right highlight
  static const Color tealSlateLight       = Color(0xFF547483);

  /// Deep teal at lower-right
  static const Color tealSlateDark        = Color(0xFF2B4F65);

  // ── Center blend ───────────────────────────────────────
  /// Muted dark teal-gray — center intersection glow
  static const Color centerBlend          = Color(0xFF3A4C55);

  /// Slightly lighter center tone
  static const Color centerBlendLight     = Color(0xFF627070);

  // ── Brand / accent ──────────────────────────────────────
  /// RIDEN primary red (app brand color)
  static const Color brandRed             = Color(0xFFEA4242);

  /// Red glow — for shadows and glows (50 % opacity)
  static const Color brandRedGlow         = Color(0x80EA4242);

  // ── Text ────────────────────────────────────────────────
  static const Color textPrimary          = Color(0xFFFFFFFF);
  static const Color textSecondary        = Color(0xFFBDBDBD);
  static const Color textHint             = Color(0xFF757575);

  // ── Surface / glass ─────────────────────────────────────
  /// Dark frosted-glass surface (buttons, cards)
  static const Color glassSurface         = Color(0x993A3F48);

  /// Glass border
  static const Color glassBorder          = Color(0x33FFFFFF);

  // ── Utility ─────────────────────────────────────────────
  static const Color divider              = Color(0x22FFFFFF);
  static const Color homeIndicator        = Color(0x55FFFFFF);
  static const Color shadowDark           = Color(0x40000000);
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
    return SizedBox.expand(
      child: CustomPaint(painter: _DarkGradientPainter()),
    );
  }
}

// ════════════════════════════════════════════════════════════
//  PAINTER — 9 elliptical gradient blobs stacked
//
//  Pixel-sampled layer breakdown:
//
//  1. Base fill     #18192B  full screen
//  2. Top-left band #3C3441  dark purple-plum, top-left
//  3. Top-right     #1B1C2E  deeper navy, top-right
//  4. Left glow     #734337  warm copper,   y≈30-50% x=left
//  5. Left deep     #62412E  deeper copper, y≈45%    x=left
//  6. Right glow    #3A5F72  dark teal,     y≈45-65% x=right
//  7. Right light   #547483  brighter teal, y≈55%    x=right
//  8. Center blend  #3A4C55  muted teal-gray center glow
//  9. Bottom fade   #18192B  snaps bottom back to near-black
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
    _blob(canvas,
      center: Offset(w * 0.0, h * 0.0),
      rx: w * 1.0,  ry: h * 0.45,
      color: RidenColors.backgroundTopLeft, alpha: 200,
    );

    // 3. Top-right deep navy accent
    _blob(canvas,
      center: Offset(w * 1.05, h * 0.0),
      rx: w * 0.70, ry: h * 0.35,
      color: RidenColors.backgroundTopRight, alpha: 220,
    );

    // 4. Left warm copper/brown glow
    _blob(canvas,
      center: Offset(w * -0.05, h * 0.38),
      rx: w * 0.72, ry: h * 0.38,
      color: RidenColors.warmCopper, alpha: 190,
    );

    // 5. Left deeper copper highlight
    _blob(canvas,
      center: Offset(w * 0.02, h * 0.46),
      rx: w * 0.45, ry: h * 0.22,
      color: RidenColors.warmCopperDeep, alpha: 140,
    );

    // 6. Right teal/slate glow
    _blob(canvas,
      center: Offset(w * 1.05, h * 0.50),
      rx: w * 0.72, ry: h * 0.42,
      color: RidenColors.tealSlate, alpha: 200,
    );

    // 7. Right teal lighter highlight
    _blob(canvas,
      center: Offset(w * 0.92, h * 0.55),
      rx: w * 0.45, ry: h * 0.28,
      color: RidenColors.tealSlateLight, alpha: 155,
    );

    // 8. Center muted teal-gray blend
    _blob(canvas,
      center: Offset(w * 0.50, h * 0.50),
      rx: w * 0.65, ry: h * 0.30,
      color: RidenColors.centerBlend, alpha: 100,
    );

    // 9. Bottom dark overlay — returns to near-black
    _blob(canvas,
      center: Offset(w * 0.50, h * 1.08),
      rx: w * 0.90, ry: h * 0.38,
      color: RidenColors.backgroundBase, alpha: 255,
    );
  }

  /// Draws one elliptical radial-gradient blob.
  /// Uses [alpha] 0-255 to avoid deprecated withOpacity().
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
        Color.fromARGB(0, color.red, color.green, color.blue);

    final paint = Paint()
      ..shader = RadialGradient(
        colors: [solidColor, clearColor],
      ).createShader(
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