// add_place_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:riden/call_and_chat/call_screen.dart';
import 'package:riden/call_and_chat/chat_screen.dart';
import 'package:riden/theme/app_colors.dart';

class AddPlaceBottomSheet extends StatelessWidget {
  final ScrollController scrollController;

  const AddPlaceBottomSheet({required this.scrollController, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              RidenColors.backgroundBase.withOpacity(0.98),
              RidenColors.backgroundBase.withOpacity(0.95),
              RidenColors.backgroundBase.withOpacity(0.92),
            ],
            stops: const [0.0, 0.6, 1.0],
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 25,
              offset: const Offset(0, -5),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
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
            // Add Place Content
            Expanded(
              child: AddPlaceContent(scrollController: scrollController),
            ),
          ],
        ),
      ),
    );
  }
}

class AddPlaceContent extends StatefulWidget {
  final ScrollController scrollController;

  const AddPlaceContent({required this.scrollController, super.key});

  @override
  State<AddPlaceContent> createState() => _AddPlaceContentState();
}

class _AddPlaceContentState extends State<AddPlaceContent> {
  final TextEditingController _addressController = TextEditingController(
    text: "1234 Westheimer Rd, Santa Monica, TX",
  );
  final TextEditingController _placeNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const accentRed = Color(0xFFFF2B2B);

    return SingleChildScrollView(
      controller: widget.scrollController,
      physics: const ClampingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
            child: Text(
              "Add a place",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),

          // Description
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            child: Text(
              "Find your place by searching the address or simply drop a pin on the map to mark the exact pickup spot.",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.white.withOpacity(0.72),
              ),
            ),
          ),

          // Place Name Field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _buildGlassyField(
              icon: Icons.title,
              hint: "Place name (e.g., Home, Office)",
              controller: _placeNameController,
            ),
          ),
          const SizedBox(height: 12),

          // Address Search Field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _buildGlassyField(
              icon: Icons.search_rounded,
              hint: "Enter place address",
              controller: _addressController,
              iconColor: accentRed,
            ),
          ),
          const SizedBox(height: 20),

          // Map preview with pin overlay
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/images/map1.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 80,
                  left: 0,
                  right: 0,
                  child: Center(child: _buildPin(accentRed)),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: accentRed,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: accentRed.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      _addressController.text.length > 25
                          ? "${_addressController.text.substring(0, 25)}..."
                          : _addressController.text,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Action Buttons
          Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              0,
              20,
              24 + MediaQuery.of(context).padding.bottom,
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Close the add place sheet and open booking loading sheet
                      Navigator.pop(context);
                      _openBookingLoadingSheet(context);
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF2B2B), Color(0xFFFF4B4B)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFF2B2B).withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          "Confirm Location",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openBookingLoadingSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.12,
          minChildSize: 0.12,
          maxChildSize: 0.85,
          snap: true,
          snapSizes: const [0.12, 0.45, 0.85],
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    RidenColors.backgroundBase.withOpacity(0.98),
                    RidenColors.backgroundBase.withOpacity(0.95),
                    RidenColors.backgroundBase.withOpacity(0.92),
                  ],
                  stops: const [0.0, 0.6, 1.0],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 25,
                    offset: const Offset(0, -5),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
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
                  // Booking Loading Content
                  Expanded(
                    child: BookingLoadingContent(
                      scrollController: scrollController,
                      onLoadingComplete: () {
                        // Close the loading sheet
                        Navigator.pop(context);
                        // Open booking details sheet
                        _openBookingDetailsSheet(context);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _openBookingDetailsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.12,
          minChildSize: 0.12,
          maxChildSize: 0.85,
          snap: true,
          snapSizes: const [0.12, 0.45, 0.85],
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    RidenColors.backgroundBase.withOpacity(0.98),
                    RidenColors.backgroundBase.withOpacity(0.95),
                    RidenColors.backgroundBase.withOpacity(0.92),
                  ],
                  stops: const [0.0, 0.6, 1.0],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 25,
                    offset: const Offset(0, -5),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
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
                  // Booking Details Content
                  Expanded(
                    child: BookingDetailsContent(
                      scrollController: scrollController,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildGlassyField({
    required IconData icon,
    required String hint,
    TextEditingController? controller,
    Color? iconColor,
  }) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.17),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.18)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 15),
          Icon(
            icon,
            color: iconColor ?? Colors.white.withOpacity(0.76),
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.82),
                  fontSize: 15,
                ),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPin(Color accentRed) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: accentRed,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: accentRed.withOpacity(0.35),
                blurRadius: 14,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 3,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.25),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}

// Booking Loading Content with Timer
class BookingLoadingContent extends StatefulWidget {
  final ScrollController scrollController;
  final VoidCallback onLoadingComplete;

