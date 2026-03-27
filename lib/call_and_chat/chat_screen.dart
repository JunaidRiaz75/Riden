// chat_bottom_sheet.dart
// ignore_for_file: use_super_parameters, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../theme/app_colors.dart';

class ChatBottomSheet extends StatefulWidget {
  final ScrollController scrollController;

  const ChatBottomSheet({required this.scrollController, super.key});

  @override
  State<ChatBottomSheet> createState() => _ChatBottomSheetState();
}

class _ChatBottomSheetState extends State<ChatBottomSheet> {
  final List<Map<String, dynamic>> messages = [
    {
      'type': 'received',
      'avatar': 'assets/images/avatar.png',
      'text': 'Good Evening!',
      'time': '8:29 pm',
    },
    {
      'type': 'received',
      'avatar': 'assets/images/avatar.png',
      'text': 'Welcome to Riden Customer Service',
      'time': '8:29 pm',
    },
    {
      'type': 'sent',
      'text': 'Hello, I need help with my booking',
      'time': '8:29 pm',
    },
    {
      'type': 'received',
      'avatar': 'assets/images/avatar.png',
      'text': 'Sure! How can I help you?',
      'time': '8:28 pm',
    },
    {
      'type': 'sent',
      'text': 'My driver is taking too long',
      'time': 'Just now',
    },
  ];

  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      messages.add({
        'type': 'sent',
        'text': _controller.text.trim(),
        'time': 'Just now',
      });
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(28),
        topRight: Radius.circular(28),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // ── Dark gradient background (same as Splash) ──
          const RidenDarkBackground(),

          // ── Sheet content on top ──
          Column(
            children: [
              // Drag Handle
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Center(
                  child: Container(
                    width: 45,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),
                ),
              ),

              // Chat Header
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "Chat Support",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(color: Colors.white24, height: 1),

              // Chat messages
              Expanded(
                child: ListView.builder(
                  controller: widget.scrollController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  itemCount: messages.length,
                  reverse: false,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    final isSent = msg['type'] == 'sent';
                    return Column(
                      crossAxisAlignment: isSent
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        if (!isSent)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: CircleAvatar(
                                  radius: 17,
                                  backgroundColor: Colors.red.withOpacity(0.2),
                                  child: const Icon(
                                    Icons.support_agent,
                                    color: Colors.red,
                                    size: 18,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 7),
                              Flexible(
                                child: GlassMessageBubble(
                                  text: msg['text'],
                                  isSent: false,
                                ),
                              ),
                            ],
                          ),
                        if (isSent)
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 38,
                              top: 2,
                              right: 2,
                            ),
                            child: GlassMessageBubble(
                              text: msg['text'],
                              isSent: true,
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 46,
                            right: 12,
                            top: 2,
                            bottom: 10,
                          ),
                          child: Text(
                            msg['time'],
                            style: GoogleFonts.poppins(
                              color: Colors.white60,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              // Input Area
              GlassInputArea(controller: _controller, onSend: _sendMessage),
              const SizedBox(height: 12),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// MESSAGE BUBBLE
// ─────────────────────────────────────────────
class GlassMessageBubble extends StatelessWidget {
  final String text;
  final bool isSent;

  const GlassMessageBubble({required this.text, required this.isSent, Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: isSent
            ? const EdgeInsets.only(left: 20)
            : const EdgeInsets.only(right: 20),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isSent ? Colors.transparent : Colors.white.withOpacity(0.09),
          border: isSent
              ? Border.all(color: Colors.redAccent, width: 1.5)
              : null,
          boxShadow: [
            if (!isSent)
              BoxShadow(
                color: Colors.black.withOpacity(0.09),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// INPUT AREA
// ─────────────────────────────────────────────
class GlassInputArea extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const GlassInputArea({
    required this.controller,
    required this.onSend,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.13),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withOpacity(0.18), width: 1.2),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.emoji_emotions_outlined,
            color: Colors.white70,
            size: 24,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 15),
              decoration: InputDecoration(
                hintText: "Type your message...",
                hintStyle: GoogleFonts.poppins(
                  color: Colors.white60,
                  fontSize: 14,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onSubmitted: (_) => onSend(),
            ),
          ),
          // Send Button
          GestureDetector(
            onTap: onSend,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.redAccent,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.redAccent.withOpacity(0.28),
                    blurRadius: 14,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(10),
              child: const Icon(
                Icons.send_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Voice Button
          Container(
            decoration: const BoxDecoration(
              color: Colors.redAccent,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(10),
            child: const Icon(Icons.mic, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }
}
