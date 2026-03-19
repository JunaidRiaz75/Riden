import 'package:flutter/material.dart';
import 'package:riden/theme/riden_theme.dart';

// ✅ MAIN APP SETTINGS SCREEN
class AppSettingsScreen extends StatefulWidget {
  const AppSettingsScreen({super.key});

  @override
  State<AppSettingsScreen> createState() => _AppSettingsScreenState();
}

class _AppSettingsScreenState extends State<AppSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RidenColors.backgroundBase,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ✅ Dark glassy background
          const RidenDarkBackground(),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back Button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: GestureDetector(
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
                ),

                SizedBox(height: 8),

                // Title
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'App Settings',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: RidenColors.textPrimary,
                    ),
                  ),
                ),

                SizedBox(height: 24),

                // Menu Items
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          // Change Password
                          _buildMenuItemWithArrow(
                            icon: Icons.lock,
                            label: 'Change Password',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChangePasswordScreen(),
                                ),
                              );
                            },
                          ),

                          SizedBox(height: 12),

                          // Share App
                          _buildMenuItemWithArrow(
                            icon: Icons.share,
                            label: 'Share App',
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Share App feature'),
                                  backgroundColor: RidenColors.brandRed,
                                  duration: Duration(milliseconds: 800),
                                ),
                              );
                            },
                          ),

                          SizedBox(height: 12),

                          // Rate the app
                          _buildMenuItemWithArrow(
                            icon: Icons.star,
                            label: 'Rate the app',
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Rate App feature'),
                                  backgroundColor: RidenColors.brandRed,
                                  duration: Duration(milliseconds: 800),
                                ),
                              );
                            },
                          ),

                          SizedBox(height: 12),

                          // Logout
                          _buildMenuItemWithArrow(
                            icon: Icons.logout,
                            label: 'Logout',
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Logging out...'),
                                  backgroundColor: RidenColors.brandRed,
                                  duration: Duration(milliseconds: 800),
                                ),
                              );
                            },
                          ),

                          SizedBox(height: 40),
                        ],
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

  Widget _buildMenuItemWithArrow({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.12), width: 1.5),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            // Icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: RidenColors.brandRed.withOpacity(0.15),
              ),
              child: Center(
                child: Icon(icon, color: RidenColors.brandRed, size: 20),
              ),
            ),

            SizedBox(width: 14),

            // Label
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: RidenColors.textPrimary,
                ),
              ),
            ),

            // Arrow
            Icon(
              Icons.arrow_forward_ios,
              color: RidenColors.textSecondary,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}