  const BookingLoadingContent({
    required this.scrollController,
    required this.onLoadingComplete,
    super.key,
  });

  @override
  State<BookingLoadingContent> createState() => _BookingLoadingContentState();
}

class _BookingLoadingContentState extends State<BookingLoadingContent> {
  @override
  void initState() {
    super.initState();
    // Start 3-second timer
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        widget.onLoadingComplete();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.scrollController,
      physics: const ClampingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
            child: Text(
              'RIDEN',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 1.5,
              ),
            ),
          ),

          const SizedBox(height: 40),

          // Loading Spinner
          SizedBox(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(
              strokeWidth: 8,
              valueColor: AlwaysStoppedAnimation<Color>(RidenColors.brandRed),
              backgroundColor: Colors.white.withOpacity(0.1),
            ),
          ),

          const SizedBox(height: 30),

          // Booking Text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'We are booking ride for you',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: RidenColors.textPrimary,
                height: 1.4,
              ),
            ),
          ),

          const SizedBox(height: 30),

          // Destination Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Destination',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: RidenColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Office Location
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            width: 2,
                            height: 60,
                            color: Colors.grey.withOpacity(0.5),
                            margin: const EdgeInsets.symmetric(vertical: 6),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Office',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: RidenColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '2972 Westheimer Rd. Santa Ana, Illinois 85486',
                              style: TextStyle(
                                fontSize: 13,
                                color: RidenColors.textSecondary,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Coffee Shop Location
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: RidenColors.brandRed,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.navigation,
                                size: 8,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Coffee shop',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: RidenColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '1901 Thornridge Cir. Shiloh, Hawaii 81063',
                              style: TextStyle(
                                fontSize: 13,
                                color: RidenColors.textSecondary,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Ride Details Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ride Details',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: RidenColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Total Distance
                  _buildDetailRow('Total Distance', '234km'),

                  const SizedBox(height: 18),

                  // Sedan
                  _buildDetailRowWithIcon('Sedan', Icons.directions_car),

                  const SizedBox(height: 18),

                  // Payment Method
                  _buildDetailRow('Payment Method', 'Wallet'),

                  const SizedBox(height: 18),

                  // Estimated Fare
                  _buildDetailRow('Estimated Fare', '\$400.00', isFare: true),

                  const SizedBox(height: 18),

                  // Discount
                  _buildDetailRow('Discount', '-\$40.00', isDiscount: true),
                ],
              ),
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    bool isFare = false,
    bool isDiscount = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: RidenColors.textPrimary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isDiscount
                ? const Color(0xFF4ECDC4)
                : RidenColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRowWithIcon(String label, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: RidenColors.textPrimary,
          ),
        ),
        Icon(icon, color: Colors.white, size: 24),
      ],
    );
  }
}

// Updated Booking Details Content Widget with the new design
class BookingDetailsContent extends StatelessWidget {
  final ScrollController scrollController;

