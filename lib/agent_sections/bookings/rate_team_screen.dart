import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:catering/constants/app_colors.dart';
import 'package:catering/agent_sections/bookings/rate_boy_screen.dart';

class RateTeamScreen extends StatefulWidget {
  final String venue;
  final String subtitle;

  const RateTeamScreen({
    super.key,
    this.venue = 'Annai Mahal',
    this.subtitle = 'Annai Mahal · completed shift',
  });

  @override
  State<RateTeamScreen> createState() => _RateTeamScreenState();
}

class _RateTeamScreenState extends State<RateTeamScreen> {
  bool _showAll = false;

  final List<Map<String, dynamic>> _boys = [
    {
      'initials': 'KR',
      'name': 'Karthik R',
      'subtitle': '1 shift · Rate and add favourite',
      'eligible': true,
      'isRated': false,
    },
    {
      'initials': 'AS',
      'name': 'Arun S',
      'subtitle': '1 shift · Your review is pending',
      'eligible': true,
      'isRated': false,
    },
    {
      'initials': 'VM',
      'name': 'Vijay M',
      'subtitle': 'Only completed staff can be rated',
      'eligible': false,
      'isRated': false,
    },
    {
      'initials': 'SK',
      'name': 'Suresh K',
      'subtitle': '1 shift · Rate and add favourite',
      'eligible': true,
      'isRated': false,
    },
    {
      'initials': 'RP',
      'name': 'Ramesh P',
      'subtitle': '1 shift · Rate and add favourite',
      'eligible': true,
      'isRated': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );

    final displayList = _showAll ? _boys : _boys.sublist(0, 3);

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
                    'Rate staff punctuality, attitude, and work efficiency.',
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
                      'Rate your team',
                      style: GoogleFonts.inter(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0F2D24),
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(height: 6.h),

                    // Subtitle
                    Text(
                      widget.subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // List of boys to rate
                    ...displayList.map((boy) {
                      final bool eligible = boy['eligible'] as bool;
                      final bool isRated = boy['isRated'] as bool;

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
                            borderRadius: BorderRadius.circular(14.r),
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
                                  boy['initials'] as String,
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
                                      boy['name'] as String,
                                      style: GoogleFonts.inter(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF0F2D24),
                                      ),
                                    ),
                                    SizedBox(height: 3.h),
                                    Text(
                                      boy['subtitle'] as String,
                                      style: GoogleFonts.inter(
                                        fontSize: 12.5.sp,
                                        color: const Color(0xFF64748B),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Action Button / Badge
                              if (isRated)
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 5.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE8F5E9),
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                  child: Text(
                                    'Rated ★',
                                    style: GoogleFonts.inter(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF2E7D32),
                                    ),
                                  ),
                                )
                              else if (eligible)
                                OutlinedButton(
                                  onPressed: () async {
                                    final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RateBoyScreen(
                                          boyName: boy['name'] as String,
                                          initials: boy['initials'] as String,
                                          venue: widget.venue,
                                        ),
                                      ),
                                    );
                                    if (result == true) {
                                      setState(() {
                                        boy['isRated'] = true;
                                        boy['subtitle'] =
                                            '1 shift · Review submitted';
                                      });
                                    }
                                  },
                                  style: OutlinedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 14.w,
                                      vertical: 6.h,
                                    ),
                                    side: const BorderSide(
                                      color: Color(0xFFCBD5E1),
                                      width: 1.0,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Rate',
                                        style: GoogleFonts.inter(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF0F2D24),
                                        ),
                                      ),
                                      Icon(
                                        Icons.chevron_right,
                                        size: 16.r,
                                        color: const Color(0xFF0F2D24),
                                      ),
                                    ],
                                  ),
                                )
                              else
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 5.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF1F5F9),
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                  child: Text(
                                    'Not eligible',
                                    style: GoogleFonts.inter(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF94A3B8),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    }),

                    // Other completed boys toggle
                    if (!_showAll)
                      GestureDetector(
                        onTap: () => setState(() => _showAll = true),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 14.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(14.r),
                            border: Border.all(
                              color: const Color(0xFFE2E8F0),
                              width: 1.2,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Other completed boys',
                                style: GoogleFonts.inter(
                                  fontSize: 14.5.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF0F2D24),
                                ),
                              ),
                              Text(
                                'Review',
                                style: GoogleFonts.inter(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F766E),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(height: 20.h),

                    // Mutual ratings info box (soft mint/green)
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
                            'Mutual ratings',
                            style: GoogleFonts.inter(
                              fontSize: 14.5.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF166534),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Reviews appear after both sides submit.',
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              color: const Color(0xFF15803D),
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

            // Bottom Button: Back to booking
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
                    'Back to booking',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
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
