// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';

class GlassSection extends StatelessWidget {
  final Widget child;
  final double radius;
  final double blur;
  final double opacity;
  final Color borderColor;
  final EdgeInsets? padding;
  final double? width, height;

  const GlassSection({
    required this.child,
    this.radius = 32,
    this.blur = 18,
    this.opacity = 0.36,
    this.borderColor = const Color(0x44FFFFFF),
    this.padding,
    this.width,
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          width: width,
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(opacity),
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: borderColor, width: 1.2),
          ),
          child: child,
        ),
      ),
    );
  }
}
