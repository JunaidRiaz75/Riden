// complaint_ticket_bottom_sheet.dart
// ignore_for_file: use_super_parameters, deprecated_member_use

import 'dart:ui';

import 'package:Riden/widgets/riden_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ENTRY
// ─────────────────────────────────────────────────────────────────────────────
class ComplaintTicketBottomSheetEntry extends StatelessWidget {
  const ComplaintTicketBottomSheetEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.92,
      minChildSize: 0.50,
      maxChildSize: 1.0,
      expand: false,
      snap: true,
      snapSizes: const [0.50, 0.92, 1.0],
      builder: (context, scrollController) {
        return ComplaintTicketBottomSheet(scrollController: scrollController);
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// MAIN SHEET
// ─────────────────────────────────────────────────────────────────────────────
class ComplaintTicketBottomSheet extends StatefulWidget {
  final ScrollController scrollController;
  const ComplaintTicketBottomSheet({required this.scrollController, super.key});

  @override
  State<ComplaintTicketBottomSheet> createState() =>
      _ComplaintTicketBottomSheetState();
}

class _ComplaintTicketBottomSheetState
    extends State<ComplaintTicketBottomSheet> {
  String? _selectedComplaintType;
  final TextEditingController _bookingIdController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  int _charCount = 0;

  final List<String> _complaintTypes = [
    'Driver Behavior',
    'Overcharged Fare',
    'Vehicle Condition',
    'Late Arrival',
    'Wrong Route',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    _descriptionController.addListener(() {
      setState(() => _charCount = _descriptionController.text.length);
    });
  }

  @override
  void dispose() {
    _bookingIdController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double sheetH = constraints.maxHeight;
        final double minH = screenHeight * 0.50;
        final double maxH = screenHeight * 1.00;
        final double progress =
            ((sheetH - minH) / (maxH - minH)).clamp(0.0, 1.0);
        final double cornerRadius = 28.0 * (1.0 - progress);

        return ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(cornerRadius),
            topRight: Radius.circular(cornerRadius),
          ),
          child: Stack(
            children: [
              // ── 1. Gradient background ──
              Positioned.fill(
                child: CustomPaint(painter: _GradientPainter()),
              ),

              // ── 2. Frosted glass blur ──
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.06),
                      border: Border(
                        top: BorderSide(
                          color: Colors.white.withOpacity(0.18),
                          width: 1.2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // ── 3. Content ──
              Column(
                children: [
                  // Drag handle
                  AnimatedOpacity(
                    opacity: (1.0 - progress).clamp(0.0, 1.0),
                    duration: const Duration(milliseconds: 150),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 2),
                      child: Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.35),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: ListView(
                      controller: widget.scrollController,
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      children: [
                        // Header
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Back',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Center(
                          child: Text(
                            'Submit Complaint Ticket',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 19,
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),

                        // ── Complaint Type ──
                        _FieldLabel('Complaint Type'),
                        const SizedBox(height: 8),
                        _GlassDropdown(
                          hint: 'Select Complaint Type',
                          value: _selectedComplaintType,
                          items: _complaintTypes,
                          onChanged: (val) =>
                              setState(() => _selectedComplaintType = val),
                        ),
                        const SizedBox(height: 20),

                        // ── Booking ID ──
                        _FieldLabel('Booking ID'),
                        const SizedBox(height: 8),
                        _GlassTextField(
                          controller: _bookingIdController,
                          hint: 'Enter Booking ID',
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 20),

                        // ── Complaint Description ──
                        _FieldLabel('Complaint Description'),
                        const SizedBox(height: 8),
                        _GlassTextField(
                          controller: _descriptionController,
                          hint: 'Write...',
                          maxLines: 6,
                          minLines: 6,
                        ),
                        const SizedBox(height: 20),

                        // ── Attach File ──
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _FieldLabel('Attach File'),
                            Text(
                              '${_charCount}/80',
                              style: GoogleFonts.poppins(
                                color: Colors.white54,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 110,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.25),
                                width: 1.5,
                                // Dashed feel via low opacity
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.12),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.upload_rounded,
                                    color: Colors.white70,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Upload',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white70,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Center(
                          child: Text(
                            'File must be less than 5MB and in JPEG or PNG',
                            style: GoogleFonts.poppins(
                              color: Colors.white38,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),

                        // ── Submit Button ──
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE53935),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text(
                              'Submit',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),

                  // Bottom Nav
                  RidenBottomNav(selectedIndex: 1),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// HELPERS
// ─────────────────────────────────────────────────────────────────────────────
class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _GlassTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int maxLines;
  final int minLines;
  final TextInputType keyboardType;

  const _GlassTextField({
    required this.controller,
    required this.hint,
    this.maxLines = 1,
    this.minLines = 1,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.white.withOpacity(0.22),
          width: 1,
        ),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        minLines: minLines,
        keyboardType: keyboardType,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.poppins(
            color: Colors.white38,
            fontSize: 14,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class _GlassDropdown extends StatelessWidget {
  final String hint;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _GlassDropdown({
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.white.withOpacity(0.22),
          width: 1,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(
            hint,
            style: GoogleFonts.poppins(color: Colors.white38, fontSize: 14),
          ),
          isExpanded: true,
          dropdownColor: const Color(0xFF2A2C40),
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              color: Colors.white70),
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// GRADIENT PAINTER
// ─────────────────────────────────────────────────────────────────────────────
class _GradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h),
        Paint()..color = const Color(0xFF1A1B2E));
    _blob(canvas,
        center: Offset(w * 0.15, h * 0.30),
        rx: w * 0.70,
        ry: h * 0.50,
        color: const Color(0xFF8B4A35),
        alpha: 170);
    _blob(canvas,
        center: Offset(w * 0.05, h * 0.55),
        rx: w * 0.50,
        ry: h * 0.35,
        color: const Color(0xFF6B3828),
        alpha: 130);
    _blob(canvas,
        center: Offset(w * 0.82, h * 0.68),
        rx: w * 0.70,
        ry: h * 0.52,
        color: const Color(0xFF2E6B72),
        alpha: 165);
    _blob(canvas,
        center: Offset(w * 0.90, h * 0.50),
        rx: w * 0.40,
        ry: h * 0.30,
        color: const Color(0xFF3D8A8F),
        alpha: 110);
    _blob(canvas,
        center: Offset(w * 0.50, h * 0.50),
        rx: w * 0.55,
        ry: h * 0.40,
        color: const Color(0xFF3A4555),
        alpha: 80);
  }

  void _blob(Canvas canvas,
      {required Offset center,
      required double rx,
      required double ry,
      required Color color,
      required int alpha}) {
    final solid = Color.fromARGB(alpha, color.red, color.green, color.blue);
    final clear = Color.fromARGB(0, color.red, color.green, color.blue);
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.scale(1.0, ry / rx);
    canvas.translate(-center.dx, -center.dy);
    canvas.drawCircle(
        center,
        rx,
        Paint()
          ..shader = RadialGradient(colors: [solid, clear]).createShader(
              Rect.fromCenter(
                  center: center, width: rx * 2, height: ry * 2)));
    canvas.restore();
  }

  @override
  bool shouldRepaint(_GradientPainter _) => false;
}
