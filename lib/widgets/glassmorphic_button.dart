import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:riden/widgets/glass_button.dart';

class GlassmorphicButton extends StatelessWidget {
  final IconData? icon;
  final String? asset;
  final Widget? leading;
  final String text;
  final TextStyle? textStyle;
  final Color? glassColor;
  final GlassButtonType type;
  final VoidCallback? onTap;

  const GlassmorphicButton({
    this.icon,
    this.asset,
    this.leading,
    required this.text,
    this.textStyle,
    this.glassColor,
    required this.type,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                colors: glassColor != null
                    ? [
                        glassColor!,
                        glassColor!.withOpacity(glassColor!.opacity * 0.7),
                        glassColor!.withOpacity(glassColor!.opacity * 0.4),
                      ]
                    : [
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (leading != null) ...[
                    leading!,
                    const SizedBox(width: 16),
                  ] else if (icon != null) ...[
                    Icon(icon, size: 26, color: Colors.black87),
                    const SizedBox(width: 16),
                  ] else if (asset != null) ...[
                    Image.asset(asset!, height: 26, width: 26),
                    const SizedBox(width: 16),
                  ],
                  Text(
                    text,
                    style: textStyle ??
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
      ),
    );
  }
}