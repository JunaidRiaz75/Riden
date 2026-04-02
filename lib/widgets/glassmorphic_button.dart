import 'package:Riden/widgets/glass_button.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';

class GlassmorphicButton extends StatelessWidget {
  final IconData? icon;
  final String? asset;
  final Widget? leading;
  final String text;
  final TextStyle? textStyle;
  final Color? glassColor;
  final GlassButtonType type;
  final VoidCallback? onTap;
  final double height;
  final double? width;

  const GlassmorphicButton({
    this.icon,
    this.asset,
    this.leading,
    required this.text,
    this.textStyle,
    this.glassColor,
    required this.type,
    this.onTap,
    this.height = 58.0, // Standardized for premium feel
    this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 2),
        width: width, // Apply custom width if provided
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), // Smoother pill look
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.18),
              blurRadius: 30, // Deeper for 3D elevation
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Stack(
          children: [
            GlassmorphicContainer(
              width: double.infinity,
              height: height,
              borderRadius: 30,
              blur: 22,
              alignment: Alignment.center,
              border: 1,
              linearGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: glassColor != null
                    ? [
                        glassColor!,
                        glassColor!.withOpacity(glassColor!.opacity * 0.75),
                        glassColor!.withOpacity(glassColor!.opacity * 0.45),
                      ]
                    : [
                        Colors.white.withOpacity(0.16),
                        Colors.white.withOpacity(0.10),
                        Colors.white.withOpacity(0.04),
                      ],
                stops: const [0.09, 0.55, 1.0],
              ),
              borderGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.55), // Crisp silver highlight
                  Colors.white.withOpacity(0.12),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 60), // Precise vertical stacking
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (leading != null) ...[
                      SizedBox(width: 26, height: 26, child: Center(child: leading!)),
                      const SizedBox(width: 25),
                    ] else if (icon != null) ...[
                      Icon(icon, size: 26, color: Colors.white),
                      const SizedBox(width: 25),
                    ] else if (asset != null) ...[
                      Image.asset(asset!, height: 26, width: 26),
                      const SizedBox(width: 25),
                    ],
                    Text(
                      text,
                      style:
                          textStyle ??
                          GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w500, // Medium weight
                            letterSpacing: 0.1,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            // Intensive 3D Beveled Highlight & Shadow
            Positioned.fill(
              child: IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.32),
                        Colors.transparent,
                        Colors.black.withOpacity(0.24),
                      ],
                      stops: const [0.0, 0.45, 1.0],
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
