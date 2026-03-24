// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:riden/widgets/glass.dart';

class GlassySearchBar extends StatelessWidget {
  final VoidCallback? onCarTap;
  const GlassySearchBar({this.onCarTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GlassSection(
      radius: 24,
      blur: 18,
      opacity: 0.20,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      borderColor: Colors.white.withOpacity(0.11),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Where to go...',
              style: TextStyle(
                fontSize: 15.5,
                color: Colors.white.withOpacity(0.92),
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          GestureDetector(
            onTap: onCarTap,
            child: GlassSection(
              radius: 18,
              blur: 10,
              opacity: 0.18,
              width: 36,
              height: 36,
              borderColor: Colors.white.withOpacity(0.13),
              child: Icon(
                Icons.directions_car_rounded,
                color: Colors.white.withOpacity(0.93),
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
