import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../theme/app_colors.dart'; // Make sure to import the color and painter!
import 'package:riden/bookings/booking_ride_detail.dart' hide RidenDarkBackground, RidenColors; // contains RidenDarkBackground

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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
      'text': 'Welcome to Car2go Customer Service',
      'time': '8:29 pm',
    },
    {
      'type': 'sent',
      'text': 'Welcome to Car2go Customer Service',
      'time': '8:29 pm',
    },
    {
      'type': 'received',
      'avatar': 'assets/images/avatar.png',
      'text': 'Welcome to Car2go Customer Service',
      'time': '8:28 pm',
    },
    {
      'type': 'sent',
      'text': 'Welcome to Car2go Customer Service',
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
    return Scaffold(
      body: Stack(
        children: [
          // Use the painter-based gradient matching BookingDetailsScreen!
          const RidenDarkBackground(),
          SafeArea(
            child: Column(
              children: [
                // Top bar
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, top: 8, bottom: 6),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios,
                            color: Colors.white, size: 20),
                        onPressed: () => Get.back(),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        "Chat",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 2),
                // Chat messages
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 4),
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
                                // Avatar for received message
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: CircleAvatar(
                                    radius: 17,
                                    backgroundImage: AssetImage(msg['avatar']),
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
                                  left: 38, top: 2, right: 2),
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
                          )
                        ],
                      );
                    },
                  ),
                ),
                GlassInputArea(
                  controller: _controller,
                  onSend: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
        margin:
            isSent ? const EdgeInsets.only(left: 20) : const EdgeInsets.only(right: 20),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isSent
              ? Colors.transparent
              : Colors.white.withOpacity(0.09),
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
          style: GoogleFonts.poppins(
            color: isSent ? Colors.white : Colors.white,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}

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
      margin:
          const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.13),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.18), width: 1.2),
      ),
      child: Row(
        children: [
          const Icon(Icons.emoji_emotions_outlined,
              color: Colors.white70, size: 21),
          const SizedBox(width: 6),
          Expanded(
            child: TextField(
              controller: controller,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 15.5,
              ),
              decoration: InputDecoration(
                hintText: "Type your message",
                hintStyle: GoogleFonts.poppins(
                  color: Colors.white60,
                  fontSize: 14.7,
                ),
                border: InputBorder.none,
                isDense: true,
              ),
              onSubmitted: (_) => onSend(),
            ),
          ),
          const SizedBox(width: 8),
          // Send
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
              child: const Icon(Icons.send_rounded,
                  color: Colors.white, size: 22),
            ),
          ),
          const SizedBox(width: 8),
          // Voice
          Container(
            decoration: BoxDecoration(
              color: Colors.redAccent,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(10),
            child: const Icon(Icons.mic, color: Colors.white, size: 21),
          ),
        ],
      ),
    );
  }
}