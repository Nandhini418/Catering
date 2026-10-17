import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:catering/constants/app_colors.dart';
import 'package:catering/supplier_sections/supplier_add_id_back_screen.dart';
import 'package:catering/supplier_sections/verification_documents.dart';

class SupplierResubmitIdScreen extends StatefulWidget {
  final VerificationDocuments? documents;
  final String idNumber;

  const SupplierResubmitIdScreen({
    super.key,
    this.documents,
    this.idNumber = 'XXXX XXXX 4821',
  });

  @override
  State<SupplierResubmitIdScreen> createState() =>
      _SupplierResubmitIdScreenState();
}

class _SupplierResubmitIdScreenState extends State<SupplierResubmitIdScreen> {
  late VerificationDocuments _docs;
  bool _isReplaced = true;

  @override
  void initState() {
    super.initState();
    _docs = widget.documents ??
        VerificationDocuments(
          isFrontAdded: true,
          isBackAdded: true,
          isSelfieAdded: true,
          isBackUnclear: true,
          idNumber: widget.idNumber,
        );
  }

  String get _replacedDocName {
    if (_docs.isFrontUnclear) return 'ID front';
    if (_docs.isSelfieUnclear) return 'Selfie with ID';
    return 'ID back';
  }

  Future<void> _handleReplacePhoto() async {
    final result = await Navigator.push<UploadedDocResult>(
      context,
      MaterialPageRoute(
        builder: (context) => SupplierAddIdBackScreen(
          title: 'Replace $_replacedDocName',
          subtitle: 'Choose a sharp, well-lit photo.',
        ),
      ),
    );

    if (result != null && mounted) {
      setState(() => _isReplaced = true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'New $_replacedDocName photo attached successfully!',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: AppColors.primary,
        ),
      );
    }
  }

  void _handleSubmitForReview() {
    // Clear the unclear flag on the resubmitted document
    if (_docs.isBackUnclear) _docs.isBackUnclear = false;
    if (_docs.isFrontUnclear) _docs.isFrontUnclear = false;
    if (_docs.isSelfieUnclear) _docs.isSelfieUnclear = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        contentPadding: EdgeInsets.all(24.r),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 58.r,
              height: 58.r,
              decoration: const BoxDecoration(
                color: Color(0xFFFEF5E7),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle,
                color: AppColors.primary,
                size: 38,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Resubmission Sent!',
              style: GoogleFonts.inter(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F2D24),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Your replacement photo has been submitted and verified. All details are now accepted.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: const Color(0xFF64748B),
                height: 1.4,
              ),
            ),
            SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx); // Close dialog
                  // Return updated docs back to SupplierFixIdScreen
                  Navigator.pop(context, _docs);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Continue',
                  style: GoogleFonts.inter(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
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
                    'Ensure the new image is not blurry and all four corners are visible.',
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
                      'Resubmit your ID',
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
                      'A clearer image helps us approve you quickly.',
                      style: GoogleFonts.inter(
                        fontSize: 15.sp,
                        color: const Color(0xFF64748B),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Card 1: ID number
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 18.w,
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ID number',
                            style: GoogleFonts.inter(
                              fontSize: 12.5.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            _docs.idNumber,
                            style: GoogleFonts.inter(
                              fontSize: 16.5.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF0F2D24),
                              letterSpacing: 0.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Card 2: Replaced photo status card (peach tinted box with checkmark)
                    GestureDetector(
                      onTap: _handleReplacePhoto,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(18.r),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF5E7),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '$_replacedDocName replaced',
                                  style: GoogleFonts.inter(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF0F2D24),
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Icon(
                                  Icons.check,
                                  color: const Color(0xFFB89035),
                                  size: 19.r,
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'New photo added · tap to replace',
                              style: GoogleFonts.inter(
                                fontSize: 13.5.sp,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Card 3: Kept status for untouched documents
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
                          if (_replacedDocName != 'ID front') ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'ID front',
                                  style: GoogleFonts.inter(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF0F2D24),
                                  ),
                                ),
                                Text(
                                  'Kept',
                                  style: GoogleFonts.inter(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFFB45309),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 14.h),
                          ],
                          if (_replacedDocName != 'Selfie with ID') ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Selfie with ID',
                                  style: GoogleFonts.inter(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF0F2D24),
                                  ),
                                ),
                                Text(
                                  'Kept',
                                  style: GoogleFonts.inter(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFFB45309),
                                  ),
                                ),
                              ],
                            ),
                            if (_replacedDocName != 'ID back')
                              SizedBox(height: 14.h),
                          ],
                          if (_replacedDocName != 'ID back') ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'ID back',
                                  style: GoogleFonts.inter(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF0F2D24),
                                  ),
                                ),
                                Text(
                                  'Kept',
                                  style: GoogleFonts.inter(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFFB45309),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Card 4: Ready for review
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(18.r),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF5E7),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ready for review',
                            style: GoogleFonts.inter(
                              fontSize: 15.5.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF9A5B13),
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            'Admin will review your resubmission within 24 hours.',
                            style: GoogleFonts.inter(
                              fontSize: 13.5.sp,
                              color: const Color(0xFF785B38),
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

            // Pinned Bottom Button: Submit for review
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
                  onPressed: _isReplaced ? _handleSubmitForReview : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Submit for review',
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