  const BookingDetailsContent({required this.scrollController, super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      physics: const ClampingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back Button
          Padding(
            padding: const EdgeInsets.all(20),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    color: RidenColors.textPrimary,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Back',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: RidenColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Title
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'Ride is on Its Way',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: RidenColors.textPrimary,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Driver Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Driver Avatar
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade800,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        'https://i.pravatar.cc/150?img=33',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Driver Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sergio',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: RidenColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 14,
                              color: RidenColors.brandRed,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '(5mins away)',
                              style: TextStyle(
                                fontSize: 13,
                                color: RidenColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '43 Rides (31 reviews)',
                          style: TextStyle(
                            fontSize: 13,
                            color: RidenColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Action Buttons
                  Row(
                    children: [
                      // Call Button
                      GestureDetector(
                        onTap: () {
                          Get.to(() => CallScreen());
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: RidenColors.brandRed,
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            Icons.phone,
                            color: RidenColors.brandRed,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      // Message Button
                      GestureDetector(
                        onTap: () {
                          Get.to(() => ChatScreen());
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: RidenColors.brandRed,
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            Icons.chat,
                            color: RidenColors.brandRed,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Ride Details Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with Booking ID
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Ride Details',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: RidenColors.textPrimary,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: RidenColors.textPrimary,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'Booking ID: 2345',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: RidenColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Car Details
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Black Suzuki Alto, (BKG-220)',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: RidenColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Divider(color: Colors.grey.withOpacity(0.3), height: 1),
                  const SizedBox(height: 16),

                  // Total Distance
                  _buildDetailRow('Total Distance', '435km'),
                  const SizedBox(height: 16),

                  // Payment Method
                  _buildDetailRow('Payment Method', 'wallet'),
                  const SizedBox(height: 16),

                  // Estimated Fare
                  _buildDetailRow('Estimated Fare', '\$450.00'),
                  const SizedBox(height: 16),

                  // Discount
                  _buildDetailRow('Discount', '\$45.00', isDiscount: true),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Destination Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Destination',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: RidenColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Office Location
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            width: 2,
                            height: 60,
                            color: Colors.grey.withOpacity(0.5),
                            margin: const EdgeInsets.symmetric(vertical: 6),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Office',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: RidenColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '2972 Westheimer Rd. Santa Ana, Illinois 85486',
                              style: TextStyle(
                                fontSize: 13,
                                color: RidenColors.textSecondary,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Coffee Shop Location
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: RidenColors.brandRed,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.navigation,
                                size: 8,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Coffee shop',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: RidenColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '1901 Thornridge Cir. Shiloh, Hawaii 81063',
                              style: TextStyle(
                                fontSize: 13,
                                color: RidenColors.textSecondary,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Manage Ride Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Manage Ride',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: RidenColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Share Ride Details Button
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AccessContactsDialog(),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.share,
                            color: RidenColors.textPrimary,
                            size: 20,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            'Share Ride Details',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: RidenColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Need Support Button
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Opening support...')),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.headphones,
                            color: RidenColors.textPrimary,
                            size: 20,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            'Need Support',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: RidenColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Cancel Ride Button
                  GestureDetector(
                    onTap: () {
                      _showCancelRideDialog(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: RidenColors.brandRed,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.close,
                            color: RidenColors.brandRed,
                            size: 20,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            'Cancel Ride',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: RidenColors.brandRed,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    bool isDiscount = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: RidenColors.textPrimary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isDiscount
                ? const Color(0xFF4ECDC4)
                : RidenColors.textPrimary,
          ),
        ),
      ],
    );
  }

  void _showCancelRideDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CancelRideDialog(
        onCancel: () {
          Navigator.pop(context); // Close dialog
          Navigator.pop(context); // Close booking details sheet
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Ride cancelled successfully'),
              backgroundColor: Colors.green,
            ),
          );
        },
      ),
    );
  }
}

// Cancel Ride Dialog Widget
class CancelRideDialog extends StatefulWidget {
  final VoidCallback onCancel;

  const CancelRideDialog({required this.onCancel, super.key});

  @override
  State<CancelRideDialog> createState() => _CancelRideDialogState();
}

class _CancelRideDialogState extends State<CancelRideDialog> {
  String selectedReason = 'I don\'t need a ride anymore';

  final List<String> cancelReasons = [
    'I don\'t need a ride anymore',
    'Driver asked me to cancel',
    'I found another ride',
    'I booked by mistake',
    'other',
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: RidenColors.backgroundBase,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              'Cancel Ride',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: RidenColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Please tell us why you want to cancel',
              style: TextStyle(fontSize: 14, color: RidenColors.textSecondary),
            ),
            const SizedBox(height: 24),

            // Radio Options
            ...List.generate(cancelReasons.length, (index) {
              String reason = cancelReasons[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedReason = reason;
                    });
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: selectedReason == reason
                                ? RidenColors.brandRed
                                : Colors.white.withOpacity(0.5),
                            width: 2,
                          ),
                          color: selectedReason == reason
                              ? RidenColors.brandRed
                              : Colors.transparent,
                        ),
                        child: selectedReason == reason
                            ? Center(
                                child: Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : null,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          reason,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: RidenColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: RidenColors.textPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: widget.onCancel,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: RidenColors.brandRed,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: RidenColors.brandRed.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Confirm',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Access Contacts Dialog
class AccessContactsDialog extends StatelessWidget {
  const AccessContactsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: RidenColors.backgroundBase,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon - Red glowing circle
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: RidenColors.brandRed.withOpacity(0.15),
              ),
              child: Center(
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: RidenColors.brandRed,
                    boxShadow: [
                      BoxShadow(
                        color: RidenColors.brandRed.withOpacity(0.6),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 36,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 28),

            // Title
            Text(
              'Access Contacts',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: RidenColors.textPrimary,
              ),
            ),

            const SizedBox(height: 16),

            // Description
            Text(
              'You want to access your contacts while using this app.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: RidenColors.textSecondary,
                height: 1.6,
              ),
            ),

            const SizedBox(height: 36),

            // Access Contacts Button
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Accessing contacts...'),
                    backgroundColor: RidenColors.brandRed,
                    duration: Duration(milliseconds: 800),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: RidenColors.brandRed,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: RidenColors.brandRed.withOpacity(0.5),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Access Contacts',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Skip for now Button
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Skip for now',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: RidenColors.textSecondary,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
