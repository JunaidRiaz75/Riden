import 'package:flutter/material.dart';
import 'package:riden/theme/riden_theme.dart';
// Import your config file for Mapbox token
import 'package:riden/config/mapbox_config.dart'; // We'll create this

class RideCompletedScreen extends StatefulWidget {
  const RideCompletedScreen({super.key});

  @override
  State<RideCompletedScreen> createState() => _RideCompletedScreenState();
}

class _RideCompletedScreenState extends State<RideCompletedScreen> {
  bool _isTipHovered = false;
  bool _isRateHovered = false;
  int _selectedTip = 1; // 0=15%, 1=20%, 2=25%, 3=custom
  int _selectedRating = 0; // 0-5 stars
  final TextEditingController _reviewController = TextEditingController();
  final TextEditingController _customTipController = TextEditingController();

  @override
  void dispose() {
    _reviewController.dispose();
    _customTipController.dispose();
    super.dispose();
  }

  void _showTipDialog() {
    _selectedTip = 1; // Reset to 20%
    _customTipController.clear();
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF1a1a1a),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.white.withOpacity(0.15),
                width: 1.5,
              ),
            ),
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Tip Your Driver',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 24),
                // Tip Options
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTipOption(
                      setDialogState,
                      label: '15%',
                      index: 0,
                      isSelected: _selectedTip == 0,
                    ),
                    _buildTipOption(
                      setDialogState,
                      label: '20%',
                      index: 1,
                      isSelected: _selectedTip == 1,
                    ),
                    _buildTipOption(
                      setDialogState,
                      label: '25%',
                      index: 2,
                      isSelected: _selectedTip == 2,
                    ),
                    _buildTipOption(
                      setDialogState,
                      label: 'Custom',
                      index: 3,
                      isSelected: _selectedTip == 3,
                    ),
                  ],
                ),
                SizedBox(height: 24),
                // Confirm Button
                StatefulBuilder(
                  builder: (buttonContext, setButtonState) {
                    bool isConfirmPressed = false;
                    return GestureDetector(
                      onTapDown: (_) {
                        setButtonState(() {
                          isConfirmPressed = true;
                        });
                      },
                      onTapUp: (_) {
                        setButtonState(() {
                          isConfirmPressed = false;
                        });
                        Navigator.of(dialogContext).pop();
                      },
                      onTapCancel: () {
                        setButtonState(() {
                          isConfirmPressed = false;
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 150),
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: isConfirmPressed
                              ? RidenColors.brandRed.withOpacity(0.85)
                              : RidenColors.brandRed,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'Confirm',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 12),
                // Skip Button
                StatefulBuilder(
                  builder: (buttonContext, setButtonState) {
                    bool isSkipPressed = false;
                    return GestureDetector(
                      onTapDown: (_) {
                        setButtonState(() {
                          isSkipPressed = true;
                        });
                      },
                      onTapUp: (_) {
                        setButtonState(() {
                          isSkipPressed = false;
                        });
                        Navigator.of(dialogContext).pop();
                      },
                      onTapCancel: () {
                        setButtonState(() {
                          isSkipPressed = false;
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 150),
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: isSkipPressed
                              ? Colors.grey.shade800
                              : Colors.transparent,
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
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTipOption(
    StateSetter setDialogState, {
    required String label,
    required int index,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        setDialogState(() {
          _selectedTip = index;
        });
      },
      child: Container(
        width: 70,
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: isSelected
                ? RidenColors.brandRed
                : Colors.white.withOpacity(0.3),
            width: isSelected ? 2 : 1.5,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected
                  ? RidenColors.brandRed
                  : Colors.white.withOpacity(0.7),
            ),
          ),
        ),
      ),
    );
  }

  void _showRatingDialog() {
    _selectedRating = 0;
    _reviewController.clear();
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF1a1a1a),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.white.withOpacity(0.15),
                width: 1.5,
              ),
            ),
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Close Button
                Align(
                  alignment: Alignment.topRight,
                  child: StatefulBuilder(
                    builder: (buttonContext, setButtonState) {
                      bool isClosePressed = false;
                      return GestureDetector(
                        onTapDown: (_) {
                          setButtonState(() {
                            isClosePressed = true;
                          });
                        },
                        onTapUp: (_) {
                          setButtonState(() {
                            isClosePressed = false;
                          });
                          Navigator.of(dialogContext).pop();
                        },
                        onTapCancel: () {
                          setButtonState(() {
                            isClosePressed = false;
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 150),
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isClosePressed
                                ? Colors.grey.shade700
                                : Colors.grey.shade800,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 12),
                // Star Rating
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return GestureDetector(
                      onTap: () {
                        setDialogState(() {
                          _selectedRating = index + 1;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Icon(
                          Icons.star_rounded,
                          size: 36,
                          color: index < _selectedRating
                              ? RidenColors.brandRed
                              : Colors.white.withOpacity(0.3),
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 20),
                // Rating Title
                Text(
                  _getRatingTitle(_selectedRating),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                // Rating Subtitle
                Text(
                  'You rated Sergio $_selectedRating star${_selectedRating != 1 ? 's' : ''}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
                SizedBox(height: 20),
                // Review Text Field
                TextField(
                  controller: _reviewController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Write your text',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.white.withOpacity(0.2),
                        width: 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.white.withOpacity(0.2),
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: RidenColors.brandRed,
                        width: 2,
                      ),
                    ),
                    contentPadding: EdgeInsets.all(16),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20),
                // Submit Button
                StatefulBuilder(
                  builder: (buttonContext, setButtonState) {
                    bool isSubmitPressed = false;
                    return GestureDetector(
                      onTapDown: (_) {
                        setButtonState(() {
                          isSubmitPressed = true;
                        });
                      },
                      onTapUp: (_) {
                        setButtonState(() {
                          isSubmitPressed = false;
                        });
                        Navigator.of(dialogContext).pop();
                      },
                      onTapCancel: () {
                        setButtonState(() {
                          isSubmitPressed = false;
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 150),
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: isSubmitPressed
                              ? RidenColors.brandRed.withOpacity(0.85)
                              : RidenColors.brandRed,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'Submit',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getRatingTitle(int rating) {
    switch (rating) {
      case 1:
        return 'Poor';
      case 2:
        return 'Good';
      case 3:
        return 'Very Good';
      case 4:
        return 'Excellent';
      case 5:
        return 'Excellent';
      default:
        return 'Rate';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RidenColors.backgroundBase,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ✅ Use RidenDarkBackground from your theme file
          const RidenDarkBackground(),

          // Content
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with Back Button
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_back_ios,
                                color: RidenColors.textPrimary,
                                size: 20,
                              ),
                              SizedBox(width: 8),
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
                        Text(
                          'Sun, 23 May 2025',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: RidenColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16),

                  // Map Section - Using Mapbox token from config
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1.5,
                        ),
                        color: Colors.grey.shade800,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: _buildMapWithToken(),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Booking ID
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
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
                  ),

                  SizedBox(height: 20),

                  // Route Details
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Origin
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Office',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: RidenColors.textPrimary,
                                        ),
                                      ),
                                      Text(
                                        '04:30pm',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: RidenColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '2972 Westheimer Rd. Santa Ana, Illinois 85486',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: RidenColors.textSecondary,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 12),

                        // Dashed Line
                        Container(
                          width: 2,
                          height: 30,
                          margin: EdgeInsets.only(left: 5),
                          child: CustomPaint(painter: DashedLinePainter()),
                        ),

                        SizedBox(height: 12),

                        // Destination
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: RidenColors.brandRed,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.navigation,
                                  size: 8,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Coffee shop',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: RidenColors.textPrimary,
                                        ),
                                      ),
                                      Text(
                                        '06:30pm',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: RidenColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '1901 Thornridge Cir. Shiloh, Hawaii 81063',
                                    style: TextStyle(
                                      fontSize: 12,
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

                  SizedBox(height: 20),

                  // Duration and Distance Stats
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Colors.white.withOpacity(0.1),
                            width: 1,
                          ),
                          bottom: BorderSide(
                            color: Colors.white.withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: RidenColors.brandRed.withOpacity(0.2),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.schedule,
                                    color: RidenColors.brandRed,
                                    size: 16,
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Duration',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: RidenColors.textSecondary,
                                    ),
                                  ),
                                  Text(
                                    '34 mins',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: RidenColors.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: RidenColors.brandRed.withOpacity(0.2),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.location_on,
                                    color: RidenColors.brandRed,
                                    size: 16,
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Distance',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: RidenColors.textSecondary,
                                    ),
                                  ),
                                  Text(
                                    '5.2km',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: RidenColors.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Driver Info
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
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
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sergio',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: RidenColors.textPrimary,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Black Suzuki Alto, (BKG-220)',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: RidenColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24),

                  // Tip your Driver Button
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                      onTapDown: (_) {
                        setState(() {
                          _isTipHovered = true;
                        });
                      },
                      onTapUp: (_) {
                        setState(() {
                          _isTipHovered = false;
                        });
                      },
                      onTapCancel: () {
                        setState(() {
                          _isTipHovered = false;
                        });
                      },
                      onTap: () {
                        _showTipDialog();
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 150),
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: _isTipHovered
                              ? RidenColors.brandRed.withOpacity(0.85)
                              : RidenColors.brandRed,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: RidenColors.brandRed.withOpacity(
                                _isTipHovered ? 0.6 : 0.4,
                              ),
                              blurRadius: _isTipHovered ? 20 : 15,
                              offset: Offset(0, _isTipHovered ? 10 : 8),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Tip your Driver',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 12),

                  // Rate your Driver Button
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                      onTapDown: (_) {
                        setState(() {
                          _isRateHovered = true;
                        });
                      },
                      onTapUp: (_) {
                        setState(() {
                          _isRateHovered = false;
                        });
                      },
                      onTapCancel: () {
                        setState(() {
                          _isRateHovered = false;
                        });
                      },
                      onTap: () {
                        _showRatingDialog();
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 150),
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: _isRateHovered
                              ? RidenColors.brandRed.withOpacity(0.15)
                              : Colors.transparent,
                          border: Border.all(
                            color: _isRateHovered
                                ? RidenColors.brandRed.withOpacity(0.8)
                                : RidenColors.brandRed,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'Rate your Driver',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: _isRateHovered
                                  ? RidenColors.brandRed.withOpacity(0.9)
                                  : RidenColors.brandRed,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Method to build map with token
  Widget _buildMapWithToken() {
    // Get token from config
    final mapboxToken = MapboxConfig.accessToken;
    
    // If token is not set, show placeholder
    if (mapboxToken.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.map,
              color: Colors.white.withOpacity(0.3),
              size: 48,
            ),
            SizedBox(height: 8),
            Text(
              'Map view',
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    }

    // Here you would initialize your Mapbox map with the token
    // Example: return MapboxMap(accessToken: mapboxToken, ...);
    
    // For now, return a placeholder with token verification
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.map,
            color: Colors.white.withOpacity(0.3),
            size: 48,
          ),
          SizedBox(height: 8),
          Text(
            'Map ready (token loaded)',
            style: TextStyle(
              color: Colors.green.withOpacity(0.7),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

// Dashed Line Painter
class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..strokeWidth = 1.5;

    var y = 0.0;
    final dashHeight = 4;
    final spaceHeight = 4;

    while (y < size.height) {
      canvas.drawLine(Offset(0, y), Offset(0, y + dashHeight), paint);
      y += dashHeight + spaceHeight;
    }
  }

  @override
  bool shouldRepaint(DashedLinePainter oldDelegate) => false;
}