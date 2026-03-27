// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class GlassmorphicButton extends StatelessWidget {
  final IconData? icon;
  final String? asset;
  final String text;
  final VoidCallback onTap;
  final TextStyle? textStyle;

  const GlassmorphicButton({
    this.icon,
    this.asset,
    required this.text,
    required this.onTap,
    this.textStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 19,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          GlassmorphicContainer(
            width: double.infinity,
            height: 62,
            borderRadius: 24,
            blur: 22,
            alignment: Alignment.center,
            border: 1,
            linearGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.22),
                Colors.white.withOpacity(0.14),
                Colors.white.withOpacity(0.04),
              ],
              stops: const [0.09, 0.55, 1.0],
            ),
            borderGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.33),
                Colors.white.withOpacity(0.16),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: onTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    icon != null
                        ? Icon(icon, size: 26, color: Colors.black87)
                        : asset != null
                        ? Image.asset(asset!, height: 26, width: 26)
                        : const SizedBox(),
                    const SizedBox(width: 16),
                    Text(
                      text,
                      style:
                          textStyle ??
                          const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 17,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.1,
                            shadows: [
                              Shadow(
                                color: Colors.white24,
                                blurRadius: 4,
                                offset: Offset(1, 1),
                              ),
                            ],
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Inner shadow
          Positioned.fill(
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.15),
                      Colors.transparent,
                      Colors.black.withOpacity(0.06),
                    ],
                    stops: const [0.0, 0.8, 1.0],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
