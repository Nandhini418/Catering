import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:catering/constants/app_colors.dart';
import 'package:catering/agent_sections/agent_boys_accepted_screen.dart';

class AgentFindingTeamScreen extends StatefulWidget {
  final String venue;
  final String area;
  final String dateTime;
  final int boysCount;
  final int shifts;
  final int totalAmount;

  const AgentFindingTeamScreen({
    super.key,
    this.venue = 'Annai Mahal',
    this.area = 'Peelamedu, Coimbatore',
    this.dateTime = 'Sat, 11 Oct · 6:00 AM',
    this.boysCount = 10,
    this.shifts = 1,
    this.totalAmount = 4000,
  });

  @override
  State<AgentFindingTeamScreen> createState() => _AgentFindingTeamScreenState();
}

class _AgentFindingTeamScreenState extends State<AgentFindingTeamScreen> {
  bool _searchWidened = false;

  void _widenSearch() {
    setState(() {
      _searchWidened = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Alert sent to 18 additional boys in 10 to 20 km radius!',
          style: GoogleFonts.inter(),
        ),
        backgroundColor: AppColors.primary,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _viewAcceptedBoys() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AgentBoysAcceptedScreen(
          venue: widget.venue,
          boysCount: widget.boysCount,
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
                    'Real-time shift acceptance status and radius alerts.',
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
                      'Finding your team',
                      style: GoogleFonts.inter(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0F2D24),
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Venue details card
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(18.r),
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
                            children: [
                              Text(
                                widget.venue.split(',').first.trim(),
                                style: GoogleFonts.inter(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F2D24),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 3.h,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFEF3C7),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: Text(
                                  'Searching',
                                  style: GoogleFonts.inter(
                                    fontSize: 11.5.sp,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFFB45309),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            widget.area,
                            style: GoogleFonts.inter(
                              fontSize: 13.5.sp,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            widget.dateTime,
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0F2D24),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            '${widget.boysCount} boys · ${widget.shifts} shift ₹${widget.totalAmount}',
                            style: GoogleFonts.inter(
                              fontSize: 13.5.sp,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Boys Ready Card
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(18.r),
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
                                'Boys ready',
                                style: GoogleFonts.inter(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F2D24),
                                ),
                              ),
                              Text(
                                '6 of ${widget.boysCount}',
                                style: GoogleFonts.inter(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F766E),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),

                          // Progress bar
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4.r),
                            child: LinearProgressIndicator(
                              value: 0.6,
                              minHeight: 6.h,
                              backgroundColor: const Color(0xFFE2E8F0),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Color(0xFF0E6347),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),

                          Text(
                            '6 accepted · ${widget.boysCount - 6} more places to fill',
                            style: GoogleFonts.inter(
                              fontSize: 13.5.sp,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Alert Radius Card
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(18.r),
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
                          Text(
                            'Alert radius',
                            style: GoogleFonts.inter(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F2D24),
                            ),
                          ),
                          SizedBox(height: 14.h),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Below 10 km',
                                style: GoogleFonts.inter(
                                  fontSize: 14.sp,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                              Text(
                                '24 alerted',
                                style: GoogleFonts.inter(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF0F2D24),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '10 to 20 km',
                                style: GoogleFonts.inter(
                                  fontSize: 14.sp,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                              Text(
                                _searchWidened ? '18 alerted' : 'Not sent',
                                style: GoogleFonts.inter(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: _searchWidened
                                      ? const Color(0xFF0F766E)
                                      : const Color(0xFF94A3B8),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),

                          // Button: Widen search to 10 to 20 km
                          GestureDetector(
                            onTap: _widenSearch,
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 13.h),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: const Color(0xFFCBD5E1),
                                  width: 1.0,
                                ),
                              ),
                              child: Text(
                                _searchWidened
                                    ? 'Search radius widened'
                                    : 'Widen search to 10 to 20 km',
                                style: GoogleFonts.inter(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF0A6C58),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Helper footer note
                    Center(
                      child: Text(
                        "We'll notify you as boys accept your request.",
                        style: GoogleFonts.inter(
                          fontSize: 13.5.sp,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),

            // Bottom Pinned: View accepted boys
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
                  onPressed: _viewAcceptedBoys,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'View accepted boys',
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
