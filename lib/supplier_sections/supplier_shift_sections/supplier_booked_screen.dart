import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:catering/constants/app_colors.dart';
import 'package:catering/supplier_sections/supplier_shift_sections/supplier_go_to_event_screen.dart';
import 'package:catering/supplier_sections/supplier_shift_sections/supplier_cancel_job_screen.dart';

class SupplierBookedScreen extends StatelessWidget {
  final String venue;
  final String area;
  final String dateTime;
  final int payout;
  final String agentName;

  const SupplierBookedScreen({
    super.key,
    this.venue = 'Annai Mahal',
    this.area = 'Peelamedu, Coimbatore',
    this.dateTime = 'Sat, 11 Oct · 6:00 AM',
    this.payout = 300,
    this.agentName = 'Sri Murugan Caterers',
  });

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
                    'Your shift is confirmed. Follow the dress code and report on time.',
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
                    SizedBox(height: 24.h),

                    // SUPPLIER Tag
                    Text(
                      'SUPPLIER',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFB45309),
                        letterSpacing: 0.8,
                      ),
                    ),
                    SizedBox(height: 8.h),

                    // Title
                    Text(
                      "You're booked",
                      style: GoogleFonts.inter(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0F2D24),
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Booking Details Card
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20.r),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: const Color(0xFFE2E8F0),
                          width: 1.2,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                venue,
                                style: GoogleFonts.inter(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F2D24),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE8F5E9),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: Text(
                                  'Accepted',
                                  style: GoogleFonts.inter(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF2E7D32),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            area,
                            style: GoogleFonts.inter(
                              fontSize: 13.5.sp,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                          SizedBox(height: 14.h),
                          Text(
                            dateTime,
                            style: GoogleFonts.inter(
                              fontSize: 14.5.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0F2D24),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Serving boy · 1 shift ₹$payout',
                            style: GoogleFonts.inter(
                              fontSize: 13.5.sp,
                              color: const Color(0xFFB45309),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Agent Card
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(
                          color: const Color(0xFFE2E8F0),
                          width: 1.2,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Agent',
                            style: GoogleFonts.inter(
                              fontSize: 12.5.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            agentName,
                            style: GoogleFonts.inter(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F2D24),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Before you arrive Guidelines Card
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(18.r),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(
                          color: const Color(0xFFE2E8F0),
                          width: 1.2,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Before you arrive',
                            style: GoogleFonts.inter(
                              fontSize: 14.5.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F2D24),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          _buildGuidelineRow('White shirt, black pant', null),
                          SizedBox(height: 8.h),
                          _buildGuidelineRow('Food provided', 'Yes'),
                          SizedBox(height: 8.h),
                          _buildGuidelineRow('Transport provided', 'No'),
                          SizedBox(height: 12.h),
                          Text(
                            'Report to the kitchen gate. Wear clean footwear. Ask for Murugan at the entrance.',
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              color: const Color(0xFF64748B),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Your shift is reserved Notice (soft mint/green)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0FDF4),
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(
                          color: const Color(0xFFDCFCE7),
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your shift is reserved',
                            style: GoogleFonts.inter(
                              fontSize: 14.5.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF166534),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Report at 6:00 AM. Arrival can only be marked within 200 m.',
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              color: const Color(0xFF15803D),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),

            // Bottom Buttons
            Container(
              padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 20.h),
              decoration: const BoxDecoration(
                color: AppColors.white,
                border: Border(
                  top: BorderSide(color: Color(0xFFF1F5F9), width: 1),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SupplierGoToEventScreen(
                              venue: venue,
                              area: area,
                              dateTime: dateTime,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'Start journey',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SupplierCancelJobScreen(
                            venue: venue,
                            area: area,
                            dateTime: dateTime,
                            payout: payout,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Cancel this job',
                      style: GoogleFonts.inter(
                        fontSize: 14.5.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuidelineRow(String title, String? value) {
    if (value == null) {
      return Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF0F2D24),
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 13.5.sp,
            color: const Color(0xFF64748B),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 13.5.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F2D24),
          ),
        ),
      ],
    );
  }
}
