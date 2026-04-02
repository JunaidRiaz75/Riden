// riden_logo.dart
// ignore_for_file: use_super_parameters, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─────────────────────────────────────────────────────────────────────────────
// RIDEN LOGO WIDGET  —  Clean text only
//
//  Figma specs (RIDEN text layer):
//  ┌─ Font          : Audiowide  Regular  60px
//  ├─ Fill          : #F0F0F0  30%  opacity
//
//  Usage:
//    const RidenLogo()            // default size
//    RidenLogo(fontSize: 48)      // custom size
// ─────────────────────────────────────────────────────────────────────────────
class RidenLogo extends StatelessWidget {
  /// Font size — defaults to Figma value of 60.
  final double fontSize;

  const RidenLogo({this.fontSize = 60, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'RIDEN',
      style: GoogleFonts.audiowide(
        fontSize: fontSize,
        fontWeight: FontWeight.w400, // Audiowide Regular
        // Fill: #F0F0F0 30% = 0x4DF0F0F0
        color: const Color(0x4DF0F0F0),
        letterSpacing: 2,
      ),
    );
  }
}