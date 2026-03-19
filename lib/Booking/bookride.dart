import 'package:flutter/material.dart';
import 'package:riden/Booking/bookingdetail.dart';
import 'package:riden/Booking/ridecomplete.dart' hide RidenColors, RidenDarkBackground;
import 'package:riden/config/mapbox_config.dart'; // Import config

class BookARideScreen extends StatefulWidget {
  const BookARideScreen({super.key});

  @override
  State<BookARideScreen> createState() => _BookARideScreenState();
}

class _BookARideScreenState extends State<BookARideScreen> {
  int _selectedNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RidenColors.backgroundBase,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Use RidenDarkBackground for gradient effect
          const RidenDarkBackground(),

          // Content Overlay
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),

                  // Driver Card
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1.5,
                        ),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          // Driver Avatar
                          Container(
                            width: 60,
                            height: 60,
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
                          SizedBox(width: 16),
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
                                SizedBox(height: 4),
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
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Calling driver...'),
                                      backgroundColor: RidenColors.brandRed,
                                      duration: Duration(milliseconds: 500),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
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
                                    size: 18,
                                  ),
                                ),
                              ),
                              SizedBox(width: 15),
                              // Message Button
                              GestureDetector(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Opening messages...'),
                                      backgroundColor: RidenColors.brandRed,
                                      duration: Duration(milliseconds: 500),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
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
                                    size: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Stats Card
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1.5,
                        ),
                      ),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildStatItem('DISTANCE', '0.2 km'),
                              Container(
                                width: 1,
                                height: 40,
                                color: Colors.white.withOpacity(0.1),
                              ),
                              _buildStatItem('TIME', '2 min'),
                              Container(
                                width: 1,
                                height: 40,
                                color: Colors.white.withOpacity(0.1),
                              ),
                              _buildStatItem('FARE', '\$25.00'),
                            ],
                          ),
                          SizedBox(height: 16),
                          Divider(
                            color: Colors.white.withOpacity(0.1),
                            height: 1,
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Black Suzuki Alto, (BKG-220)',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: RidenColors.textPrimary,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          RideCompletedScreen(),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16,
                                    color: RidenColors.textSecondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.12),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(
              icon: Icons.calendar_today,
              label: 'Bookings',
              index: 0,
            ),
            _buildNavItem(icon: Icons.people, label: 'Support', index: 1),
            _buildNavItem(
              icon: Icons.notifications,
              label: 'Notifications',
              index: 2,
            ),
            _buildNavItem(icon: Icons.person, label: 'Account', index: 3),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: RidenColors.textSecondary,
            letterSpacing: 1,
          ),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: RidenColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    bool isSelected = _selectedNavIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedNavIndex = index;
        });

        String navLabel = '';
        switch (index) {
          case 0:
            navLabel = 'Bookings';
            break;
          case 1:
            navLabel = 'Support';
            break;
          case 2:
            navLabel = 'Notifications';
            break;
          case 3:
            navLabel = 'Account';
            break;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(navLabel),
            duration: Duration(milliseconds: 400),
            backgroundColor: RidenColors.brandRed,
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected
                ? RidenColors.brandRed
                : RidenColors.textSecondary,
            size: 22,
          ),
          SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: isSelected
                  ? RidenColors.brandRed
                  : RidenColors.textSecondary,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}