import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riden/theme/app_colors.dart';
import 'package:image_picker/image_picker.dart';

class SubmitComplaintTicketScreen extends StatefulWidget {
  const SubmitComplaintTicketScreen({Key? key}) : super(key: key);

  @override
  State<SubmitComplaintTicketScreen> createState() => _SubmitComplaintTicketScreenState();
}

class _SubmitComplaintTicketScreenState extends State<SubmitComplaintTicketScreen> {
  final TextEditingController bookingIdController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String? selectedType;
  final List<String> types = ["Type 1", "Type 2", "Type 3", "other"];
  XFile? pickedImage;

  Future<void> _showTypeDropdown(BuildContext context) async {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset offset = box.localToGlobal(Offset.zero);
    final String? result = await showDialog<String>(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) {
        return Stack(
          children: [
            Positioned(
              left: offset.dx,
              top: offset.dy + 52, // adjust based on input height
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: box.size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 9,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Top red item
                      InkWell(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                        onTap: () => Navigator.pop(context, types[0]),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            types[0],
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.5,
                            ),
                          ),
                        ),
                      ),
                      ...List.generate(types.length - 1, (i) {
                        return InkWell(
                          borderRadius: (i == types.length - 2)
                              ? const BorderRadius.vertical(bottom: Radius.circular(12))
                              : BorderRadius.zero,
                          onTap: () => Navigator.pop(context, types[i + 1]),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: (i == types.length - 2)
                                  ? const BorderRadius.vertical(bottom: Radius.circular(12))
                                  : BorderRadius.zero,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              types[i + 1],
                              style: GoogleFonts.poppins(
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
    if (result != null) setState(() => selectedType = result);
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null && await file.length() <= 5 * 1024 * 1024) { // max 5MB
      setState(() => pickedImage = file);
    } else if (file != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("File too large. Max 5MB"))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            const RidenDarkBackground(),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 22),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Submit Complaint Ticket",
                          style: GoogleFonts.audiowide(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18.7,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    // Complaint Type dropdown
                    Text("Complaint Type",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        )),
                    const SizedBox(height: 7),
                    GestureDetector(
                      onTap: () => _showTypeDropdown(context),
                      child: Container(
                        key: const ValueKey('dropdownField'),
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.13),
                          borderRadius: BorderRadius.circular(9),
                          border: Border.all(color: Colors.white24, width: 1.2),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              selectedType ?? "Select Complaint Type",
                              style: GoogleFonts.poppins(
                                color: selectedType == null ? Colors.white70 : Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.3,
                              ),
                            ),
                            const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white70, size: 21),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    // Booking ID
                    Text("Booking ID",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        )),
                    const SizedBox(height: 7),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.13),
                        borderRadius: BorderRadius.circular(9),
                        border: Border.all(color: Colors.white24, width: 1.2),
                      ),
                      child: TextField(
                        controller: bookingIdController,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          hintText: "Enter  Booking ID",
                          hintStyle: GoogleFonts.poppins(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14.3,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    // Complaint Description
                    Text("Complaint Description",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        )),
                    const SizedBox(height: 7),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.13),
                        borderRadius: BorderRadius.circular(9),
                        border: Border.all(color: Colors.white24, width: 1.2),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: TextField(
                        controller: descriptionController,
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
                    const SizedBox(height: 22),
                    // Upload section
                    Text("Attach File",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        )),
                    const SizedBox(height: 7),
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        height: 56,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(13),
                          border: Border.all(
                            color: Colors.white24,
                            width: 1.1,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Center(
                          child: pickedImage == null
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.cloud_upload_outlined, color: Colors.white70, size: 19),
                                    const SizedBox(height: 3),
                                    Text(
                                      "Upload",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13.2,
                                      ),
                                    )
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.insert_drive_file, color: Colors.white, size: 18),
                                    const SizedBox(width: 7),
                                    Flexible(
                                      child: Text(
                                        pickedImage!.name,
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 13.5,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "File must be less than 5MB and in JPEG or PNG",
                      style: GoogleFonts.poppins(
                        color: Colors.white60,
                        fontSize: 11.5,
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Submit button
                    GlassyActionButton(
                      icon: Icons.check_circle_rounded,
                      label: "Submit",
                      glassColor: Colors.red,
                      textColor: Colors.white,
                      onTap: () {
                        // Submit logic!
                        // Show dialog or navigate if needed
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
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(13),
      child: InkWell(
        borderRadius: BorderRadius.circular(13),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 13),
          decoration: BoxDecoration(
            color: glassColor,
            borderRadius: BorderRadius.circular(13),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: textColor, size: 19),
              const SizedBox(width: 7),
              Text(label, style: GoogleFonts.poppins(
                color: textColor,
                fontWeight: FontWeight.w600,
                fontSize: 15.3,
              )),
            ],
          ),
        ),
      ),
    );
  }
}