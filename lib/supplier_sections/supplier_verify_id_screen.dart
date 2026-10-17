import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:catering/constants/app_colors.dart';
import 'package:catering/supplier_sections/supplier_add_id_back_screen.dart';
import 'package:catering/supplier_sections/supplier_almost_ready_screen.dart';
import 'package:catering/supplier_sections/verification_documents.dart';

class SupplierVerifyIdScreen extends StatefulWidget {
  const SupplierVerifyIdScreen({super.key});

  @override
  State<SupplierVerifyIdScreen> createState() => _SupplierVerifyIdScreenState();
}

class _SupplierVerifyIdScreenState extends State<SupplierVerifyIdScreen> {
  final TextEditingController _idNumberController =
      TextEditingController(text: 'XXXX XXXX 4821');

  bool _isFrontAdded = false;
  bool _isFrontUnclear = false;

  bool _isBackAdded = false;
  bool _isBackUnclear = false;

  bool _isSelfieAdded = false;
  bool _isSelfieUnclear = false;

  @override
  void dispose() {
    _idNumberController.dispose();
    super.dispose();
  }

  bool get _isReadyToSubmit => _isFrontAdded && _isBackAdded && _isSelfieAdded;

  Future<void> _handleReplaceFront() async {
    final result = await Navigator.push<UploadedDocResult>(
      context,
      MaterialPageRoute(
        builder: (context) => const SupplierAddIdBackScreen(
          title: 'Add your ID front',
          subtitle: 'Choose a clear, readable image.',
          guidelineTitle: 'Front photo guidelines',
          guidelineDescription:
              'Keep all four corners visible. Avoid glare. Your name and ID details should be readable.',
        ),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        _isFrontAdded = true;
        _isFrontUnclear = result.isUnclear;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Front photo updated successfully!',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: AppColors.primary,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _handleAddBack() async {
    final result = await Navigator.push<UploadedDocResult>(
      context,
      MaterialPageRoute(
        builder: (context) => const SupplierAddIdBackScreen(
          title: 'Add your ID back',
          subtitle: 'Choose a clear, readable image.',
        ),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        _isBackAdded = true;
        _isBackUnclear = result.isUnclear;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'ID back photo attached successfully!',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: AppColors.primary,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _handleTakeSelfie() async {
    final result = await Navigator.push<UploadedDocResult>(
      context,
      MaterialPageRoute(
        builder: (context) => const SupplierAddIdBackScreen(
          title: 'Take a selfie holding your ID',
          subtitle: 'Choose a clear, readable image.',
          guidelineTitle: 'Selfie guidelines',
          guidelineDescription:
              'Hold your ID next to your face. Make sure your face and ID details are sharp and well-lit.',
        ),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        _isSelfieAdded = true;
        _isSelfieUnclear = result.isUnclear;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Selfie holding ID captured successfully!',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: AppColors.primary,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _handleSubmit() {
    if (!_isReadyToSubmit) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please upload ID front, ID back, and selfie holding ID to continue.',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: const Color(0xFFB45309),
        ),
      );
      return;
    }

    final docs = VerificationDocuments(
      isFrontAdded: _isFrontAdded,
      isFrontUnclear: _isFrontUnclear,
      isBackAdded: _isBackAdded,
      isBackUnclear: _isBackUnclear,
      isSelfieAdded: _isSelfieAdded,
      isSelfieUnclear: _isSelfieUnclear,
      idNumber: _idNumberController.text.trim(),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SupplierAlmostReadyScreen(
          documents: docs,
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
                    'ID verification helps ensure trust and security across CaterConnect.',
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

                    // Top tracker tag
                    Text(
                      'SUPPLIER SETUP · 2 OF 2',
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
                      'Verify your ID',
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
                      'Agents trust verified boys more.',
                      style: GoogleFonts.inter(
                        fontSize: 14.5.sp,
                        color: const Color(0xFF64748B),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Card 1: Aadhaar or ID number
                    _buildIdNumberCard(),
                    SizedBox(height: 16.h),

                    // Card 2: ID front added
                    _buildIdFrontCard(),
                    SizedBox(height: 16.h),

                    // Card 3: Add ID back
                    _buildIdBackCard(),
                    SizedBox(height: 16.h),

                    // Card 4: Take a selfie holding your ID
                    _buildSelfieCard(),
                    SizedBox(height: 16.h),

                    // Card 5: Only admin can see your ID
                    _buildAdminPrivacyCard(),
                    SizedBox(height: 24.h),

                    // Helper text above bottom button
                    Text(
                      _isReadyToSubmit
                          ? 'All documents added. Ready to submit.'
                          : 'Add all ID photos and selfie to continue.',
                      style: GoogleFonts.inter(
                        fontSize: 13.5.sp,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),

            // Pinned Bottom Button Bar
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
                  onPressed: _handleSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isReadyToSubmit
                        ? AppColors.primary
                        : const Color(0xFFD5DDD7),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Submit for approval',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: _isReadyToSubmit
                          ? AppColors.white
                          : const Color(0xFF5A6E64),
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

  // Card 1: Aadhaar or ID number
  Widget _buildIdNumberCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
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
            'Aadhaar or ID number',
            style: GoogleFonts.inter(
              fontSize: 12.5.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF64748B),
            ),
          ),
          SizedBox(height: 4.h),
          TextFormField(
            controller: _idNumberController,
            style: GoogleFonts.inter(
              fontSize: 16.5.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF0F2D24),
              letterSpacing: 0.6,
            ),
            decoration: const InputDecoration(
              isDense: true,
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }

  // Card 2: ID front added
  Widget _buildIdFrontCard() {
    if (!_isFrontAdded) {
      return InkWell(
        onTap: _handleReplaceFront,
        borderRadius: BorderRadius.circular(14.r),
        child: Container(
          width: double.infinity,
          height: 52.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: const Color(0xFFE2E8F0),
              width: 1.2,
            ),
          ),
          child: Text(
            'Add ID front',
            style: GoogleFonts.inter(
              fontSize: 15.5.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFFB89035),
            ),
          ),
        ),
      );
    }

    return Container(
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
                'ID front added',
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
          GestureDetector(
            onTap: _handleReplaceFront,
            child: Text(
              'Replace front photo',
              style: GoogleFonts.inter(
                fontSize: 13.5.sp,
                color: const Color(0xFF64748B),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Card 3: Add ID back (or ID back added)
  Widget _buildIdBackCard() {
    if (_isBackAdded) {
      return Container(
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
                  'ID back added',
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
            GestureDetector(
              onTap: _handleAddBack,
              child: Text(
                'Replace back photo',
                style: GoogleFonts.inter(
                  fontSize: 13.5.sp,
                  color: const Color(0xFF64748B),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return InkWell(
      onTap: _handleAddBack,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        width: double.infinity,
        height: 52.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: const Color(0xFFE2E8F0),
            width: 1.2,
          ),
        ),
        child: Text(
          'Add ID back',
          style: GoogleFonts.inter(
            fontSize: 15.5.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFFB89035),
          ),
        ),
      ),
    );
  }

  // Card 4: Take a selfie holding your ID
  Widget _buildSelfieCard() {
    if (_isSelfieAdded) {
      return Container(
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
                  'Selfie holding ID added',
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
            GestureDetector(
              onTap: _handleTakeSelfie,
              child: Text(
                'Retake selfie',
                style: GoogleFonts.inter(
                  fontSize: 13.5.sp,
                  color: const Color(0xFF64748B),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return InkWell(
      onTap: _handleTakeSelfie,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        width: double.infinity,
        height: 52.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: const Color(0xFFE2E8F0),
            width: 1.2,
          ),
        ),
        child: Text(
          'Take a selfie holding your ID',
          style: GoogleFonts.inter(
            fontSize: 15.5.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFFB89035),
          ),
        ),
      ),
    );
  }

  // Card 5: Only admin can see your ID
  Widget _buildAdminPrivacyCard() {
    return Container(
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
            'Only admin can see your ID',
            style: GoogleFonts.inter(
              fontSize: 15.5.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF9A5B13),
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            'Agents never see it. Review is completed within 24 hours.',
            style: GoogleFonts.inter(
              fontSize: 13.5.sp,
              color: const Color(0xFF785B38),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
