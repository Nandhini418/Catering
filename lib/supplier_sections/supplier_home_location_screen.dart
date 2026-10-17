import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:catering/constants/app_colors.dart';

class HomeLocationResult {
  final String area;
  final String latitude;
  final String longitude;

  HomeLocationResult({
    required this.area,
    required this.latitude,
    required this.longitude,
  });
}

class SupplierHomeLocationScreen extends StatefulWidget {
  final String initialArea;
  final String initialLat;
  final String initialLong;

  const SupplierHomeLocationScreen({
    super.key,
    this.initialArea = 'Peelamedu, Coimbatore',
    this.initialLat = '11.0168',
    this.initialLong = '76.9558',
  });

  @override
  State<SupplierHomeLocationScreen> createState() =>
      _SupplierHomeLocationScreenState();
}

class _SupplierHomeLocationScreenState
    extends State<SupplierHomeLocationScreen> {
  late final TextEditingController _areaController;
  late String _latitude;
  late String _longitude;

  @override
  void initState() {
    super.initState();
    _areaController = TextEditingController(text: widget.initialArea);
    _latitude = widget.initialLat;
    _longitude = widget.initialLong;
  }

  @override
  void dispose() {
    _areaController.dispose();
    super.dispose();
  }

  void _handleUseCurrentLocation() {
    setState(() {
      _latitude = '11.0168';
      _longitude = '76.9558';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'GPS coordinates updated: Lat $_latitude · Long $_longitude',
          style: GoogleFonts.inter(),
        ),
        backgroundColor: const Color(0xFF0F766E),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handleSaveLocation() {
    final areaText = _areaController.text.trim();
    if (areaText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter your area',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: const Color(0xFFB45309),
        ),
      );
      return;
    }

    Navigator.pop(
      context,
      HomeLocationResult(
        area: areaText,
        latitude: _latitude,
        longitude: _longitude,
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
                    'Setting your home location enables nearby shift alerts.',
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
                        color: const Color(0xFFB45309),
                        letterSpacing: 0.6,
                      ),
                    ),
                    SizedBox(height: 8.h),

                    // Main Title
                    Text(
                      'Your home location',
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
                      'Used for nearby job alerts. Not shared with agents.',
                      style: GoogleFonts.inter(
                        fontSize: 15.sp,
                        color: const Color(0xFF64748B),
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 22.h),

                    // Map Container
                    _buildMapCard(),
                    SizedBox(height: 16.h),

                    // Card 1: Area
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
                            'Area',
                            style: GoogleFonts.inter(
                              fontSize: 12.5.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          TextFormField(
                            controller: _areaController,
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
                    ),
                    SizedBox(height: 16.h),

                    // Card 2: Captured coordinates
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Captured coordinates',
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F2D24),
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            'Lat $_latitude · Long $_longitude',
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Card 3: Use current location button
                    InkWell(
                      onTap: _handleUseCurrentLocation,
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
                          'Use current location',
                          style: GoogleFonts.inter(
                            fontSize: 15.5.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFB89035),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Card 4: Admin-only location notice box
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
                            'Admin-only location',
                            style: GoogleFonts.inter(
                              fontSize: 15.5.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFB45309),
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            'Agents see your area, not your precise home location.',
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

            // Pinned Bottom Button: Save home location
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
                  onPressed: _handleSaveLocation,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Save home location',
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

  Widget _buildMapCard() {
    return Container(
      width: double.infinity,
      height: 220.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Map Image Asset
            Image.asset(
              'assets/images/map.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: const Color(0xFFE2E8F0),
                  child: const Center(
                    child: Icon(Icons.map, size: 48, color: Colors.grey),
                  ),
                );
              },
            ),

            // Top-left text overlay: PEELAMEDU · VENUE & ARRIVAL AREA
            Positioned(
              top: 14.h,
              left: 14.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.88),
                  borderRadius: BorderRadius.circular(8.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  'PEELAMEDU · VENUE & ARRIVAL AREA',
                  style: GoogleFonts.inter(
                    fontSize: 11.5.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F2D24),
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),

            // Bottom-left text overlay: Illustrative route · not live GPS
            Positioned(
              bottom: 14.h,
              left: 14.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.88),
                  borderRadius: BorderRadius.circular(8.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  'Illustrative route · not live GPS',
                  style: GoogleFonts.inter(
                    fontSize: 11.5.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0F2D24),
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
