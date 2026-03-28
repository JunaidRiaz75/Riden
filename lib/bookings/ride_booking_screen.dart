import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'rideconfirm.dart'; // adjust path

class CarSelectionScreen extends StatefulWidget {
  final ScrollController scrollController;
  final bool showDragHandle;

  const CarSelectionScreen({
    super.key,
    required this.scrollController,
    this.showDragHandle = true,
  });

  @override
  State<CarSelectionScreen> createState() => _CarSelectionScreenState();
}

class _CarSelectionScreenState extends State<CarSelectionScreen> {
  int _selectedIndex = 0;
  String selectedCar = '';

  Map<String, String> carPrices = {
    'Standard': r'C$ 70.00',
    'SUV': r'C$ 85.00',
    'Van': r'C$ 95.00',
    'Premium': r'C$ 110.00',
    'SUV Premium': r'C$ 125.00',
    'Wheelchair': r'C$ 80.00',
  };

  void _onRequest() {
    if (selectedCar.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a car')));
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RideconfirmScreen(selectedCar: selectedCar),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const RidenDarkBackground(),
          SafeArea(
            child: Column(
              children: [
                // Drag handle (only if requested)
                if (widget.showDragHandle)
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
                Expanded(
                  child: SingleChildScrollView(
                    controller: widget.scrollController,
                    physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 80),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildRouteCard(),
                          const SizedBox(height: 20),
                          _buildCategoryHeader(
                            'Standard Cars',
                            Icons.directions_car,
                          ),
                          const SizedBox(height: 12),
                          _buildCarCard(
                            'Standard',
                            '3-4 min',
                            r'C$ 70.00',
                            'Sedan with AC',
                            onSelect: () =>
                                setState(() => selectedCar = 'Standard'),
                            isSelected: selectedCar == 'Standard',
                          ),
                          const SizedBox(height: 10),
                          _buildCarCard(
                            'SUV',
                            '3-4 min',
                            r'C$ 85.00',
                            'SUV with AC',
                            onSelect: () => setState(() => selectedCar = 'SUV'),
                            isSelected: selectedCar == 'SUV',
                          ),
                          const SizedBox(height: 10),
                          _buildCarCard(
                            'Van',
                            '3-4 min',
                            r'C$ 95.00',
                            'Van with AC',
                            onSelect: () => setState(() => selectedCar = 'Van'),
                            isSelected: selectedCar == 'Van',
                          ),
                          const SizedBox(height: 20),
                          _buildPremiumSection(),
                          const SizedBox(height: 20),
                          _buildCategoryHeader(
                            'Handicap Cars',
                            Icons.accessible,
                          ),
                          const SizedBox(height: 12),
                          _buildCarCard(
                            'Wheelchair',
                            '3-4 min',
                            r'C$ 80.00',
                            'Wheelchair accessible',
                            onSelect: () =>
                                setState(() => selectedCar = 'Wheelchair'),
                            isSelected: selectedCar == 'Wheelchair',
                          ),
                          const SizedBox(height: 24),
                          _buildRequestButton(),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ),
                // Bottom Navigation Bar
                _HomeBottomNav(
                  selectedIndex: _selectedIndex,
                  onChanged: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------- UI Components (dark glass style, matching chat) ----------
  Widget _buildRouteCard() {
    const accentRed = Color(0xFFFF2B2B);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.58),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.2),
                ),
                child: const Center(
                  child: Icon(Icons.person, color: Colors.white70, size: 18),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pickup',
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '2972 Westheimer Rd. Santa Ana, Illinois 85486',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Divider(color: Colors.white.withOpacity(0.2), height: 1),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: accentRed,
                ),
                child: const Center(
                  child: Icon(Icons.location_on, color: Colors.white, size: 16),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Destination',
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '1901 Thorndige Cir. Shiloh, Hawai 81603',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.45),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Stops',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryHeader(String title, IconData icon) {
    const accentRed = Color(0xFFFF2B2B);
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: accentRed,
          ),
          child: Center(child: Icon(icon, color: Colors.white, size: 20)),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildCarCard(
    String carName,
    String time,
    String price,
    String description, {
    required VoidCallback onSelect,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.58),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? Colors.redAccent
                : Colors.white.withOpacity(0.2),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white.withOpacity(0.2),
              ),
              child: const Center(
                child: Icon(
                  Icons.directions_car,
                  color: Colors.black87,
                  size: 32,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    carName,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.schedule, color: Colors.black, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        time,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              price,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumSection() {
    const accentRed = Color(0xFFFF2B2B);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: accentRed, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCategoryHeader('Premium Cars', Icons.directions_car),
          const SizedBox(height: 12),
          _buildCarCard(
            'Premium',
            '3-4 min',
            r'C$ 110.00',
            'Premium Sedan with AC',
            onSelect: () => setState(() => selectedCar = 'Premium'),
            isSelected: selectedCar == 'Premium',
          ),
          const SizedBox(height: 10),
          _buildCarCard(
            'SUV Premium',
            '3-4 min',
            r'C$ 125.00',
            'Premium SUV with AC',
            onSelect: () => setState(() => selectedCar = 'SUV Premium'),
            isSelected: selectedCar == 'SUV Premium',
          ),
        ],
      ),
    );
  }

  Widget _buildRequestButton() {
    const accentRed = Color(0xFFFF2B2B);
    return GestureDetector(
      onTap: _onRequest,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFF2B2B), Color(0xFFFF4B4B)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: accentRed.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            'Request',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}

// ---------- Bottom Navigation Bar ----------
class _HomeBottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const _HomeBottomNav({required this.selectedIndex, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 14),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.58),
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: Colors.white.withOpacity(0.7),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 12,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _NItem(
                    0,
                    Icons.directions_car_rounded,
                    'Ride',
                    selectedIndex,
                    onChanged,
                  ),
                  _NItem(
                    1,
                    Icons.support_agent_rounded,
                    'Support',
                    selectedIndex,
                    onChanged,
                  ),
                  _NItem(
                    2,
                    Icons.receipt_long_rounded,
                    'Bookings',
                    selectedIndex,
                    onChanged,
                  ),
                  _NItem(
                    3,
                    Icons.person_outline_rounded,
                    'Account',
                    selectedIndex,
                    onChanged,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NItem extends StatelessWidget {
  final int index;
  final IconData icon;
  final String label;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const _NItem(
    this.index,
    this.icon,
    this.label,
    this.selectedIndex,
    this.onChanged,
  );

  @override
  Widget build(BuildContext context) {
    final bool active = selectedIndex == index;
    final Color iconColor = active
        ? const Color(0xFFE53935)
        : const Color(0xFF2C3E50);
    final Color labelColor = active
        ? const Color(0xFFE53935)
        : const Color(0xFF2C3E50);

    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(index),
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: iconColor, size: 24),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: labelColor,
                  fontSize: 11,
                  fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------- Dark Background ----------
class RidenDarkBackground extends StatelessWidget {
  const RidenDarkBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
        ),
      ),
    );
  }
}
