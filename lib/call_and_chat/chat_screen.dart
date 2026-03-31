// chat_bottom_sheet.dart
// ignore_for_file: use_super_parameters, deprecated_member_use

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:Riden/widgets/riden_bottom_nav.dart';

import '../theme/app_colors.dart';

// ─────────────────────────────────────────────────────────────────────────────
// HOW TO OPEN (from your home screen):
//
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     backgroundColor: Colors.transparent,
//     barrierColor: Colors.black54,
//     builder: (_) => const ChatBottomSheetEntry(),
//   );
// ─────────────────────────────────────────────────────────────────────────────

class ChatBottomSheetEntry extends StatelessWidget {
  const ChatBottomSheetEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.60,
      minChildSize: 0.40,
      maxChildSize: 1.0,
      expand: false, // CRITICAL — lets modal own the outer sizing
      snap: true,
      snapSizes: const [0.40, 0.70, 1.0],
      builder: (context, scrollController) {
        return ChatBottomSheet(scrollController: scrollController);
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// MAIN SHEET BODY
// ─────────────────────────────────────────────────────────────────────────────
class ChatBottomSheet extends StatefulWidget {
  final ScrollController scrollController;
  const ChatBottomSheet({required this.scrollController, super.key});

  @override
  State<ChatBottomSheet> createState() => _ChatBottomSheetState();
}

class _ChatBottomSheetState extends State<ChatBottomSheet> {
  final List<Map<String, dynamic>> messages = [
    {'type': 'received', 'text': 'Welcome to a wonderful experience', 'time': '8:29 pm'},
    {'type': 'sent', 'text': 'Thanks For Letting Me In', 'time': '8:30 pm'},
    {'type': 'received', 'text': 'Well That\'s Just Kind Of You', 'time': 'Just Now'},
  ];

  final TextEditingController _msgController = TextEditingController();

  void _sendMessage() {
    if (_msgController.text.trim().isEmpty) return;
    setState(() {
      messages.add({
        'type': 'sent',
        'text': _msgController.text.trim(),
        'time': 'Just now',
      });
      _msgController.clear();
    });
  }

  @override
  void dispose() {
    _msgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double sheetH = constraints.maxHeight;
        final double sheetW = constraints.maxWidth;

        // progress: 0.0 = min collapsed, 1.0 = full screen
        final double minH = screenHeight * 0.40;
        final double maxH = screenHeight * 1.00;
        final double progress =
            ((sheetH - minH) / (maxH - minH)).clamp(0.0, 1.0);

        // Corners flatten as sheet goes full screen
        final double cornerRadius = 28.0 * (1.0 - progress);

        return ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(cornerRadius),
            topRight: Radius.circular(cornerRadius),
          ),
          child: SizedBox(
            width: sheetW,
            height: sheetH,
            child: Stack(
              children: [
                // ── 1. Gradient background — CustomPainter, always exact fit ──
                Positioned.fill(
                  child: CustomPaint(
                    painter: _SheetGradientPainter(),
                  ),
                ),

                // ── 2. Frosted glass blur layer — matches Image 1 glassy feel ──
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
                    child: Container(
                      decoration: BoxDecoration(
                        // semi-transparent white glass tint
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

                // ── 3. Foreground content ──
                Column(
                  mainAxisSize: MainAxisSize.max,
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

                    // ── Header: "< Back  Chat  📞" ──
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Row(
                        children: [
                          // Back button
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Row(
                              children: [
                                const Icon(Icons.chevron_left,
                                    color: Colors.white, size: 22),
                                Text(
                                  'Back',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Title centered
                          Expanded(
                            child: Center(
                              child: Text(
                                'Chat',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
                          // Phone icon
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.call_outlined,
                                color: Colors.white, size: 20),
                          ),
                        ],
                      ),
                    ),

                    // ── Messages ──
                    Expanded(
                      child: ListView.builder(
                        controller: widget.scrollController,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 6),
                        itemCount: messages.length,
                        itemBuilder: (ctx, i) {
                          final msg = messages[i];
                          final isSent = msg['type'] == 'sent';
                          return _buildMessageRow(msg, isSent);
                        },
                      ),
                    ),

                    // ── Input bar ──
                    _InputArea(
                      controller: _msgController,
                      onSend: _sendMessage,
                    ),

                    const SizedBox(height: 6),

                    // ── Standardized Bottom Nav ──
                    RidenBottomNav(
                      selectedIndex: 1,
                      isFromSheet: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMessageRow(Map<String, dynamic> msg, bool isSent) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Column(
        crossAxisAlignment:
            isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (!isSent)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar circle
                CircleAvatar(
                  radius: 16,
                  backgroundImage:
                      const AssetImage('assets/images/avatar.png'),
                  onBackgroundImageError: (_, __) {},
                  child: const Icon(Icons.person, size: 16, color: Colors.white),
                ),
                const SizedBox(width: 8),
                Flexible(child: _MessageBubble(text: msg['text'], isSent: false)),
              ],
            ),
          if (isSent)
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: _MessageBubble(text: msg['text'], isSent: true),
            ),
          Padding(
            padding: EdgeInsets.only(
              left: isSent ? 0 : 46,
              right: isSent ? 4 : 0,
              top: 3,
              bottom: 10,
            ),
            child: Text(
              msg['time'],
              style: GoogleFonts.poppins(
                color: Colors.white54,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// GRADIENT PAINTER  —  replicates Image 2: warm copper left, teal right
// Always paints to exactly the canvas size → no fit/overflow issues ever
// ─────────────────────────────────────────────────────────────────────────────
class _SheetGradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Base: dark navy (matches RidenColors.backgroundBase)
    canvas.drawRect(
      Rect.fromLTWH(0, 0, w, h),
      Paint()..color = const Color(0xFF1A1B2E),
    );

    // Warm copper/brown glow — top-left (matches Image 2 left blob)
    _radialBlob(
      canvas,
      center: Offset(w * 0.15, h * 0.30),
      rx: w * 0.70,
      ry: h * 0.50,
      color: const Color(0xFF8B4A35), // warm copper
      alpha: 170,
    );

    // Slightly deeper copper lower-left
    _radialBlob(
      canvas,
      center: Offset(w * 0.05, h * 0.55),
      rx: w * 0.50,
      ry: h * 0.35,
      color: const Color(0xFF6B3828),
      alpha: 130,
    );

    // Teal/slate glow — bottom-right (matches Image 2 right blob)
    _radialBlob(
      canvas,
      center: Offset(w * 0.82, h * 0.68),
      rx: w * 0.70,
      ry: h * 0.52,
      color: const Color(0xFF2E6B72), // teal slate
      alpha: 165,
    );

    // Lighter teal highlight
    _radialBlob(
      canvas,
      center: Offset(w * 0.90, h * 0.50),
      rx: w * 0.40,
      ry: h * 0.30,
      color: const Color(0xFF3D8A8F),
      alpha: 110,
    );

    // Center neutral blend — softens the boundary
    _radialBlob(
      canvas,
      center: Offset(w * 0.50, h * 0.50),
      rx: w * 0.55,
      ry: h * 0.40,
      color: const Color(0xFF3A4555),
      alpha: 80,
    );
  }

  void _radialBlob(
    Canvas canvas, {
    required Offset center,
    required double rx,
    required double ry,
    required Color color,
    required int alpha,
  }) {
    final solid = Color.fromARGB(alpha, color.red, color.green, color.blue);
    final clear = Color.fromARGB(0, color.red, color.green, color.blue);

    final paint = Paint()
      ..shader = RadialGradient(
        colors: [solid, clear],
      ).createShader(
        Rect.fromCenter(center: center, width: rx * 2, height: ry * 2),
      );

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.scale(1.0, ry / rx); // squish circle into ellipse
    canvas.translate(-center.dx, -center.dy);
    canvas.drawCircle(center, rx, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_SheetGradientPainter _) => false;
}

// ─────────────────────────────────────────────
// MESSAGE BUBBLE  — matches Image 1 style
// ─────────────────────────────────────────────
class _MessageBubble extends StatelessWidget {
  final String text;
  final bool isSent;

  const _MessageBubble({required this.text, required this.isSent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(18),
          topRight: const Radius.circular(18),
          bottomLeft: Radius.circular(isSent ? 18 : 4),
          bottomRight: Radius.circular(isSent ? 4 : 18),
        ),
        // Received: glassy white | Sent: deep red/maroon as in screenshot
        color: isSent
            ? const Color(0xFF7B2020)
            : Colors.white.withOpacity(0.15),
        border: Border.all(
          color: isSent
              ? Colors.redAccent.withOpacity(0.6)
              : Colors.white.withOpacity(0.18),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// INPUT AREA  — matches Image 1
// ─────────────────────────────────────────────
class _InputArea extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const _InputArea({required this.controller, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.10),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.15), width: 1),
      ),
      child: Row(
        children: [
          const Icon(Icons.emoji_emotions_outlined,
              color: Colors.white60, size: 22),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Type your message',
                hintStyle:
                    GoogleFonts.poppins(color: Colors.white38, fontSize: 14),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
              onSubmitted: (_) => onSend(),
            ),
          ),
          // Voice button
          Container(
            decoration: const BoxDecoration(
              color: Colors.redAccent,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(9),
            child: const Icon(Icons.mic, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 8),
          // Send button
          GestureDetector(
            onTap: onSend,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.redAccent,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.redAccent.withOpacity(0.35),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(9),
              child: const Icon(Icons.send_rounded, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}