import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:catering/constants/app_colors.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'CaterConnect',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Terms & conditions protect both catering agents and suppliers.',
                    style: GoogleFonts.inter(),
                  ),
                  backgroundColor: AppColors.primary,
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 28.h),

                    // Top Label: ACCOUNT
                    Text(
                      'ACCOUNT',
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF287E67),
                        letterSpacing: 0.8,
                      ),
                    ),
                    SizedBox(height: 8.h),

                    // Heading: Terms & conditions
                    Text(
                      'Terms & conditions',
                      style: GoogleFonts.inter(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                        letterSpacing: -0.4,
                      ),
                    ),
                    SizedBox(height: 10.h),

                    // Subtitle: Clear expectations for every shift.
                    Text(
                      'Clear expectations for every shift.',
                      style: GoogleFonts.inter(
                        fontSize: 14.5.sp,
                        color: AppColors.textMuted,
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Card 1: Rates & payment
                    _buildConditionCard(
                      title: 'Rates & payment',
                      description:
                          'Shift rates are set by the admin. Agent payment is due within 1 hour after completion. Suppliers receive ₹300 per shift automatically.',
                    ),
                    SizedBox(height: 16.h),

                    // Card 2: Cancellation policy
                    _buildConditionCard(
                      title: 'Cancellation policy',
                      description:
                          'Supplier cancellation within 2 hours: 1 warning. At 3 warnings, admin may block the account. Agent cancellation within 2 hours: 50% of the booking amount is charged.',
                    ),
                    SizedBox(height: 16.h),

                    // Card 3: Your privacy
                    _buildConditionCard(
                      title: 'Your privacy',
                      description:
                          'Agents see staff profiles after acceptance. Staff phone numbers and IDs remain hidden from agents. Admin alone can review IDs, contacts and home locations.',
                    ),
                    SizedBox(height: 16.h),

                    // Bottom Note
                    Text(
                      'Reviews appear on profiles only after both sides submit.',
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        color: AppColors.textMuted,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),

            // Pinned Bottom Button: Agree and continue
            Container(
              padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 20.h),
              decoration: const BoxDecoration(
                color: AppColors.white,
                border: Border(
                  top: BorderSide(color: Color(0xFFF1F5F9), width: 1),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Agree and continue',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
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

  Widget _buildConditionCard({
    required String title,
    required String description,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            description,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: const Color(0xFF475569),
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}
