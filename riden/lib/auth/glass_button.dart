// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:flutter/material.dart';

class GlassButton extends StatelessWidget {
  final IconData? icon; // use only for square buttons
  final String? asset;
  final String text;
  final VoidCallback onTap;
  final TextStyle? textStyle;
  final Color? glassColor;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  const GlassButton({
    this.icon,
    this.asset,
    required this.text,
    required this.onTap,
    this.textStyle,
    this.glassColor,
    this.width,
    this.height,
    this.borderRadius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double buttonWidth = width ?? double.infinity;
    final double buttonHeight = height ?? 54;
    final BorderRadius effectiveRadius =
        borderRadius ?? BorderRadius.circular(24);

    final Widget buttonContent = Center(
      child: text.isNotEmpty
          ? Text(
              text,
              style:
                  textStyle ??
                  const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.1,
                  ),
            )
          : (icon != null
                ? Icon(icon, size: 28, color: Colors.black87)
                : (asset != null
                      ? Image.asset(asset!, height: 28, width: 28)
                      : const SizedBox())),
    );

    // For glassy sign up
    final Widget glassyButton = Container(
      width: buttonWidth,
      height: buttonHeight,
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        gradient: (text.isNotEmpty)
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(
                    0xFFFF161F,
                  ).withOpacity(0.71), // glassy red (matches picker)
                  Color(0xFFFB3E5A).withOpacity(0.65), // glassy bright red
                ],
              )
            : null,
        color: (text.isEmpty)
            ? (glassColor ?? Colors.white.withOpacity(0.17))
            : null,
        borderRadius: borderRadius ?? BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: effectiveRadius,
          onTap: onTap,
          child: buttonContent,
        ),
      ),
    );

    // Glassy blur for pill button
    return text.isNotEmpty
        ? ClipRRect(
            borderRadius: borderRadius ?? BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: glassyButton,
            ),
          )
        : glassyButton;
  }
}
