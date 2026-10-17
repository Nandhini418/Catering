import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:catering/constants/app_colors.dart';
import 'package:catering/agent_sections/bookings/supplier_profile_screen.dart';
import 'package:catering/agent_sections/bookings/rate_team_screen.dart';
import 'package:catering/agent_sections/bookings/boy_cancelled_screen.dart';

class TeamAttendanceScreen extends StatefulWidget {
  final String venue;
  final String dateTime;

  const TeamAttendanceScreen({
    super.key,
    this.venue = 'Annai Mahal',
    this.dateTime = 'Sat, 11 Oct · 6:00 AM',
  });

  @override
  State<TeamAttendanceScreen> createState() => _TeamAttendanceScreenState();
}

class _TeamAttendanceScreenState extends State<TeamAttendanceScreen> {
  bool _expandedAll = false;

  final List<Map<String, dynamic>> _coreBoys = [
    {
      'initials': 'KR',
      'name': 'Karthik R',
      'subtitle': 'Reached · time recorded',
      'status': 'Reached',
      'statusColor': const Color(0xFF0E6347),
      'statusBg': const Color(0xFFE8F5E9),
      'rating': 4.8,
      'shifts': 12,
    },
    {
      'initials': 'AS',
      'name': 'Arun S',
      'subtitle': 'On the way · 6.8 km',
      'status': 'On way',
      'statusColor': const Color(0xFFB45309),
      'statusBg': const Color(0xFFFEF3C7),
      'rating': 4.6,
      'shifts': 7,
    },
    {
      'initials': 'VM',
      'name': 'Vijay M',
      'subtitle': 'Accepted · 7.5 km',
      'status': 'Accepted',
      'statusColor': const Color(0xFF475569),
      'statusBg': const Color(0xFFF1F5F9),
      'rating': 4.4,
      'shifts': 5,
    },
  ];

