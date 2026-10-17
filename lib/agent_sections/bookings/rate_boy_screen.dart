import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:catering/constants/app_colors.dart';
import 'package:catering/agent_sections/bookings/review_saved_screen.dart';

class RateBoyScreen extends StatefulWidget {
  final String boyName;
  final String initials;
  final String venue;

  const RateBoyScreen({
    super.key,
    this.boyName = 'Karthik R',
    this.initials = 'KR',
    this.venue = 'Annai Mahal',
  });

  @override
  State<RateBoyScreen> createState() => _RateBoyScreenState();
}

class _RateBoyScreenState extends State<RateBoyScreen> {
  int _rating = 4;
  bool _addToFavourites = true;
  late TextEditingController _reviewController;

  final Map<int, String> _ratingLabels = {
    1: '1 out of 5 · Needs improvement',
    2: '2 out of 5 · Fair performance',
    3: '3 out of 5 · Average service',
    4: '4 out of 5 · Good service',
    5: '5 out of 5 · Outstanding service',
  };

  @override
  void initState() {
    super.initState();
    _reviewController = TextEditingController();
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  String get _firstName => widget.boyName.split(' ').first;

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
                    'Your ratings help build quality records for top-performing catering staff.',
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

                    // Title: How did Karthik do?
                    Text(
                      'How did $_firstName do?',
                      style: GoogleFonts.inter(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0F2D24),
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Boy card
                    Container(
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
                              widget.initials,
                              style: GoogleFonts.inter(
                                fontSize: 14.5.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF9A5B13),
                              ),
                            ),
                          ),
                          SizedBox(width: 14.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.boyName,
                                  style: GoogleFonts.inter(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF0F2D24),
                                  ),
                                ),
                                SizedBox(height: 3.h),
                                Text(
                                  'Peelamedu · ${widget.venue}',
                                  style: GoogleFonts.inter(
                                    fontSize: 12.5.sp,
                                    color: const Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 3.h,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F5E9),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              'Completed',
                              style: GoogleFonts.inter(
                                fontSize: 11.5.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF2E7D32),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Star Rating Widget
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          final starIndex = index + 1;
                          final isFilled = starIndex <= _rating;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _rating = starIndex;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6.w),
                              child: Icon(
                                isFilled ? Icons.star : Icons.star_border,
                                size: 36.r,
                                color: isFilled
                                    ? const Color(0xFFEAB308)
                                    : const Color(0xFFCBD5E1),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    SizedBox(height: 10.h),

                    // Rating description text
                    Center(
                      child: Text(
                        _ratingLabels[_rating] ?? '$_rating out of 5',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0F2D24),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Review input field
                    Text(
                      'Your review',
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: const Color(0xFFCBD5E1),
                          width: 1.2,
                        ),
                      ),
                      child: TextField(
                        controller: _reviewController,
                        maxLines: 4,
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          color: const Color(0xFF0F2D24),
                        ),
                        decoration: InputDecoration(
                          hintText:
                              "Review the boy's punctuality and service",
                          hintStyle: GoogleFonts.inter(
                            fontSize: 13.5.sp,
                            color: const Color(0xFF94A3B8),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(16.r),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Add to favourite boys switch
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Add to favourite boys',
                                style: GoogleFonts.inter(
                                  fontSize: 14.5.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F2D24),
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                'Priority alerts for future bookings',
                                style: GoogleFonts.inter(
                                  fontSize: 12.5.sp,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: _addToFavourites,
                          activeThumbColor: AppColors.primary,
                          activeTrackColor: const Color(0xFFFEF5E7),
                          onChanged: (val) {
                            setState(() {
                              _addToFavourites = val;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),

                    // Reviews stay fair notice
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
                            'Reviews stay fair',
                            style: GoogleFonts.inter(
                              fontSize: 14.5.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFB45309),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Visible on profiles after you and the supplier both submit',
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              color: const Color(0xFF9A5B13),
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

            // Submit review button
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
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReviewSavedScreen(
                          boyName: widget.boyName,
                          initials: widget.initials,
                          rating: _rating,
                          isFavourite: _addToFavourites,
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
                    'Submit review',
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
