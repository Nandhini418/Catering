import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:catering/constants/app_colors.dart';
import 'package:catering/supplier_sections/supplier_home_sections/supplier_home_screen.dart';
import 'package:catering/supplier_sections/supplier_add_id_back_screen.dart';
import 'package:catering/supplier_sections/supplier_resubmit_id_screen.dart';
import 'package:catering/supplier_sections/verification_documents.dart';

class SupplierFixIdScreen extends StatefulWidget {
  final VerificationDocuments? documents;

  const SupplierFixIdScreen({
    super.key,
    this.documents,
  });

  @override
  State<SupplierFixIdScreen> createState() => _SupplierFixIdScreenState();
}

class _SupplierFixIdScreenState extends State<SupplierFixIdScreen> {
  late VerificationDocuments _docs;

  @override
  void initState() {
    super.initState();
    _docs = widget.documents ??
        VerificationDocuments(
          isFrontAdded: true,
          isBackAdded: true,
          isSelfieAdded: true,
          isBackUnclear: true,
        );
  }

  Future<void> _replaceDoc(String docType) async {
    String title = 'Replace ID back';
    String desc = 'Choose a clear, readable image.';
    if (docType == 'front') {
      title = 'Replace ID front';
      desc = 'Ensure all 4 corners and details are sharply focused.';
    } else if (docType == 'selfie') {
      title = 'Retake selfie with ID';
      desc = 'Make sure both face and ID text are clearly visible.';
    }

    final result = await Navigator.push<UploadedDocResult>(
      context,
      MaterialPageRoute(
        builder: (context) => SupplierAddIdBackScreen(
          title: title,
          subtitle: desc,
        ),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        if (docType == 'front') _docs.isFrontUnclear = result.isUnclear;
        if (docType == 'back') _docs.isBackUnclear = result.isUnclear;
        if (docType == 'selfie') _docs.isSelfieUnclear = result.isUnclear;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            result.isUnclear
                ? '$title uploaded, but still flagged as blurry.'
                : '$title uploaded successfully!',
            style: GoogleFonts.inter(),
          ),
          backgroundColor:
              result.isUnclear ? const Color(0xFFB45309) : AppColors.primary,
        ),
      );
    }
  }

  void _handleResubmitOrContinue() async {
    if (_docs.hasAnyUnclear) {
      // Navigate to Screen 4 (Resubmit your ID)
      final updated = await Navigator.push<VerificationDocuments>(
        context,
        MaterialPageRoute(
          builder: (context) => SupplierResubmitIdScreen(documents: _docs),
        ),
      );

      if (updated != null && mounted) {
        setState(() {
          _docs = updated;
        });
      }
    } else {
      // All clear -> Continue to Supplier Home Screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SupplierHomeScreen(),
        ),
      );
    }
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

    final bool hasUnclear = _docs.hasAnyUnclear;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context, _docs),
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
                    hasUnclear
                        ? 'Re-uploading the flagged document is required for verification.'
                        : 'All submitted documents are verified and clear.',
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
                      hasUnclear ? 'Let’s fix your ID' : 'ID verified',
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
                      hasUnclear
                          ? 'Your account isn’t approved yet.'
                          : 'All your documents are accepted.',
                      style: GoogleFonts.inter(
                        fontSize: 15.sp,
                        color: const Color(0xFF64748B),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Card 1: Alert Card (Red if unclear, Soft green if all clear)
                    if (hasUnclear)
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(18.r),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFDF2F2),
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: const Color(0xFFFEE2E2),
                            width: 1.0,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _docs.unclearTitle,
                              style: GoogleFonts.inter(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF991B1B),
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              _docs.unclearDescription,
                              style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                color: const Color(0xFFB91C1C),
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
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
                            Row(
                              children: [
                                Text(
                                  'All documents accepted',
                                  style: GoogleFonts.inter(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF0F766E),
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                const Icon(
                                  Icons.check_circle,
                                  color: Color(0xFF0F766E),
                                  size: 20,
                                ),
                              ],
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              'All photos are clearly visible and match verification guidelines.',
                              style: GoogleFonts.inter(
                                fontSize: 13.5.sp,
                                color: const Color(0xFF334155),
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    SizedBox(height: 18.h),

                    // Card 2: Document Verification Status list
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
                          _buildDocRow(
                            title: 'ID front',
                            isUnclear: _docs.isFrontUnclear,
                            onReplace: () => _replaceDoc('front'),
                          ),
                          SizedBox(height: 16.h),
                          _buildDocRow(
                            title: 'Selfie with ID',
                            isUnclear: _docs.isSelfieUnclear,
                            onReplace: () => _replaceDoc('selfie'),
                          ),
                          SizedBox(height: 16.h),
                          _buildDocRow(
                            title: 'ID back',
                            isUnclear: _docs.isBackUnclear,
                            onReplace: () => _replaceDoc('back'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 22.h),

                    // Info text
                    Text(
                      hasUnclear
                          ? 'Only the flagged image needs to be replaced. Your ID stays private to admin.'
                          : 'Your documents are securely stored and visible only to admin.',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: const Color(0xFF64748B),
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),

            // Pinned Bottom Button: "Continue" when all accepted, "Resubmit documents" when unclear
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
                  onPressed: _handleResubmitOrContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    hasUnclear ? 'Resubmit documents' : 'Continue',
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

  Widget _buildDocRow({
    required String title,
    required bool isUnclear,
    required VoidCallback onReplace,
  }) {
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
        if (isUnclear)
          InkWell(
            onTap: onReplace,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              child: Text(
                'Replace',
                style: GoogleFonts.inter(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFDC2626),
                  decoration: TextDecoration.underline,
                  decorationColor: const Color(0xFFDC2626),
                ),
              ),
            ),
          )
        else
          Text(
            'Accepted',
            style: GoogleFonts.inter(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0F766E),
            ),
          ),
      ],
    );
  }
}