  final List<Map<String, dynamic>> _extraBoys = [
    {
      'initials': 'SK',
      'name': 'Suresh K',
      'subtitle': 'On the way · 5.1 km',
      'status': 'On way',
      'statusColor': const Color(0xFFB45309),
      'statusBg': const Color(0xFFFEF3C7),
      'rating': 4.5,
      'shifts': 4,
    },
    {
      'initials': 'RP',
      'name': 'Ramesh P',
      'subtitle': 'Accepted · 8.0 km',
      'status': 'Accepted',
      'statusColor': const Color(0xFF475569),
      'statusBg': const Color(0xFFF1F5F9),
      'rating': 4.7,
      'shifts': 9,
    },
    {
      'initials': 'MN',
      'name': 'Manoj N',
      'subtitle': 'Reached · time recorded',
      'status': 'Reached',
      'statusColor': const Color(0xFF0E6347),
      'statusBg': const Color(0xFFE8F5E9),
      'rating': 4.9,
      'shifts': 15,
    },
    {
      'initials': 'DK',
      'name': 'Dinesh K',
      'subtitle': 'On the way · 3.5 km',
      'status': 'On way',
      'statusColor': const Color(0xFFB45309),
      'statusBg': const Color(0xFFFEF3C7),
      'rating': 4.3,
      'shifts': 3,
    },
    {
      'initials': 'PP',
      'name': 'Praveen P',
      'subtitle': 'Accepted · 9.1 km',
      'status': 'Accepted',
      'statusColor': const Color(0xFF475569),
      'statusBg': const Color(0xFFF1F5F9),
      'rating': 4.6,
      'shifts': 8,
    },
    {
      'initials': 'RA',
      'name': 'Ravi A',
      'subtitle': 'Accepted · 11.2 km',
      'status': 'Accepted',
      'statusColor': const Color(0xFF475569),
      'statusBg': const Color(0xFFF1F5F9),
      'rating': 4.2,
      'shifts': 6,
    },
    {
      'initials': 'SS',
      'name': 'Saravanan S',
      'subtitle': 'Reached · time recorded',
      'status': 'Reached',
      'statusColor': const Color(0xFF0E6347),
      'statusBg': const Color(0xFFE8F5E9),
      'rating': 4.8,
      'shifts': 11,
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

    final displayBoys =
        _expandedAll ? [..._coreBoys, ..._extraBoys] : _coreBoys;

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
                    'Real-time geo-verified attendance of assigned boys.',
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
                      'Team attendance',
                      style: GoogleFonts.inter(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0F2D24),
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(height: 6.h),

                    // Venue and date
                    Text(
                      '${widget.venue} · ${widget.dateTime}',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Arrival times recorded banner (light yellow/cream)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF9ED),
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(
                          color: const Color(0xFFFDE68A),
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Arrival times recorded',
                            style: GoogleFonts.inter(
                              fontSize: 14.5.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFB45309),
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            'Reached status is verified within 200 m and saved for you and admin.',
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              color: const Color(0xFF9A5B13),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 18.h),

                    // Boys Attendance Cards List
                    ...displayBoys.map((boy) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: GestureDetector(
                          onTap: () {
                            if (boy['name'] == 'Vijay M') {
                              _showBoyActionDialog(boy);
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SupplierProfileScreen(
                                    name: boy['name'] as String,
                                    initials: boy['initials'] as String,
                                    area: 'Peelamedu',
                                    rating: (boy['rating'] as num).toDouble(),
                                    shifts: boy['shifts'] as int,
                                  ),
                                ),
                              );
                            }
                          },
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

                                // Name & subtitle
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          fontSize: 13.sp,
                                          color: const Color(0xFF64748B),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Status badge
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 4.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: boy['statusBg'] as Color,
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                  child: Text(
                                    boy['status'] as String,
                                    style: GoogleFonts.inter(
                                      fontSize: 12.5.sp,
                                      fontWeight: FontWeight.w700,
                                      color: boy['statusColor'] as Color,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),

                    // 7 more assigned boys toggle
                    if (!_expandedAll) ...[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _expandedAll = true;
                          });
                        },
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
                                '7 more assigned boys',
                                style: GoogleFonts.inter(
                                  fontSize: 14.5.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF0F2D24),
                                ),
                              ),
                              Text(
                                'View',
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
                      SizedBox(height: 8.h),
                    ],

                    Text(
                      'Attendance updates appear here for every assigned boy.',
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        color: const Color(0xFF94A3B8),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Staff privacy protected card
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF9ED),
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(
                          color: const Color(0xFFFDE68A),
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
                              color: const Color(0xFFB45309),
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            'Only photo, profile, rating and area are shown to you. Phone numbers and IDs stay hidden.',
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              color: const Color(0xFF9A5B13),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
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
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'View booking',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  SizedBox(
                    width: double.infinity,
                    height: 44.h,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RateTeamScreen(),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Color(0xFFCBD5E1),
                          width: 1.2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Text(
                        'Shift completed · Rate team',
                        style: GoogleFonts.inter(
                          fontSize: 14.5.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0F2D24),
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
    );
  }

  void _showBoyActionDialog(Map<String, dynamic> boy) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      backgroundColor: AppColors.white,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Vijay M (Accepted)',
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F2D24),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Assigned serving boy · Singanallur · 7.5 km away',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: const Color(0xFF64748B),
                  ),
                ),
                SizedBox(height: 20.h),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.person_outline, color: AppColors.primary),
                  title: Text(
                    'View Profile',
                    style: GoogleFonts.inter(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SupplierProfileScreen(
                          name: 'Vijay M',
                          initials: 'VM',
                          area: 'Singanallur',
                          rating: 4.4,
                          shifts: 5,
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.cancel_outlined, color: Color(0xFFDC2626)),
                  title: Text(
                    'Simulate Boy Cancellation',
                    style: GoogleFonts.inter(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFDC2626),
                    ),
                  ),
                  subtitle: Text(
                    'Tests the "A boy cancelled" flow',
                    style: GoogleFonts.inter(fontSize: 12.sp),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BoyCancelledScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
