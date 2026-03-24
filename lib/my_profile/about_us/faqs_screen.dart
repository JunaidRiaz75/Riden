import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:riden/theme/app_colors.dart'; // For RidenDarkBackground

class FAQsScreen extends StatefulWidget {
  const FAQsScreen({super.key});

  @override
  State<FAQsScreen> createState() => _FAQsScreenState();
}

class _FAQsScreenState extends State<FAQsScreen> {
  final List<Map<String, String>> faqs = List.generate(
    5,
    (index) => {
      'question': 'Q : Lorem Ipsum is simply dummy text',
      'answer':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. '
          'Lorem Ipsum has been the industry\'s standard <span style="color:#EA4242">dummy text</span> ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.'
    },
  );

  int? expandedIdx;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const RidenDarkBackground(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
                        onPressed: () => Get.back(),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "FAQ'S",
                          style: GoogleFonts.audiowide(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  ...List.generate(faqs.length, (idx) {
                    final isOpen = expandedIdx == idx;
                    return GlassyFAQTile(
                      question: faqs[idx]['question']!,
                      answer: faqs[idx]['answer']!,
                      isOpen: isOpen,
                      onTap: () {
                        setState(() => expandedIdx = isOpen ? null : idx);
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GlassyFAQTile extends StatelessWidget {
  final String question;
  final String answer;
  final bool isOpen;
  final VoidCallback onTap;

  const GlassyFAQTile({
    required this.question,
    required this.answer,
    required this.isOpen,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // RichText to highlight "dummy text" in answer
    InlineSpan answerSpan = TextSpan(
      style: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 14.1,
        fontWeight: FontWeight.w400,
      ),
      children: [
        TextSpan(
          text:
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard ',
        ),
        TextSpan(
            text: 'dummy text',
            style: GoogleFonts.poppins(
              color: const Color(0xFFEA4242),
              fontWeight: FontWeight.w600,
            )),
        TextSpan(
            text:
                ' ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.'),
      ],
    );

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(isOpen ? 0.20 : 0.13),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isOpen ? Colors.red : Colors.white.withOpacity(0.22),
          width: 1.3,
        ),
      ),
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      question,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15.6,
                      ),
                    ),
                  ),
                  Icon(
                    isOpen
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                ],
              ),
            ),
          ),
          if (isOpen)
            Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 14),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.14),
                borderRadius: BorderRadius.circular(11),
              ),
              child: RichText(text: answerSpan),
            ),
        ],
      ),
    );
  }
}