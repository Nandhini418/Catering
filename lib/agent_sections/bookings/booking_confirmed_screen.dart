import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:catering/constants/app_colors.dart';
import 'package:catering/agent_sections/bookings/team_attendance_screen.dart';
import 'package:catering/agent_sections/bookings/cancel_booking_screen.dart';
import 'package:catering/agent_sections/bookings/boy_cancelled_screen.dart';
import 'package:catering/agent_sections/payments/pay_shift_screen.dart';

class BookingConfirmedScreen extends StatelessWidget {
  final String venue;
  final String location;
  final String dateTime;
  final int boysCount;
  final int shifts;
  final int totalAmount;

  const BookingConfirmedScreen({
    super.key,
    this.venue = 'Annai Mahal',
    this.location = 'Peelamedu, Coimbatore',
    this.dateTime = 'Sat, 11 Oct · 6:00 AM',
    this.boysCount = 10,
    this.shifts = 1,
    this.totalAmount = 4000,
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
                    'Your shift booking is confirmed and assigned to staff.',
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

                    // AGENT Tag
                    Text(
                      'AGENT',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                        letterSpacing: 0.8,
                      ),
                    ),
                    SizedBox(height: 8.h),

                    // Title
                    Text(
                      'Booking confirmed',
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
                                  'Confirmed',
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
                            location,
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
                            '$boysCount boys · $shifts ${shifts == 1 ? 'shift' : 'shifts'} ₹$totalAmount',
                            style: GoogleFonts.inter(
                              fontSize: 13.5.sp,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                          SizedBox(height: 18.h),

                          // Boys Ready Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Boys ready',
                                    style: GoogleFonts.inter(
                                      fontSize: 13.5.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF0F2D24),
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    '$boysCount of $boysCount',
                                    style: GoogleFonts.inter(
                                      fontSize: 13.5.sp,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF0E6347),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),

                          // Full Green Progress Bar
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4.r),
                            child: LinearProgressIndicator(
                              value: 1.0,
                              minHeight: 6.h,
                              backgroundColor: const Color(0xFFE2E8F0),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Color(0xFF0E6347),
                              ),
                            ),
                          ),
                          SizedBox(height: 14.h),

                          // Your team · View boys
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Your team',
                                style: GoogleFonts.inter(
                                  fontSize: 13.5.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF0F2D24),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const TeamAttendanceScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'View boys',
                                  style: GoogleFonts.inter(
                                    fontSize: 13.5.sp,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF0F766E),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          const Divider(color: Color(0xFFF1F5F9), height: 1),
                          SizedBox(height: 16.h),

                          // Uniform & requirements info
                          Text(
                            'White shirt, black pant',
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F2D24),
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            'Food provided · no transport',
                            style: GoogleFonts.inter(
                              fontSize: 13.5.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Report to the kitchen gate. Wear clean footwear. Ask for Murugan at the entrance.',
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              color: const Color(0xFF64748B),
                              height: 1.4,
                            ),
                          ),
                          SizedBox(height: 18.h),

                          // Open venue directions button
                          SizedBox(
                            width: double.infinity,
                            height: 44.h,
                            child: OutlinedButton.icon(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Opening directions to $venue ($location)...',
                                      style: GoogleFonts.inter(),
                                    ),
                                    backgroundColor: AppColors.primary,
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.near_me_outlined,
                                size: 18.r,
                                color: const Color(0xFF0F2D24),
                              ),
                              label: Text(
                                'Open venue directions',
                                style: GoogleFonts.inter(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF0F2D24),
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: Color(0xFFCBD5E1),
                                  width: 1.2,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Staff privacy protected card
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
                            'Staff privacy protected',
                            style: GoogleFonts.inter(
                              fontSize: 14.5.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF166534),
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            'Only photo, profile, rating and area are shown to you. Phone numbers and IDs stay hidden.',
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              color: const Color(0xFF15803D),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 14.h),

                    // Quick test banners
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const BoyCancelledScreen(),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.notifications_active_outlined,
                            size: 15.r,
                            color: const Color(0xFFB45309),
                          ),
                          label: Text(
                            'Boy cancelled',
                            style: GoogleFonts.inter(
                              fontSize: 12.5.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFB45309),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        TextButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PayShiftScreen(
                                  venue: '$venue, $location',
                                  totalAmount: totalAmount,
                                  boys: boysCount,
                                  shifts: shifts,
                                ),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.payment,
                            size: 15.r,
                            color: const Color(0xFF0E6347),
                          ),
                          label: Text(
                            'Pay for shift',
                            style: GoogleFonts.inter(
                              fontSize: 12.5.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0E6347),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),

            // Bottom Actions: View attendance & Cancel booking
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
                            builder: (context) => const TeamAttendanceScreen(),
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
                        'View attendance',
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
                          builder: (context) => const CancelBookingScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Cancel booking',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
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
}
