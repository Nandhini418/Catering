import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:catering/constants/app_colors.dart';
import 'package:catering/supplier_sections/supplier_add_id_back_screen.dart';
import 'package:catering/supplier_sections/supplier_home_location_screen.dart';
import 'package:catering/supplier_sections/supplier_verify_id_screen.dart';

class SupplierProfileScreen extends StatefulWidget {
  const SupplierProfileScreen({super.key});

  @override
  State<SupplierProfileScreen> createState() => _SupplierProfileScreenState();
}

class _SupplierProfileScreenState extends State<SupplierProfileScreen> {
  final TextEditingController _nameController =
      TextEditingController(text: 'Karthik R');
  final TextEditingController _ageController =
      TextEditingController(text: '22');

  bool _hasPhoto = false;
  String _locationLat = '11.0168';
  String _locationLong = '76.9558';
  String _locationArea = 'Peelamedu, Coimbatore';

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future<void> _handlePhotoUpload() async {
    final result = await Navigator.push<UploadedDocResult>(
      context,
      MaterialPageRoute(
        builder: (context) => const SupplierAddIdBackScreen(
          title: 'Add your photo',
          subtitle: 'Choose a clear portrait photo.',
          guidelineTitle: 'Profile photo guidelines',
          guidelineDescription:
              'Make sure your face is clearly visible, well-lit, and looking straight at the camera.',
        ),
      ),
    );

    if (result != null && mounted) {
      setState(() => _hasPhoto = true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Profile photo added successfully!',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: AppColors.primary,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _handleUpdateLocation() async {
    final result = await Navigator.push<HomeLocationResult>(
      context,
      MaterialPageRoute(
        builder: (context) => SupplierHomeLocationScreen(
          initialArea: _locationArea,
          initialLat: _locationLat,
          initialLong: _locationLong,
        ),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        _locationArea = result.area;
        _locationLat = result.latitude;
        _locationLong = result.longitude;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Home location saved: ${result.area}',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: AppColors.primary,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _handleNext() {
    final name = _nameController.text.trim();
    final age = _ageController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter your full name',
            style: GoogleFonts.inter(),
          ),
        ),
      );
      return;
    }

    if (age.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter your age',
            style: GoogleFonts.inter(),
          ),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SupplierVerifyIdScreen(),
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
                    'Set up your supplier profile to receive local catering shift requests.',
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
                      'SUPPLIER SETUP · 1 OF 2',
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
                      'Create your profile',
                      style: GoogleFonts.inter(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0F2D24),
                        letterSpacing: -0.6,
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Card 1: Add your photo
                    _buildAddPhotoCard(),
                    SizedBox(height: 16.h),

                    // Card 2: Full name
                    _buildInputCard(
                      label: 'Full name',
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                    ),
                    SizedBox(height: 16.h),

                    // Card 3: Age
                    _buildInputCard(
                      label: 'Age',
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // Card 4: Home location captured
                    _buildHomeLocationCard(),
                    SizedBox(height: 16.h),

                    // Card 5: Update location button
                    _buildUpdateLocationButton(),
                    SizedBox(height: 24.h),
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
                  onPressed: _handleNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Next: verify ID',
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

  // Card 1: Add your photo
  Widget _buildAddPhotoCard() {
    return GestureDetector(
      onTap: _handlePhotoUpload,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: _hasPhoto ? AppColors.primary : const Color(0xFFE2E8F0),
            width: 1.2,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _hasPhoto ? 'Photo added' : 'Add your photo',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F2D24),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    _hasPhoto
                        ? 'Tap to replace photo'
                        : 'Agents see it after you accept a job.',
                    style: GoogleFonts.inter(
                      fontSize: 13.5.sp,
                      color: const Color(0xFF64748B),
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
            if (_hasPhoto)
              Container(
                width: 36.r,
                height: 36.r,
                decoration: const BoxDecoration(
                  color: Color(0xFFFEF5E7),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Cards 2 & 3: Text Input card with label inside
  Widget _buildInputCard({
    required String label,
    required TextEditingController controller,
    required TextInputType keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    List<TextInputFormatter>? inputFormatters,
  }) {
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
            label,
            style: GoogleFonts.inter(
              fontSize: 12.5.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF64748B),
            ),
          ),
          SizedBox(height: 4.h),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            textCapitalization: textCapitalization,
            inputFormatters: inputFormatters,
            style: GoogleFonts.inter(
              fontSize: 16.5.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF0F2D24),
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

  // Card 4: Home location captured
  Widget _buildHomeLocationCard() {
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
            'Home location captured',
            style: GoogleFonts.inter(
              fontSize: 15.5.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF9A5B13),
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            'Lat $_locationLat, Long $_locationLong. We use this to alert you about jobs near you.',
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

  // Card 5: Update location button
  Widget _buildUpdateLocationButton() {
    return InkWell(
      onTap: _handleUpdateLocation,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        width: double.infinity,
        height: 52.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: const Color(0xFFCBD5E1),
            width: 1.0,
          ),
        ),
        child: Text(
          'Update location',
          style: GoogleFonts.inter(
            fontSize: 15.5.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0A6C58),
          ),
        ),
      ),
    );
  }
}
