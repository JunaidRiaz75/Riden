// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class GlassField extends StatelessWidget {
  final Widget child;
  final double height;
  final EdgeInsets? padding;

  const GlassField({
    required this.child,
    this.height = 56,
    this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 14),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.17),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withOpacity(0.22)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}
