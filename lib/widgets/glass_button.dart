// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';

enum GlassButtonType { primary, secondary }

class GlassButton extends StatelessWidget {
  final IconData? icon;
  final String? asset;
  final String text;
  final VoidCallback onTap;
  final TextStyle? textStyle;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final GlassButtonType type;
  final Color? iconColor; // <-- add this

  const GlassButton({
    this.icon,
    this.asset,
    required this.text,
    required this.onTap,
    this.textStyle,
    this.width,
    this.height,
    this.borderRadius,
    this.type = GlassButtonType.primary,
    this.iconColor, // <-- add this
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double buttonWidth = width ?? double.infinity;
    final double buttonHeight = height ?? 54;
    final BorderRadius effectiveRadius =
        borderRadius ?? BorderRadius.circular(26);

    final List<Color> primaryGradient = [
      const Color(0xFFFF5151).withOpacity(0.93),
      const Color(0xFFF82B2B).withOpacity(0.96),
      const Color(0xFFD41C1C).withOpacity(0.89),
    ];
    final List<Color> secondaryGradient = [
      Colors.white.withOpacity(0.16),
      Colors.white.withOpacity(0.13),
    ];

    final List<BoxShadow> primaryShadow = [
      BoxShadow(
        color: Colors.redAccent.withOpacity(0.13),
        blurRadius: 22,
        offset: const Offset(0, 7),
      ),
    ];
    final List<BoxShadow> secondaryShadow = [
      BoxShadow(
        color: Colors.black.withOpacity(0.09),
        blurRadius: 12,
        offset: const Offset(0, 5),
      ),
    ];

    final Widget buttonContent = Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(
                icon,
                size: 22,
                color:
                    iconColor ?? // <-- use color if provided, else fallback
                    (type == GlassButtonType.primary
                        ? Colors.white
                        : Colors.white.withOpacity(0.90)),
              ),
            ),
          if (asset != null)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Image.asset(asset!, height: 24, width: 24),
            ),
          Flexible(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  textStyle ??
                  TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 17,
                    color: Colors.white.withOpacity(
                      type == GlassButtonType.primary ? 1.0 : 0.96,
                    ),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.1,
                  ),
            ),
          ),
        ],
      ),
    );

    final Widget glassyButton = Container(
      width: buttonWidth,
      height: buttonHeight,
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: type == GlassButtonType.primary
              ? primaryGradient
              : secondaryGradient,
          stops: type == GlassButtonType.primary
              ? [0.01, 0.55, 1.0]
              : [0.12, 1.0],
        ),
        borderRadius: effectiveRadius,
        boxShadow: type == GlassButtonType.primary
            ? primaryShadow
            : secondaryShadow,
        border: Border.all(
          color: type == GlassButtonType.primary
              ? Colors.white.withOpacity(0.11)
              : Colors.white.withOpacity(0.19),
          width: 1.1,
        ),
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

    return ClipRRect(
      borderRadius: effectiveRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: glassyButton,
      ),
    );
  }
}
