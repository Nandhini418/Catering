import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:catering/constants/app_colors.dart';

class BoyCancelledScreen extends StatefulWidget {
  final String boyName;
  final String reason;
  final String timeBeforeShift;

  const BoyCancelledScreen({
    super.key,
    this.boyName = 'Vijay M',
    this.reason = 'health problem',
    this.timeBeforeShift = '4 hours before the shift',
  });

  @override
  State<BoyCancelledScreen> createState() => _BoyCancelledScreenState();
}

class _BoyCancelledScreenState extends State<BoyCancelledScreen> {
  bool _searchWidened = false;
  int _boysAlertedCount = 12;

  void _widenSearch() {
    setState(() {
      _searchWidened = true;
      _boysAlertedCount = 28;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Search radius extended to 20 km. 16 additional boys alerted!',
          style: GoogleFonts.inter(),
        ),
        backgroundColor: const Color(0xFF0E6347),
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
                    'Instant replacement system automatically finds qualified substitutes.',
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
                      'A boy cancelled',
                      style: GoogleFonts.inter(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0F2D24),
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Boy Cancelled Alert Banner (soft red/rose)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF2F2),
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(
                          color: const Color(0xFFFECACA),
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.boyName} cancelled',
                            style: GoogleFonts.inter(
                              fontSize: 14.5.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFDC2626),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Reason: ${widget.reason}. ${widget.timeBeforeShift}.',
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              color: const Color(0xFFB91C1C),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Boys ready progress: 9 of 10
                    Row(
                      children: [
                        Text(
                          'Boys ready',
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F2D24),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          '9 of 10',
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFB45309),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4.r),
                      child: LinearProgressIndicator(
                        value: 0.9,
                        minHeight: 6.h,
                        backgroundColor: const Color(0xFFE2E8F0),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFFB45309),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Replacement Alert Banner (soft cream/yellow)
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
                            'Replacement alert sent',
                            style: GoogleFonts.inter(
                              fontSize: 14.5.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFB45309),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            _searchWidened
                                ? '$_boysAlertedCount boys within 20 km were alerted.'
                                : '$_boysAlertedCount boys below 10 km were alerted.',
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              color: const Color(0xFF9A5B13),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Widen search button
                    SizedBox(
                      width: double.infinity,
                      height: 46.h,
                      child: OutlinedButton(
                        onPressed: _searchWidened ? null : _widenSearch,
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: _searchWidened
                                ? const Color(0xFFCBD5E1)
                                : const Color(0xFF94A3B8),
                            width: 1.2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Text(
                          _searchWidened
                              ? 'Search radius widened to 20 km'
                              : 'Widen search to 10 to 20 km',
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: _searchWidened
                                ? const Color(0xFF94A3B8)
                                : const Color(0xFF0F2D24),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Cancellation rules box (soft gray/cream)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(
                          color: const Color(0xFFE2E8F0),
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cancellation rules',
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F2D24),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Boy cancels within 2 hours: 1 warning. At 3 warnings, admin blocks the account. Agent cancels within 2 hours: 50% booking charge.',
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              color: const Color(0xFF64748B),
                              height: 1.45,
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

            // Bottom Button: Back to booking status
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
                    'Back to booking status',
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
