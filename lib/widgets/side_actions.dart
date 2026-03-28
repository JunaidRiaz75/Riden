// ignore_for_file: deprecated_member_use

import 'package:Riden/home/add_place_screen.dart';
import 'package:flutter/material.dart';

class GlassySideActions extends StatelessWidget {
  final VoidCallback onBell, onLocation;
  const GlassySideActions({
    required this.onBell,
    required this.onLocation,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.22),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: GlassSection(
        radius: 32,
        blur: 18,
        // Match opacity feel with bottom nav/search; shadow keeps it visible
        opacity: 0.21,
        width: 62,
        height: 130,
        borderColor: Colors.white.withOpacity(0.16),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                Icons.my_location,
                color: Colors.white.withOpacity(0.92),
                size: 28,
              ),
              onPressed: onBell,
            ),
            const SizedBox(height: 10),
            IconButton(
              icon: Icon(
                Icons.near_me_rounded,
                color: Colors.white.withOpacity(0.92),
                size: 26,
              ),
              onPressed: onLocation,
            ),
          ],
        ),
      ),
    );
  }
}
