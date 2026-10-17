import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:catering/constants/app_colors.dart';

class AgentDateReportingTimeScreen extends StatefulWidget {
  final String initialDate;
  final String initialTime;

  const AgentDateReportingTimeScreen({
    super.key,
    this.initialDate = 'Sat, 11 Oct',
    this.initialTime = '6:00 AM',
  });

  @override
  State<AgentDateReportingTimeScreen> createState() =>
      _AgentDateReportingTimeScreenState();
}

class _AgentDateReportingTimeScreenState
    extends State<AgentDateReportingTimeScreen> {
  int _selectedDay = 11;
  final String _selectedMonth = 'October';
  final String _hour = '06';
  final String _min = '00';
  String _period = 'AM';

  final List<String> _weekDays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  // Days in calendar starting Monday October 6th (matching Figma layout)
  final List<int> _calendarDays = [
    6, 7, 8, 9, 10, 11, 12,
    13, 14, 15, 16, 17, 18, 19,
    20, 21, 22, 23, 24, 25, 26,
    27, 28, 29, 30, 31,
  ];

  String _formatSelectedDate(int day) {
    // 11th is Sat in October (matches Figma "Sat, 11 Oct")
    final dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final weekdayIndex = (day - 6) % 7;
    final weekdayName = dayNames[weekdayIndex];
    return '$weekdayName, $day Oct';
  }

  void _confirm() {
    final dateStr = _formatSelectedDate(_selectedDay);
    final timeStr = '${int.tryParse(_hour) ?? 6}:$_min $_period';
    Navigator.pop(context, {
      'date': dateStr,
      'time': timeStr,
    });
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
                    'Select date and reporting time for catering team arrival.',
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
                      'Date & reporting time',
                      style: GoogleFonts.inter(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0F2D24),
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Month Header
                    Row(
                      children: [
                        Text(
                          _selectedMonth,
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F2D24),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Icon(Icons.chevron_left,
                            size: 20.r, color: const Color(0xFF64748B)),
                        Icon(Icons.chevron_right,
                            size: 20.r, color: const Color(0xFF64748B)),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // Calendar Container
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: const Color(0xFFE2E8F0),
                          width: 1.2,
                        ),
                      ),
                      child: Column(
                        children: [
                          // Weekdays row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: _weekDays.map((d) {
                              return SizedBox(
                                width: 36.w,
                                child: Center(
                                  child: Text(
                                    d,
                                    style: GoogleFonts.inter(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF64748B),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 12.h),

                          // Calendar Grid
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _calendarDays.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 7,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              childAspectRatio: 1.0,
                            ),
                            itemBuilder: (context, index) {
                              final day = _calendarDays[index];
                              final isSelected = day == _selectedDay;

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedDay = day;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColors.primary
                                        : Colors.transparent,
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '$day',
                                    style: GoogleFonts.inter(
                                      fontSize: 14.sp,
                                      fontWeight: isSelected
                                          ? FontWeight.w700
                                          : FontWeight.w500,
                                      color: isSelected
                                          ? Colors.white
                                          : const Color(0xFF0F2D24),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 18.h),

                    // Selected Date Box
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
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
                            'Selected date',
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            _formatSelectedDate(_selectedDay),
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0F2D24),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Time Row (06 hour, 00 min, AM)
                    Row(
                      children: [
                        // Hour
                        Expanded(
                          child: Container(
                            height: 48.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF9ED),
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: AppColors.primary,
                                width: 1.2,
                              ),
                            ),
                            child: Text(
                              '$_hour hour',
                              style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFB45309),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),

                        // Minute
                        Expanded(
                          child: Container(
                            height: 48.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: const Color(0xFFE2E8F0),
                                width: 1.2,
                              ),
                            ),
                            child: Text(
                              '$_min min',
                              style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF0F2D24),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),

                        // AM / PM
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _period = _period == 'AM' ? 'PM' : 'AM';
                              });
                            },
                            child: Container(
                              height: 48.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: const Color(0xFFE2E8F0),
                                  width: 1.2,
                                ),
                              ),
                              child: Text(
                                _period,
                                style: GoogleFonts.inter(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F2D24),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 14.h),

                    // Helper note
                    Text(
                      'Report at $_hour:$_min $_period. Dates follow the PDF example; no year is assigned.',
                      style: GoogleFonts.inter(
                        fontSize: 12.5.sp,
                        color: const Color(0xFF64748B),
                        height: 1.35,
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),

            // Bottom Pinned: Confirm date & time
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
                  onPressed: _confirm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Confirm date & time',
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
