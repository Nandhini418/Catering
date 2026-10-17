import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:catering/constants/app_colors.dart';
import 'package:catering/login_sections/cater_connect_selection_screen.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpScreen({
    super.key,
    this.phoneNumber = '9876547891',
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    6,
    (_) => FocusNode(),
  );

  int _resendCountdown = 30;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer?.cancel();
    _resendCountdown = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCountdown > 0) {
        setState(() => _resendCountdown--);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _maskedPhone {
    final clean = widget.phoneNumber.replaceAll(RegExp(r'\D'), '');
    if (clean.length >= 4) {
      final last4 = clean.substring(clean.length - 4);
      return '+91 ••••••$last4';
    }
    return '+91 ••••••7891';
  }

  void _handleVerify() {
    final otp = _controllers.map((c) => c.text).join();
    if (otp.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter the complete 6-digit OTP',
            style: GoogleFonts.inter(),
          ),
        ),
      );
      return;
    }

    // Navigate to CaterConnect Selection Screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CaterConnectSelectionScreen(),
      ),
    );
  }

  void _handleResend() {
    _startCountdown();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'OTP has been resent to $_maskedPhone',
          style: GoogleFonts.inter(),
        ),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),

              // Circular Back Button
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 44.r,
                  height: 44.r,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF2F6FA),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: AppColors.textDark,
                    size: 20,
                  ),
                ),
              ),
              SizedBox(height: 28.h),

              // Title: OTP Verification
              Text(
                'OTP Verification',
                style: GoogleFonts.inter(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                  letterSpacing: -0.3,
                ),
              ),
              SizedBox(height: 8.h),

              // Subtitle with masked phone
              Text(
                '6-digit code sent to $_maskedPhone',
                style: GoogleFonts.inter(
                  fontSize: 14.5.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textMuted,
                ),
              ),
              SizedBox(height: 32.h),

              // 6-digit OTP input boxes row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) => _buildOtpBox(index)),
              ),
              SizedBox(height: 38.h),

              // Verify & Continue Button
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: _handleVerify,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Verify & Continue',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 28.h),

              // Resend Timer Row
              Center(
                child: _resendCountdown > 0
                    ? RichText(
                        text: TextSpan(
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            color: AppColors.textMuted,
                          ),
                          children: [
                            const TextSpan(text: 'Resend in '),
                            TextSpan(
                              text:
                                  '0:${_resendCountdown.toString().padLeft(2, '0')}',
                              style: GoogleFonts.inter(
                                color: const Color(0xFFDC2626),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )
                    : GestureDetector(
                        onTap: _handleResend,
                        child: Text(
                          'Resend OTP',
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtpBox(int index) {
    return Container(
      width: 50.w,
      height: 58.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: _focusNodes[index].hasFocus
              ? AppColors.primary
              : const Color(0xFFCBD5E1),
          width: 1.0,
        ),
      ),
      child: Center(
        child: TextField(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 1,
          style: GoogleFonts.inter(
            fontSize: 20.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textDark,
          ),
          decoration: const InputDecoration(
            counterText: '',
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          onChanged: (val) {
            if (val.isNotEmpty) {
              if (index < 5) {
                _focusNodes[index + 1].requestFocus();
              } else {
                _focusNodes[index].unfocus();
              }
            } else {
              if (index > 0) {
                _focusNodes[index - 1].requestFocus();
              }
            }
            setState(() {});
          },
        ),
      ),
    );
  }
}
