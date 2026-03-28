import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riden/theme/app_colors.dart'; // For RidenDarkBackground

class ReportIssueScreen extends StatefulWidget {
  const ReportIssueScreen({super.key});
  @override
  State<ReportIssueScreen> createState() => _ReportIssueScreenState();
}

class _ReportIssueScreenState extends State<ReportIssueScreen> {
  final List<String> issueTypes = [
    'Driver was rude',
    'Vehicle was not clean',
    'Driver was late',
    'Payment issue',
    'Wrong route taken',
    'Other',
  ];
  int _selectedType = 0;
  final TextEditingController _issueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            // FULLSCREEN: Always covers whole viewport
            const RidenDarkBackground(),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 18,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back arrow + title
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                            size: 21,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Choose Issue Type",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 17.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // Radio buttons (not glassy)
                    Column(
                      children: List.generate(issueTypes.length, (i) {
                        final isSelected = _selectedType == i;
                        return InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () => setState(() => _selectedType = i),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 7),
                            child: Row(
                              children: [
                                CustomRadioCircle(
                                  selected: isSelected,
                                  red: true,
                                ),
                                const SizedBox(width: 13),
                                Expanded(
                                  child: Text(
                                    issueTypes[i],
                                    style: GoogleFonts.poppins(
                                      color: isSelected
                                          ? Colors.red
                                          : Colors.white,
                                      fontSize: 14.3,
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 24),

                    // Glassy description
                    Text(
                      "Explain Issue",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14.3,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.11),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: TextField(
                        controller: _issueController,
                        maxLines: 5,
                        maxLength: 50,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          hintText: "Write...",
                          hintStyle: GoogleFonts.poppins(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14.3,
                          ),
                          border: InputBorder.none,
                          counterStyle: GoogleFonts.poppins(
                            color: Colors.white54,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    GlassyActionButton(
                      icon: Icons.check_circle_rounded,
                      label: "Submit",
                      glassColor: Colors.red,
                      textColor: Colors.white,
                      onTap: () {
                        // Submit logic!
                      },
                    ),
                    const SizedBox(height: 18),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Red radio
class CustomRadioCircle extends StatelessWidget {
  final bool selected;
  final bool red;
  const CustomRadioCircle({required this.selected, this.red = true, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 19,
      height: 19,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: selected ? Colors.red : Colors.white70,
          width: 2.1,
        ),
        color: Colors.transparent,
      ),
      child: selected
          ? Center(
              child: Container(
                width: 8.7,
                height: 8.7,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            )
          : null,
    );
  }
}

class GlassyActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color glassColor;
  final Color textColor;
  final VoidCallback onTap;

  const GlassyActionButton({
    required this.icon,
    required this.label,
    required this.glassColor,
    required this.textColor,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          decoration: BoxDecoration(
            color: glassColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: textColor, size: 18),
              const SizedBox(width: 7),
              Text(
                label,
                style: GoogleFonts.poppins(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
