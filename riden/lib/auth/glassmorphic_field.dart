import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class GlassmorphicField extends StatelessWidget {
  final Widget child;
  final double height;
  final EdgeInsets? padding;

  const GlassmorphicField({
    required this.child,
    this.height = 56,
    this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: height,
      borderRadius: 14,
      blur: 16,
      border: 1,
      linearGradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.white24, Colors.white10],
        stops: [0, 1],
      ),
      borderGradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.white38, Colors.white12],
        stops: [0, 1],
      ),
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 14),
      child: child,
    );
  }
}
