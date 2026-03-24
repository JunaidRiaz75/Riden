import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riden/widgets/glass_field.dart';

class GlassInputField extends StatelessWidget {
  final String hint;
  final IconData icon;

  const GlassInputField({
    super.key,
    required this.hint,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GlassField(
      child: TextFormField(
        style: GoogleFonts.poppins(color: Colors.white, fontSize: 15),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: GoogleFonts.poppins(
            color: Colors.white.withOpacity(0.7),
            fontSize: 14,
          ),
          icon: Icon(
            icon,
            color: Colors.white.withOpacity(0.7),
            size: 20,
          ),
        ),
      ),
    );
  }
}
