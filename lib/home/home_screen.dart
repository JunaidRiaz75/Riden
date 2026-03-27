// home_screen.dart - Updated with Ride Bottom Sheet
import 'package:flutter/material.dart';
import 'package:riden/bookings/bookingride_loading.dart';
import 'package:riden/bookings/bookride.dart';
import 'package:riden/call_and_chat/chat_screen.dart';
import 'package:riden/home/your_locations_screen.dart'; // Add this import
import 'package:riden/my_profile/profilesheet.dart';
import 'package:riden/widgets/bottom_navbar.dart';

import '../theme/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    const accentRed = Color(0xFFFF2B2B);
    final bottomNavHeight = 70.0;
    final bottomNavBottomMargin = 16.0;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ✅ FULL SCREEN MAP BACKGROUND
          Positioned.fill(
            child: Image.asset(
              'assets/images/map1.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
            ),
          ),

          // ✅ RIGHT SIDE MAP CONTROLS
          Positioned(
            right: 16,
            bottom: bottomNavHeight + bottomNavBottomMargin + 20,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Centering on current location...'),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.95),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.location_searching,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Getting current location...'),
                        backgroundColor: Colors.blue,
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.95),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.my_location,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ✅ DRAGGABLE SLIDER SHEET (Your Locations)
          Positioned(
            left: 0,
            right: 0,
            bottom: bottomNavHeight + bottomNavBottomMargin,
            child: DraggableScrollableSheet(
              initialChildSize: 0.15,
              minChildSize: 0.12,
              maxChildSize: 0.65,
              snap: true,
              snapSizes: const [0.15, 0.35, 0.65],
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
                        child: YourLocationsScreen(
                          scrollController: scrollController,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),

      // ✅ BOTTOM NAVIGATION BAR
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: bottomNavBottomMargin),
        child: GlassyBottomNavBar(
          currentIndex: _selectedNavIndex,
          onChanged: (int value) {
            setState(() {
              _selectedNavIndex = value;
            });

            // Handle navigation based on selected tab
            if (value == 0) {
              // Ride tab - Open Ride Bottom Sheet
              _openRideBottomSheet(context);
            } else if (value == 1) {
              // Bookings tab - Open Bookings Bottom Sheet
              _openBookingBottomSheet(context);
            } else if (value == 2) {
              // Support tab - Open Chat Bottom Sheet
              _openChatBottomSheet(context);
            } else if (value == 3) {
              // Account tab - Open Profile Bottom Sheet
              _openProfileBottomSheet(context);
            }
          },
        ),
      ),
    );
  }

  void _openRideBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          snap: true,
          snapSizes: const [0.5, 0.85, 0.95],
          builder: (context, scrollController) {
            return BookRideBottomSheet(scrollController: scrollController);
          },
        );
      },
    );
  }

  void _openBookingBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          snap: true,
          snapSizes: const [0.5, 0.85, 0.95],
          builder: (context, scrollController) {
            return BookingBottomSheet(scrollController: scrollController);
          },
        );
      },
    );
  }

  void _openChatBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          snap: true,
          snapSizes: const [0.5, 0.85, 0.95],
          builder: (context, scrollController) {
            return ChatBottomSheet(scrollController: scrollController);
          },
        );
      },
    );
  }

  void _openProfileBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          snap: true,
          snapSizes: const [0.5, 0.85, 0.95],
          builder: (context, scrollController) {
            return ProfileBottomSheet(scrollController: scrollController);
          },
        );
      },
    );
  }
}
