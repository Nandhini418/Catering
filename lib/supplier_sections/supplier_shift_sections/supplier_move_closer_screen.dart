import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:catering/constants/app_colors.dart';
import 'package:catering/supplier_sections/supplier_shift_sections/widgets/map_view_widget.dart';
import 'package:catering/supplier_sections/supplier_shift_sections/supplier_confirm_reached_screen.dart';

class SupplierMoveCloserScreen extends StatefulWidget {
  final String venue;
  final String area;

  const SupplierMoveCloserScreen({
    super.key,
    this.venue = 'Annai Mahal',
    this.area = 'Peelamedu',
  });

  @override
  State<SupplierMoveCloserScreen> createState() =>
      _SupplierMoveCloserScreenState();
}

class _SupplierMoveCloserScreenState extends State<SupplierMoveCloserScreen> {
  bool _isRefreshing = false;

  void _refreshLocation() async {
    setState(() => _isRefreshing = true);
    await Future.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    setState(() => _isRefreshing = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Location updated! You are now 40 m from ${widget.venue}.',
          style: GoogleFonts.inter(),
        ),
        backgroundColor: const Color(0xFF0E6347),
      ),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SupplierConfirmReachedScreen(
          venue: '${widget.venue}, ${widget.area}',
          distanceMeters: 40,
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
                    'Arrival requires being within 200 m radius of the venue.',
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
                      'Move closer to arrive',
                      style: GoogleFonts.inter(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0F2D24),
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Map View Widget showing outside arrival radius
                    MapViewWidget(
                      locationTag:
                          '${widget.area.toUpperCase()} · VENUE & ARRIVAL AREA',
                      showArrivalRadius: true,
                      isInsideRadius: false,
                    ),
                    SizedBox(height: 16.h),

                    // Soft red warning container
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
                            'Outside the arrival area',
                            style: GoogleFonts.inter(
                              fontSize: 14.5.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFDC2626),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'You must be within 200 m of ${widget.venue} to confirm arrival.',
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              color: const Color(0xFF991B1B),
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Open directions in Google Maps button
                    SizedBox(
                      width: double.infinity,
                      height: 46.h,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Navigating to ${widget.venue} in Google Maps...',
                                style: GoogleFonts.inter(),
                              ),
                              backgroundColor: AppColors.primary,
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.directions,
                          size: 18.r,
                          color: const Color(0xFF0F2D24),
                        ),
                        label: Text(
                          'Open directions in Google Maps',
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F2D24),
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Color(0xFFCBD5E1),
                            width: 1.2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 14.h),

                    // Helpful hint text
                    Text(
                      'If GPS is inaccurate, refresh your location or contact help.',
                      style: GoogleFonts.inter(
                        fontSize: 12.5.sp,
                        color: const Color(0xFF94A3B8),
                        height: 1.35,
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),

            // Bottom Buttons
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
                  // Disabled Confirm reached button
                  SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: ElevatedButton(
                      onPressed: null, // Disabled until inside 200m
                      style: ElevatedButton.styleFrom(
                        disabledBackgroundColor: const Color(0xFFE2E8F0),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'Confirm reached',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF94A3B8),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // Refresh location button
                  SizedBox(
                    width: double.infinity,
                    height: 48.h,
                    child: OutlinedButton(
                      onPressed: _isRefreshing ? null : _refreshLocation,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Color(0xFFCBD5E1),
                          width: 1.2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: _isRefreshing
                          ? SizedBox(
                              width: 20.r,
                              height: 20.r,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.primary),
                              ),
                            )
                          : Text(
                              'Refresh location',
                              style: GoogleFonts.inter(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF0F2D24),
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
}
