// glass_field.dart
// ignore_for_file: use_super_parameters, deprecated_member_use

import 'dart:ui';

import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// GLASS FIELD — pixel-perfect Figma translation
//
//  Figma specs:
//  ┌─ Fill          : #FFFFFF  10%
//  ├─ Stroke        : Angular gradient  50%  Inside  weight 1
//  ├─ Corner radius : 20
//  ├─ H             : 50
//  ├─ Inner shadow 1: x 0   y -3  blur 4   spread 0  #FFFFFF 15%
//  ├─ Inner shadow 2: x 0   y  3  blur 4   spread 0  #FFFFFF 15%
//  ├─ Drop shadow 1 : x -42 y 103 blur 31  spread 0  #919191  0%
//  ├─ Drop shadow 2 : x -27 y  66 blur 29  spread 0  #919191  1%
//  ├─ Drop shadow 3 : x -15 y  37 blur 24  spread 0  #919191  3%
//  ├─ Drop shadow 4 : x  -7 y  17 blur 18  spread 0  #919191  4%
//  ├─ Drop shadow 5 : x  -2 y   4 blur 10  spread 0  #919191  5%
//  └─ Background blur (last effect layer)
// ─────────────────────────────────────────────────────────────────────────────
class GlassField extends StatelessWidget {
  final Widget child;
  final double height;
  final EdgeInsets? padding;

  const GlassField({
    required this.child,
    this.height = 50, // Figma H: 50
    this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      height: height,
      padding: padding,
      child: child,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// GLASS CONTAINER — Reusable premium glassmorphic shell
// ─────────────────────────────────────────────────────────────────────────────
class GlassContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double height;
  final double borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  const GlassContainer({
    required this.child,
    this.width,
    this.height = 50,
    this.borderRadius = 20,
    this.padding,
    this.margin,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height,
      margin: margin ?? const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: const [
          // ── Drop shadows from Figma ──────────────────────────────────────
          BoxShadow(
            color: Color(0x00919191),
            offset: Offset(-42, 103),
            blurRadius: 31,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0x03919191),
            offset: Offset(-27, 66),
            blurRadius: 29,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0x08919191),
            offset: Offset(-15, 37),
            blurRadius: 24,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0x0A919191),
            offset: Offset(-7, 17),
            blurRadius: 18,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0x0D919191),
            offset: Offset(-2, 4),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Stack(
            children: [
              // ── Fill Color ──────────────────────────────────────────────
              Container(
                width: double.infinity,
                height: height,
                padding: padding ?? const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  color: const Color(0x1AFFFFFF), // 10% white
                ),
                child: Center(child: child),
              ),

              // ── Inner shadow 1 (Top Shine) ──────────────────────────────
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: IgnorePointer(
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(borderRadius),
                        topRight: Radius.circular(borderRadius),
                      ),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0x26FFFFFF), // 15% white
                          Color(0x00FFFFFF),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // ── Inner shadow 2 (Bottom Shine) ───────────────────────────
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: IgnorePointer(
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(borderRadius),
                        bottomRight: Radius.circular(borderRadius),
                      ),
                      gradient: const LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Color(0x26FFFFFF),
                          Color(0x00FFFFFF),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // ── Angular Stroke ──────────────────────────────────────────
              Positioned.fill(
                child: IgnorePointer(
                  child: CustomPaint(
                    painter: _AngularStrokePainter(
                      borderRadius: borderRadius,
                      strokeWidth: 1,
                      opacity: 0.50,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ANGULAR STROKE PAINTER
// ─────────────────────────────────────────────────────────────────────────────
class _AngularStrokePainter extends CustomPainter {
  final double borderRadius;
  final double strokeWidth;
  final double opacity;

  const _AngularStrokePainter({
    required this.borderRadius,
    required this.strokeWidth,
    required this.opacity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final inset = strokeWidth / 2;
    final rect = Rect.fromLTWH(
        inset, inset, size.width - strokeWidth, size.height - strokeWidth);
    final rrect =
        RRect.fromRectAndRadius(rect, Radius.circular(borderRadius - inset));

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = SweepGradient(
        center: Alignment.center,
        startAngle: 0,
        endAngle: 3.14159265 * 2,
        colors: [
          Color.fromRGBO(255, 255, 255, 0.60 * opacity),
          Color.fromRGBO(255, 255, 255, 0.20 * opacity),
          Color.fromRGBO(255, 255, 255, 0.10 * opacity),
          Color.fromRGBO(255, 255, 255, 0.35 * opacity),
          Color.fromRGBO(255, 255, 255, 0.60 * opacity),
        ],
        stops: const [0.0, 0.25, 0.50, 0.75, 1.0],
      ).createShader(rect);

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(_AngularStrokePainter old) =>
      old.borderRadius != borderRadius ||
      old.strokeWidth != strokeWidth ||
      old.opacity != opacity;
}