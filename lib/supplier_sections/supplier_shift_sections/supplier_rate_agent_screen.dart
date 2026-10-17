import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:catering/constants/app_colors.dart';
import 'package:catering/supplier_sections/supplier_home_sections/supplier_home_screen.dart';

class SupplierRateAgentScreen extends StatefulWidget {
  final String agentName;
  final String venue;

  const SupplierRateAgentScreen({
    super.key,
    this.agentName = 'Sri Murugan Caterers',
    this.venue = 'Annai Mahal, Peelamedu',
  });

  @override
  State<SupplierRateAgentScreen> createState() =>
      _SupplierRateAgentScreenState();
}

class _SupplierRateAgentScreenState extends State<SupplierRateAgentScreen> {
  int _rating = 4;
  late final TextEditingController _reviewController;

  @override
  void initState() {
    super.initState();
    _reviewController = TextEditingController(
      text:
          'Payment was clear and food service was well planned. Happy to work again.',
    );
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  String _getRatingLabel(int rating) {
    switch (rating) {
      case 1:
        return '1 out of 5 · Poor';
      case 2:
        return '2 out of 5 · Fair';
      case 3:
        return '3 out of 5 · Average';
      case 4:
        return '4 out of 5 · Good';
      case 5:
        return '5 out of 5 · Excellent';
      default:
        return '$rating out of 5';
    }
  }

  void _submitReview() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Row(
          children: [
            const Icon(Icons.check_circle, color: Color(0xFF0E6347)),
            SizedBox(width: 8.w),
            Text(
              'Review Submitted',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F2D24),
              ),
            ),
          ],
        ),
        content: Text(
          'Thank you for rating ${widget.agentName}! Your feedback has been recorded.',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            color: const Color(0xFF475569),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const SupplierHomeScreen(),
                ),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: Text(
              'Back to Home',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
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
                    'Both parties rate each other to ensure fair and trustworthy experiences.',
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
                      'How was the shift?',
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
                      'Agents rate boys and boys rate the agent.',
                      style: GoogleFonts.inter(
                        fontSize: 14.5.sp,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    SizedBox(height: 22.h),

                    // Rating Card
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
                          Text(
                            'Rating for',
                            style: GoogleFonts.inter(
                              fontSize: 13.5.sp,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            widget.agentName,
                            style: GoogleFonts.inter(
                              fontSize: 16.5.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F2D24),
                            ),
                          ),
                          SizedBox(height: 16.h),

                          // 5 Stars row
                          Row(
                            children: List.generate(5, (index) {
                              final starNum = index + 1;
                              final isSelected = starNum <= _rating;
                              return GestureDetector(
                                onTap: () => setState(() => _rating = starNum),
                                child: Padding(
                                  padding: EdgeInsets.only(right: 8.w),
                                  child: Icon(
                                    isSelected
                                        ? Icons.star_rounded
                                        : Icons.star_outline_rounded,
                                    size: 34.r,
                                    color: isSelected
                                        ? const Color(0xFFB89035)
                                        : const Color(0xFFCBD5E1),
                                  ),
                                ),
                              );
                            }),
                          ),
                          SizedBox(height: 12.h),

                          // Rating Label
                          Text(
                            _getRatingLabel(_rating),
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0F2D24),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 18.h),

                    // Review Input Card
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
                            'Write a review',
                            style: GoogleFonts.inter(
                              fontSize: 13.5.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          TextField(
                            controller: _reviewController,
                            maxLines: 4,
                            minLines: 3,
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              color: const Color(0xFF0F2D24),
                              height: 1.4,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Share your experience with the agent...',
                              hintStyle: GoogleFonts.inter(
                                fontSize: 13.5.sp,
                                color: const Color(0xFF94A3B8),
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 18.h),

                    // Mutual reviews info box
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
                            'Mutual reviews',
                            style: GoogleFonts.inter(
                              fontSize: 14.5.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFB45309),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'The other side also rates you. Reviews show on profiles after both are submitted.',
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              color: const Color(0xFF9A5B13),
                              height: 1.35,
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

            // Bottom Submit Button
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
                  onPressed: _submitReview,
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
