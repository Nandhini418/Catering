import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:catering/constants/app_colors.dart';
import 'package:catering/supplier_sections/supplier_fix_id_screen.dart';
import 'package:catering/supplier_sections/verification_documents.dart';

class SupplierAlmostReadyScreen extends StatefulWidget {
  final VerificationDocuments? documents;
  final String userName;
  final String userAge;
  final String userLocation;

  const SupplierAlmostReadyScreen({
    super.key,
    this.documents,
    this.userName = 'Karthik R',
    this.userAge = '22',
    this.userLocation = 'Peelamedu',
  });

  @override
  State<SupplierAlmostReadyScreen> createState() =>
      _SupplierAlmostReadyScreenState();
}

class _SupplierAlmostReadyScreenState extends State<SupplierAlmostReadyScreen> {
  late VerificationDocuments _documents;
  bool _isResubmitted = false;

  @override
  void initState() {
    super.initState();
    _documents = widget.documents ??
        VerificationDocuments(
          isFrontAdded: true,
          isBackAdded: true,
          isSelfieAdded: true,
          isBackUnclear: true,
        );
  }

  void _navigateToFixId() async {
    final updatedDocs = await Navigator.push<VerificationDocuments>(
      context,
      MaterialPageRoute(
        builder: (context) => SupplierFixIdScreen(documents: _documents),
      ),
    );

    if (updatedDocs != null && mounted) {
      setState(() {
        _documents = updatedDocs;
        _isResubmitted = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _documents.isAllClear
                ? 'All documents verified and accepted!'
                : 'Documents updated for admin review.',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: const Color(0xFF0F766E),
        ),
      );
    }
  }

  void _handleContactSupport() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Contacting support at support@caterconnect.com',
          style: GoogleFonts.inter(),
        ),
        backgroundColor: AppColors.primary,
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

    final bool hasUnclear = _documents.hasAnyUnclear;

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
                    'Our team reviews documents within 24 hours of submission.',
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

                    // Category Tag: SUPPLIER
                    Text(
                      'SUPPLIER',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F766E),
                        letterSpacing: 0.6,
                      ),
                    ),
                    SizedBox(height: 8.h),

                    // Main Title
                    Text(
                      'You’re almost ready',
                      style: GoogleFonts.inter(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0F2D24),
                        letterSpacing: -0.6,
                      ),
                    ),
                    SizedBox(height: 8.h),

                    // Subtitle
                    Text(
                      'Your profile is waiting for admin approval.',
                      style: GoogleFonts.inter(
                        fontSize: 15.sp,
                        color: const Color(0xFF64748B),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Card 1: Review in progress (Mint green card)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(18.r),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _isResubmitted
                                ? 'Resubmission in progress'
                                : 'Review in progress',
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F766E),
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            _isResubmitted
                                ? 'Admin is reviewing your updated document.'
                                : 'Admin checks your documents within 24 hours.',
                            style: GoogleFonts.inter(
                              fontSize: 13.5.sp,
                              color: const Color(0xFF334155),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Optional Unclear Alert Banner if image has an issue
                    if (hasUnclear) ...[
                      GestureDetector(
                        onTap: _navigateToFixId,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(14.r),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFDF2F2),
                            borderRadius: BorderRadius.circular(14.r),
                            border: Border.all(
                              color: const Color(0xFFFEE2E2),
                              width: 1.0,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: const Color(0xFFDC2626),
                                size: 22.r,
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Text(
                                  'Issue flagged: ${_documents.unclearTitle}. Tap to view and fix.',
                                  style: GoogleFonts.inter(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF991B1B),
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: const Color(0xFF991B1B),
                                size: 20.r,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                    ],

                    // Card 2: User Details Card (KR, Karthik R, Age 22, Peelamedu, Pending)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 18.w,
                        vertical: 16.h,
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
                          Container(
                            width: 44.r,
                            height: 44.r,
                            decoration: const BoxDecoration(
                              color: Color(0xFFEDE9FE),
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'KR',
                              style: GoogleFonts.inter(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF6D28D9),
                              ),
                            ),
                          ),
                          SizedBox(width: 14.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.userName,
                                  style: GoogleFonts.inter(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF0F2D24),
                                  ),
                                ),
                                SizedBox(height: 3.h),
                                Text(
                                  'Age ${widget.userAge} · ${widget.userLocation}',
                                  style: GoogleFonts.inter(
                                    fontSize: 13.5.sp,
                                    color: const Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            hasUnclear ? 'Action Needed' : 'Pending',
                            style: GoogleFonts.inter(
                              fontSize: 14.5.sp,
                              fontWeight: FontWeight.w600,
                              color: hasUnclear
                                  ? const Color(0xFFDC2626)
                                  : const Color(0xFF0F766E),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Card 3: Document Status Table
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 18.w,
                        vertical: 18.h,
                      ),
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
                          _buildReceivedRow(
                            'ID front',
                            isActionNeeded: _documents.isFrontUnclear,
                          ),
                          SizedBox(height: 16.h),
                          _buildReceivedRow(
                            'ID back',
                            isActionNeeded: _documents.isBackUnclear,
                          ),
                          SizedBox(height: 16.h),
                          _buildReceivedRow(
                            'Selfie with ID',
                            isActionNeeded: _documents.isSelfieUnclear,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Info text
                    Text(
                      'You can explore your profile and settings. Job acceptance becomes available after approval.',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: const Color(0xFF64748B),
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 18.h),

                    // Inactive Button: Accept jobs
                    Container(
                      width: double.infinity,
                      height: 50.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD5DDD7),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        'Accept jobs',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF5A6E64),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),

            // Pinned Bottom Action Buttons
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
                  // Button 1: View submitted ID
                  SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: ElevatedButton(
                      onPressed: _navigateToFixId,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'View submitted ID',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // Button 2: Contact support
                  SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: OutlinedButton(
                      onPressed: _handleContactSupport,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Color(0xFFCBD5E1),
                          width: 1.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'Contact support',
                        style: GoogleFonts.inter(
                          fontSize: 15.5.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFB89035),
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

  Widget _buildReceivedRow(String title, {required bool isActionNeeded}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F2D24),
          ),
        ),
        Text(
          isActionNeeded ? 'Replace needed' : 'Received',
          style: GoogleFonts.inter(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: isActionNeeded
                ? const Color(0xFFDC2626)
                : const Color(0xFF0F766E),
          ),
        ),
      ],
    );
  }
}
