import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:catering/constants/app_colors.dart';
import 'package:catering/agent_sections/bookings/booking_confirmed_screen.dart';

class AgentBoysAcceptedScreen extends StatefulWidget {
  final String venue;
  final int boysCount;

  const AgentBoysAcceptedScreen({
    super.key,
    this.venue = 'Annai Mahal',
    this.boysCount = 10,
  });

  @override
  State<AgentBoysAcceptedScreen> createState() =>
      _AgentBoysAcceptedScreenState();
}

class _AgentBoysAcceptedScreenState extends State<AgentBoysAcceptedScreen> {
  bool _expandedAll = false;

  final List<Map<String, String>> _initialBoys = [
    {
      'initials': 'KR',
      'name': 'Karthik R',
      'location': 'Peelamedu · 4.2 km away',
    },
    {
      'initials': 'AS',
      'name': 'Arun S',
      'location': 'Saravanampatti · 6.8 km away',
    },
    {
      'initials': 'VM',
      'name': 'Vijay M',
      'location': 'Singanallur · 7.5 km away',
    },
  ];

  final List<Map<String, String>> _extraBoys = [
    {
      'initials': 'SK',
      'name': 'Suresh K',
      'location': 'Gandhipuram · 5.1 km away',
    },
    {
      'initials': 'RP',
      'name': 'Ramesh P',
      'location': 'RS Puram · 8.0 km away',
    },
    {
      'initials': 'MN',
      'name': 'Manoj N',
      'location': 'Saibaba Colony · 6.2 km away',
    },
    {
      'initials': 'DK',
      'name': 'Dinesh K',
      'location': 'Hopes College · 3.5 km away',
    },
    {
      'initials': 'PP',
      'name': 'Praveen P',
      'location': 'Ukkadam · 9.1 km away',
    },
    {
      'initials': 'RA',
      'name': 'Ravi A',
      'location': 'Vadavalli · 11.2 km away',
    },
    {
      'initials': 'SS',
      'name': 'Saravanan S',
      'location': 'Ramanathapuram · 4.8 km away',
    },
  ];

  void _confirmBooking() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Booking confirmed! Shift request sent to team.',
          style: GoogleFonts.inter(),
        ),
        backgroundColor: const Color(0xFF0E6347),
        duration: const Duration(seconds: 2),
      ),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => BookingConfirmedScreen(
          venue: widget.venue,
          location: 'Peelamedu, Coimbatore',
          dateTime: 'Sat, 11 Oct · 6:00 AM',
          boysCount: widget.boysCount,
          shifts: 1,
          totalAmount: widget.boysCount * 400,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );

    final displayBoys =
        _expandedAll ? [..._initialBoys, ..._extraBoys] : _initialBoys;

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
                    'Review staff profiles who accepted your booking request.',
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

                    // Tag
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
                      'Boys who accepted',
                      style: GoogleFonts.inter(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0F2D24),
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(height: 8.h),

                    // Subtitle
                    Text(
                      '${widget.boysCount} of ${widget.boysCount} boys ready for ${widget.venue.split(',').first.trim()}',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // List of boys cards
                    ...displayBoys.map((boy) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 14.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: const Color(0xFFE2E8F0),
                              width: 1.2,
                            ),
                          ),
                          child: Row(
                            children: [
                              // Avatar circle
                              Container(
                                width: 44.r,
                                height: 44.r,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFEF5E7),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xFFFDE68A),
                                    width: 1.0,
                                  ),
                                ),
                                child: Text(
                                  boy['initials']!,
                                  style: GoogleFonts.inter(
                                    fontSize: 14.5.sp,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF9A5B13),
                                  ),
                                ),
                              ),
                              SizedBox(width: 14.w),

                              // Info
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      boy['name']!,
                                      style: GoogleFonts.inter(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF0F2D24),
                                      ),
                                    ),
                                    SizedBox(height: 3.h),
                                    Text(
                                      boy['location']!,
                                      style: GoogleFonts.inter(
                                        fontSize: 13.sp,
                                        color: const Color(0xFF64748B),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Accepted Tag
                              Text(
                                'Accepted',
                                style: GoogleFonts.inter(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFFB45309),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),

                    // "+ 7 more boys accepted" toggle button
                    if (!_expandedAll)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _expandedAll = true;
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(14.r),
                            border: Border.all(
                              color: const Color(0xFFE2E8F0),
                              width: 1.2,
                            ),
                          ),
                          child: Text(
                            '+ 7 more boys accepted',
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0F2D24),
                            ),
                          ),
                        ),
                      ),
                    SizedBox(height: 18.h),

                    // Staff privacy protected card
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(18.r),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF9ED),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Staff privacy protected',
                            style: GoogleFonts.inter(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFB45309),
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            'Only photo, profile, rating and area are shown to you. Phone numbers and IDs stay hidden.',
                            style: GoogleFonts.inter(
                              fontSize: 13.5.sp,
                              color: const Color(0xFF9A5B13),
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

            // Bottom Pinned: Confirm booking
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
                  onPressed: _confirmBooking,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Confirm booking',
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
}