// ✅ CHANGE PASSWORD SCREEN
class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late TextEditingController _phoneController;
  bool _isSendOtpPressed = false;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RidenColors.backgroundBase,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ✅ Dark glassy background
          const RidenDarkBackground(),

          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back Button
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: GestureDetector(
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
                  ),

                  SizedBox(height: 24),

                  // Title
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Change Password',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: RidenColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Enter your Phone Number to change Your Password',
                          style: TextStyle(
                            fontSize: 14,
                            color: RidenColors.textSecondary,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 32),

                  // Phone Input
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Phone Number',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: RidenColors.textSecondary,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.15),
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              // Country Code
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 14,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      '🇨🇦',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                      '+1',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: RidenColors.textPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Divider
                              Container(
                                width: 1,
                                height: 24,
                                color: Colors.white.withOpacity(0.1),
                              ),

                              // Phone Input
                              Expanded(
                                child: TextField(
                                  controller: _phoneController,
                                  keyboardType: TextInputType.phone,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: RidenColors.textPrimary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: '00000000',
                                    hintStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.4),
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 14,
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

                  SizedBox(height: 28),

                  // Send OTP Button
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                      onTapDown: (_) {
                        setState(() {
                          _isSendOtpPressed = true;
                        });
                      },
                      onTapUp: (_) {
                        setState(() {
                          _isSendOtpPressed = false;
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VerificationScreen(),
                          ),
                        );
                      },
                      onTapCancel: () {
                        setState(() {
                          _isSendOtpPressed = false;
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 150),
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: _isSendOtpPressed
                              ? RidenColors.brandRed.withOpacity(0.85)
                              : RidenColors.brandRed,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: RidenColors.brandRed.withOpacity(
                                _isSendOtpPressed ? 0.6 : 0.4,
                              ),
                              blurRadius: _isSendOtpPressed ? 20 : 15,
                              offset: Offset(0, _isSendOtpPressed ? 10 : 8),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Send OTP',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 0.5,
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
}

// ✅ VERIFICATION SCREEN (OTP)
class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  late List<TextEditingController> _otpControllers;
  bool _isVerifyPressed = false;

  @override
  void initState() {
    super.initState();
    _otpControllers = List.generate(5, (index) => TextEditingController());
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _handleNumberInput(int number) {
    for (int i = 0; i < _otpControllers.length; i++) {
      if (_otpControllers[i].text.isEmpty) {
        setState(() {
          _otpControllers[i].text = number.toString();
        });
        break;
      }
    }
  }

  void _handleBackspace() {
    for (int i = _otpControllers.length - 1; i >= 0; i--) {
      if (_otpControllers[i].text.isNotEmpty) {
        setState(() {
          _otpControllers[i].text = '';
        });
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RidenColors.backgroundBase,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ✅ Dark glassy background
          const RidenDarkBackground(),

          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back Button
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: GestureDetector(
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
                  ),

                  SizedBox(height: 24),

                  // Title
                  Center(
                    child: Text(
                      'Verification',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: RidenColors.textPrimary,
                      ),
                    ),
                  ),

                  SizedBox(height: 12),

                  // Description
                  Center(
                    child: Text(
                      'Code has been send to ****  ****70',
                      style: TextStyle(
                        fontSize: 14,
                        color: RidenColors.textSecondary,
                      ),
                    ),
                  ),

                  SizedBox(height: 32),

                  // OTP Input Fields
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _otpControllers[index].text.isNotEmpty
                                    ? RidenColors.brandRed
                                    : Colors.white.withOpacity(0.15),
                                width: _otpControllers[index].text.isNotEmpty
                                    ? 2
                                    : 1.5,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                _otpControllers[index].text,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: RidenColors.textPrimary,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),

                  SizedBox(height: 24),

                  // Resend Code
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Didn't receive code? ",
                        style: TextStyle(
                          fontSize: 13,
                          color: RidenColors.textSecondary,
                        ),
                        children: [
                          TextSpan(
                            text: 'Resend again',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: RidenColors.brandRed,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 28),

                  // Verify Button
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                      onTapDown: (_) {
                        setState(() {
                          _isVerifyPressed = true;
                        });
                      },
                      onTapUp: (_) {
                        setState(() {
                          _isVerifyPressed = false;
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SetNewPasswordScreen(),
                          ),
                        );
                      },
                      onTapCancel: () {
                        setState(() {
                          _isVerifyPressed = false;
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 150),
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: _isVerifyPressed
                              ? RidenColors.brandRed.withOpacity(0.85)
                              : RidenColors.brandRed,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: RidenColors.brandRed.withOpacity(
                                _isVerifyPressed ? 0.6 : 0.4,
                              ),
                              blurRadius: _isVerifyPressed ? 20 : 15,
                              offset: Offset(0, _isVerifyPressed ? 10 : 8),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Verify',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 40),

                  // Number Pad
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        // Row 1: 1-3
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildNumberButton('1'),
                            _buildNumberButton('2'),
                            _buildNumberButton('3'),
                          ],
                        ),
                        SizedBox(height: 12),

                        // Row 2: 4-6
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildNumberButton('4'),
                            _buildNumberButton('5'),
                            _buildNumberButton('6'),
                          ],
                        ),
                        SizedBox(height: 12),

                        // Row 3: 7-9
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildNumberButton('7'),
                            _buildNumberButton('8'),
                            _buildNumberButton('9'),
                          ],
                        ),
                        SizedBox(height: 12),

                        // Row 4: 0 and Backspace
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width:
                                  (MediaQuery.of(context).size.width - 40) / 3,
                            ),
                            _buildNumberButton('0'),
                            GestureDetector(
                              onTap: _handleBackspace,
                              child: Container(
                                width:
                                    (MediaQuery.of(context).size.width - 40) /
                                        3 -
                                    6,
                                padding: EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.15),
                                    width: 1.5,
                                  ),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.backspace,
                                    color: RidenColors.textSecondary,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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

  Widget _buildNumberButton(String number) {
    return GestureDetector(
      onTap: () {
        _handleNumberInput(int.parse(number));
      },
      child: Container(
        width: (MediaQuery.of(context).size.width - 40) / 3 - 6,
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white.withOpacity(0.15), width: 1.5),
        ),
        child: Center(
          child: Text(
            number,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: RidenColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

// ✅ SET NEW PASSWORD SCREEN
class SetNewPasswordScreen extends StatefulWidget {
  const SetNewPasswordScreen({super.key});

  @override
  State<SetNewPasswordScreen> createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  bool _isSavePressed = false;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RidenColors.backgroundBase,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ✅ Dark glassy background
          const RidenDarkBackground(),

          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back Button
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: GestureDetector(
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
                  ),

                  SizedBox(height: 24),

                  // Title
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Set New Password',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: RidenColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Set your New Password',
                          style: TextStyle(
                            fontSize: 14,
                            color: RidenColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 28),

                  // New Password Field
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: _buildPasswordField(
                      label: 'New Password',
                      controller: _passwordController,
                      obscureText: !_showPassword,
                      onToggle: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                    ),
                  ),

                  SizedBox(height: 20),

                  // Confirm Password Field
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: _buildPasswordField(
                      label: 'Confirm Password',
                      controller: _confirmPasswordController,
                      obscureText: !_showConfirmPassword,
                      onToggle: () {
                        setState(() {
                          _showConfirmPassword = !_showConfirmPassword;
                        });
                      },
                    ),
                  ),

                  SizedBox(height: 28),

                  // Save Button
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                      onTapDown: (_) {
                        setState(() {
                          _isSavePressed = true;
                        });
                      },
                      onTapUp: (_) {
                        setState(() {
                          _isSavePressed = false;
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                VerificationSuccessfulScreen(),
                          ),
                        );
                      },
                      onTapCancel: () {
                        setState(() {
                          _isSavePressed = false;
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 150),
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: _isSavePressed
                              ? RidenColors.brandRed.withOpacity(0.85)
                              : RidenColors.brandRed,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: RidenColors.brandRed.withOpacity(
                                _isSavePressed ? 0.6 : 0.4,
                              ),
                              blurRadius: _isSavePressed ? 20 : 15,
                              offset: Offset(0, _isSavePressed ? 10 : 8),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Save',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 0.5,
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

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool obscureText,
    required VoidCallback onToggle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: RidenColors.textSecondary,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withOpacity(0.15),
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              // Input Field
              Expanded(
                child: TextField(
                  controller: controller,
                  obscureText: obscureText,
                  style: TextStyle(
                    fontSize: 14,
                    color: RidenColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    hintText: '123456789',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                  ),
                ),
              ),

              // Toggle Button
              GestureDetector(
                onTap: onToggle,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                    color: RidenColors.textSecondary,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ✅ VERIFICATION SUCCESSFUL SCREEN
class VerificationSuccessfulScreen extends StatefulWidget {
  const VerificationSuccessfulScreen({super.key});

  @override
  State<VerificationSuccessfulScreen> createState() =>
      _VerificationSuccessfulScreenState();
}

class _VerificationSuccessfulScreenState
    extends State<VerificationSuccessfulScreen> {
  bool _isContinuePressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RidenColors.backgroundBase,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ✅ Dark glassy background
          const RidenDarkBackground(),

          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Top: Empty space
                SizedBox(height: 40),

                // Center: Success Content
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Success Icon/Image
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: RidenColors.brandRed.withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.check_circle_rounded,
                            size: 80,
                            color: RidenColors.brandRed,
                          ),
                        ),
                      ),

                      SizedBox(height: 32),

                      // Congratulations Title
                      Text(
                        'Congratulations!',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: RidenColors.textPrimary,
                        ),
                      ),

                      SizedBox(height: 12),

                      // Description
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          'Your New Password has been updated Successfully',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: RidenColors.textSecondary,
                            height: 1.6,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Bottom: Continue Button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 32),
                  child: GestureDetector(
                    onTapDown: (_) {
                      setState(() {
                        _isContinuePressed = true;
                      });
                    },
                    onTapUp: (_) {
                      setState(() {
                        _isContinuePressed = false;
                      });
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    onTapCancel: () {
                      setState(() {
                        _isContinuePressed = false;
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 150),
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: _isContinuePressed
                            ? RidenColors.brandRed.withOpacity(0.85)
                            : RidenColors.brandRed,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: RidenColors.brandRed.withOpacity(
                              _isContinuePressed ? 0.6 : 0.4,
                            ),
                            blurRadius: _isContinuePressed ? 20 : 15,
                            offset: Offset(0, _isContinuePressed ? 10 : 8),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 0.5,
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
}
