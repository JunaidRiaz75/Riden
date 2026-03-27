// ignore_for_file: unnecessary_import, deprecated_member_use, unused_field

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riden/theme/app_colors.dart';
import 'dart:ui';

class EditProfileBottomSheet extends StatefulWidget {
  final ScrollController scrollController;
  const EditProfileBottomSheet({required this.scrollController, super.key});

  @override
  State<EditProfileBottomSheet> createState() => _EditProfileBottomSheetState();
}

class _EditProfileBottomSheetState extends State<EditProfileBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'Jesse Showalter');
  final _emailController = TextEditingController(text: 'example@gmail.com');
  final _phoneController = TextEditingController(text: '4563728937');

  String _gender = 'Male';
  String _selectedCountry = '+1';
  String _selectedFlag = '🇨🇦';

  final List<Map<String, String>> _countryList = [
    {'code': '+1', 'flag': '🇨🇦'},
    {'code': '+91', 'flag': '🇮🇳'},
    {'code': '+44', 'flag': '🇬🇧'},
    {'code': '+61', 'flag': '🇦🇺'},
    {'code': '+92', 'flag': '🇵🇰'},
  ];

  void _showNameEditDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.13), // subtle overlay
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 80),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 350,
              minWidth: 10,
              minHeight: 260,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Stack(
                children: [
                  // Gradient card background
                  const Positioned.fill(
                    child:
                        RidenDarkBackground(), // <<-- Use your gradient widget
                  ),
                  // Card content
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 24,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Name Edit Request",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "If you want to change your name, \nyou will need to send an edit request to support.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: Colors.white.withOpacity(0.88),
                          ),
                        ),
                        const SizedBox(height: 28),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              // Send request logic here
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: RidenColors.brandRed,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              "Send Request",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: Colors.white24,
                                width: 1.2,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              backgroundColor: Colors.transparent,
                            ),
                            child: Text(
                              "Cancel",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _glassTextField({
    required String label,
    required TextEditingController controller,
    Widget? prefix,
    Widget? suffix,
    TextInputType inputType = TextInputType.text,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.13),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: Colors.white30, width: 1.2),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        readOnly: readOnly,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.poppins(color: Colors.white60, fontSize: 13),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 17,
          ),
          prefixIcon: prefix,
          suffixIcon: suffix,
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _glassyCountryPhoneField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.13),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: Colors.white30, width: 1.2),
      ),
      child: Row(
        children: [
          // Country/flag dropdown
          Container(
            padding: const EdgeInsets.only(left: 10),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedCountry,
                items: _countryList.map((e) {
                  return DropdownMenuItem(
                    value: e['code'],
                    child: Row(
                      children: [
                        Text(e['flag']!, style: const TextStyle(fontSize: 18)),
                        const SizedBox(width: 6),
                        Text(
                          e['code']!,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                dropdownColor: Colors.black87,
                style: GoogleFonts.poppins(color: Colors.white),
                icon: const Icon(
                  Icons.expand_more,
                  color: Colors.white54,
                  size: 20,
                ),
                onChanged: (v) {
                  setState(() {
                    final found = _countryList.firstWhere(
                      (element) => element['code'] == v,
                    );
                    _selectedCountry = found['code']!;
                    _selectedFlag = found['flag']!;
                  });
                },
              ),
            ),
          ),
          // Divider
          Container(
            width: 1,
            height: 32,
            color: Colors.white24,
            margin: const EdgeInsets.symmetric(horizontal: 7),
          ),
          // Phone text field
          Expanded(
            child: TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                labelText: "Phone Number",
                labelStyle: GoogleFonts.poppins(
                  color: Colors.white60,
                  fontSize: 13,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 17),
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(28),
        topRight: Radius.circular(28),
      ),
      child: Stack(
        children: [
          // ---- Dark gradient as always
          const Positioned.fill(child: RidenDarkBackground()),
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
              // Back and Title
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      'Profile Settings',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 21,
                      ),
                    ),
                  ],
                ),
              ),
              // Profile Pic
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: RidenColors.brandRed,
                            width: 3,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(45),
                          child: Image.network(
                            'https://i.pravatar.cc/150?img=33',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 2,
                        right: 2,
                        child: Container(
                          width: 33,
                          height: 33,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: RidenColors.brandRed,
                            border: Border.all(color: Colors.white, width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: RidenColors.brandRed.withOpacity(0.28),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Sheet Contents
              Expanded(
                child: SingleChildScrollView(
                  controller: widget.scrollController,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(22, 0, 22, 24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Name (readonly + glass + edit)
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.13),
                              borderRadius: BorderRadius.circular(13),
                              border: Border.all(
                                color: Colors.white30,
                                width: 1.2,
                              ),
                            ),
                            child: TextFormField(
                              controller: _nameController,
                              readOnly: true,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: InputDecoration(
                                labelText: "Full Name",
                                labelStyle: GoogleFonts.poppins(
                                  color: Colors.white60,
                                  fontSize: 13,
                                ),
                                border: InputBorder.none,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.edit_note_rounded,
                                    color: RidenColors.brandRed,
                                    size: 21,
                                  ),
                                  onPressed: () => _showNameEditDialog(context),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 16,
                                ),
                              ),
                              onTap: () => _showNameEditDialog(context),
                            ),
                          ),
                          // Email
                          _glassTextField(
                            label: "Email",
                            controller: _emailController,
                            inputType: TextInputType.emailAddress,
                          ),
                          // Phone: glassy with country code picker
                          _glassyCountryPhoneField(),
                          // Gender
                          Container(
                            margin: const EdgeInsets.only(bottom: 27),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.13),
                              borderRadius: BorderRadius.circular(13),
                              border: Border.all(
                                color: Colors.white30,
                                width: 1.2,
                              ),
                            ),
                            child: DropdownButtonFormField<String>(
                              value: _gender,
                              decoration: InputDecoration(
                                labelText: "Gender",
                                labelStyle: GoogleFonts.poppins(
                                  color: Colors.white60,
                                  fontSize: 13,
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 15,
                                ),
                              ),
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                              dropdownColor: Colors.black87,
                              icon: const Icon(
                                Icons.expand_more,
                                color: Colors.white54,
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: 'Male',
                                  child: Text('Male'),
                                ),
                                DropdownMenuItem(
                                  value: 'Female',
                                  child: Text('Female'),
                                ),
                                DropdownMenuItem(
                                  value: 'Other',
                                  child: Text('Other'),
                                ),
                              ],
                              onChanged: (v) => setState(() => _gender = v!),
                            ),
                          ),
                          // Update Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                // Save info, call API, etc.
                                // Show confirmation dialog if you want
                                _showNameEditDialog(context); // For demo!
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: RidenColors.brandRed,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 17,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                              ),
                              child: Text(
                                "Update",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
