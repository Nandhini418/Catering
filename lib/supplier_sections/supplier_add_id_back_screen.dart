import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:catering/constants/app_colors.dart';

class UploadedDocResult {
  final XFile file;
  final bool isUnclear;

  UploadedDocResult({
    required this.file,
    this.isUnclear = false,
  });
}

class SupplierAddIdBackScreen extends StatefulWidget {
  final String title;
  final String subtitle;
  final String guidelineTitle;
  final String guidelineDescription;

  const SupplierAddIdBackScreen({
    super.key,
    this.title = 'Add your ID back',
    this.subtitle = 'Choose a clear, readable image.',
    this.guidelineTitle = 'Photo guidelines',
    this.guidelineDescription =
        'Keep all four corners visible. Avoid glare. Your name and ID details should be readable.',
  });

  @override
  State<SupplierAddIdBackScreen> createState() =>
      _SupplierAddIdBackScreenState();
}

class _SupplierAddIdBackScreenState extends State<SupplierAddIdBackScreen> {
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

  Future<void> _pickImage(ImageSource source) async {
    try {
      setState(() => _isLoading = true);
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );

      if (!mounted) return;
      setState(() => _isLoading = false);

      if (pickedFile != null) {
        final fileSize = await pickedFile.length();
        if (!mounted) return;
        // If file is very small (< 40 KB) or user chose blur simulation, consider unclear
        final bool isUnclear = fileSize < 40000;

        Navigator.pop(
          context,
          UploadedDocResult(file: pickedFile, isUnclear: isUnclear),
        );
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error accessing ${source == ImageSource.camera ? "camera" : "gallery"}: $e',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: Colors.red.shade700,
        ),
      );
    }
  }

  void _simulateUnclearUpload() {
    // Allows instant testing of the unclear image error flow (Screen 3)
    Navigator.pop(
      context,
      UploadedDocResult(
        file: XFile(''),
        isUnclear: true,
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
                    'Ensure all text and numbers on your document are sharply focused.',
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
                      widget.title,
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
                      widget.subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 15.sp,
                        color: const Color(0xFF64748B),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Card 1: Photo guidelines
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
                            widget.guidelineTitle,
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F2D24),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            widget.guidelineDescription,
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              color: const Color(0xFF64748B),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Card 2: Take photo (Open camera)
                    _buildActionCard(
                      title: 'Take photo',
                      subtitle: 'Open camera',
                      onTap: () => _pickImage(ImageSource.camera),
                    ),
                    SizedBox(height: 16.h),

                    // Card 3: Choose from gallery
                    _buildActionCard(
                      title: 'Choose from gallery',
                      subtitle: 'JPG or PNG · up to 10 MB',
                      onTap: () => _pickImage(ImageSource.gallery),
                    ),
                    SizedBox(height: 16.h),

                    // Card 4: Private upload callout
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
                            'Private upload',
                            style: GoogleFonts.inter(
                              fontSize: 15.5.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F766E),
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            'Visible only to you and the admin.',
                            style: GoogleFonts.inter(
                              fontSize: 13.5.sp,
                              color: const Color(0xFF785B38),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 14.h),

                    // Quick test helper for unclear photo error test
                    Center(
                      child: TextButton.icon(
                        onPressed: _simulateUnclearUpload,
                        icon: Icon(
                          Icons.blur_on,
                          size: 16.r,
                          color: const Color(0xFFB45309),
                        ),
                        label: Text(
                          'Test: Simulate unclear photo',
                          style: GoogleFonts.inter(
                            fontSize: 12.5.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFB45309),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),

            // Pinned Bottom Cancel Button
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
                    'Cancel',
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

  Widget _buildActionCard({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: _isLoading ? null : onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
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
              title,
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F2D24),
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              subtitle,
              style: GoogleFonts.inter(
                fontSize: 13.5.sp,
                color: const Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
