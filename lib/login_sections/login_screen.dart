import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:catering/constants/app_colors.dart';
import 'package:catering/login_sections/otp_screen.dart';
import 'package:catering/login_sections/register_screen.dart';
import 'package:catering/login_sections/terms_conditions_screen.dart';

class LoginScreen extends StatefulWidget {
  final String? initialPhone;

  const LoginScreen({super.key, this.initialPhone});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController(text: widget.initialPhone ?? '');
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _handleSendOtp() {
    final phone = _phoneController.text.trim();
    if (phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter your mobile number',
            style: GoogleFonts.inter(),
          ),
        ),
      );
      return;
    }

    if (phone.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter a valid 10-digit mobile number',
            style: GoogleFonts.inter(),
          ),
        ),
      );
      return;
    }

    // Directly navigate to OTP Screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OtpScreen(phoneNumber: phone),
      ),
    );
  }

  void _navigateToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterScreen()),
    );
  }

  void _navigateToTerms() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TermsConditionsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Set status bar to transparent with dark icons for light background
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 45.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 38.h),

                        // Title: Welcome Back
                        Text(
                          'Welcome Back',
                          style: GoogleFonts.inter(
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textDark,
                          ),
                        ),
                        SizedBox(height: 8.h),

                        // Subtitle: Enter your mobile number to continue
                        Text(
                          'Enter your mobile number to continue',
                          style: GoogleFonts.inter(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textMuted,
                          ),
                        ),
                        SizedBox(height: 32.h),

                        // Mobile Input Row (Country Code Box + Mobile Input)
                        Row(
                          children: [
                            // Country Code: IN +91
                            Container(
                              width: 95.w,
                              height: 52.h,
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.border),
                                borderRadius: BorderRadius.circular(10.r),
                                color: AppColors.white,
                              ),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'IN ',
                                    style: GoogleFonts.inter(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textMuted,
                                    ),
                                  ),
                                  Text(
                                    '+91',
                                    style: GoogleFonts.inter(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textDark,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 12.w),

                            // Phone Number Text Field
                            Expanded(
                              child: Container(
                                height: 52.h,
                                alignment: Alignment.center,
                                child: TextField(
                                  controller: _phoneController,
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(10),
                                  ],
                                  style: GoogleFonts.inter(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textDark,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Mobile number',
                                    hintStyle: GoogleFonts.inter(
                                      color: AppColors.textHint,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                      vertical: 14.h,
                                    ),
                                    filled: true,
                                    fillColor: AppColors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: const BorderSide(
                                        color: AppColors.border,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: const BorderSide(
                                        color: AppColors.border,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      borderSide: const BorderSide(
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 38.h),

                        // Send OTP Button
                        SizedBox(
                          width: double.infinity,
                          height: 50.h,
                          child: ElevatedButton(
                            onPressed: _handleSendOtp,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            child: Text(
                              'Send OTP',
                              style: GoogleFonts.inter(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),

                        // Spacer to push the Register option & Terms down to the end of the screen
                        const Spacer(),

                        // Register Option for New Users
                        Center(
                          child: GestureDetector(
                            onTap: _navigateToRegister,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 18.w,
                                vertical: 12.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: RichText(
                                text: TextSpan(
                                  style: GoogleFonts.inter(
                                    fontSize: 13.5.sp,
                                    color: AppColors.textDark,
                                  ),
                                  children: [
                                    const TextSpan(text: "New here? "),
                                    TextSpan(
                                      text: 'Register as New User',
                                      style: GoogleFonts.inter(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 18.h),

                        // Terms of Service & Privacy Policy at the bottom
                        Center(
                          child: GestureDetector(
                            onTap: _navigateToTerms,
                            child: Text.rich(
                              TextSpan(
                                text: 'By continuing, you agree to our ',
                                style: GoogleFonts.inter(
                                  fontSize: 12.5.sp,
                                  color: AppColors.textMuted,
                                  height: 1.5,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Terms of Service',
                                    style: GoogleFonts.inter(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const TextSpan(text: '\nand '),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: GoogleFonts.inter(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
