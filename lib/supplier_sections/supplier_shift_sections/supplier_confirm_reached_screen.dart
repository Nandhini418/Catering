import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:catering/constants/app_colors.dart';
import 'package:catering/supplier_sections/supplier_shift_sections/widgets/map_view_widget.dart';
import 'package:catering/supplier_sections/supplier_shift_sections/supplier_on_shift_screen.dart';

class SupplierConfirmReachedScreen extends StatefulWidget {
  final String venue;
  final int distanceMeters;

  const SupplierConfirmReachedScreen({
    super.key,
    this.venue = 'Annai Mahal, Peelamedu',
    this.distanceMeters = 40,
  });

  @override
  State<SupplierConfirmReachedScreen> createState() =>
      _SupplierConfirmReachedScreenState();
}

class _SupplierConfirmReachedScreenState
    extends State<SupplierConfirmReachedScreen> {
  bool _photoTaken = false;

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
                    'GPS confirms you are inside the 200 m kitchen arrival boundary.',
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
                      'Confirm you reached',
                      style: GoogleFonts.inter(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0F2D24),
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Map View Widget
                    const MapViewWidget(
                      locationTag: 'PEELAMEDU · VENUE & ARRIVAL AREA',
                      showArrivalRadius: true,
                      isInsideRadius: true,
                    ),
                    SizedBox(height: 16.h),

                    // Venue name
                    Text(
                      widget.venue,
                      style: GoogleFonts.inter(
                        fontSize: 15.5.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F2D24),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Location Verified Box (cream/yellow)
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
                            'Location verified',
                            style: GoogleFonts.inter(
                              fontSize: 14.5.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFB45309),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'You are ${widget.distanceMeters} m from the event place.',
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              color: const Color(0xFF9A5B13),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Take venue photo button
                    SizedBox(
                      width: double.infinity,
                      height: 46.h,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          setState(() {
                            _photoTaken = !_photoTaken;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                _photoTaken
                                    ? 'Venue entrance photo captured!'
                                    : 'Photo removed.',
                                style: GoogleFonts.inter(),
                              ),
                              backgroundColor: const Color(0xFF0E6347),
                            ),
                          );
                        },
                        icon: Icon(
                          _photoTaken ? Icons.check_circle : Icons.camera_alt,
                          size: 18.r,
                          color: _photoTaken
                              ? const Color(0xFF0E6347)
                              : const Color(0xFF0F2D24),
                        ),
                        label: Text(
                          _photoTaken
                              ? 'Venue photo attached ✓'
                              : 'Take a venue photo (optional)',
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: _photoTaken
                                ? const Color(0xFF0E6347)
                                : const Color(0xFF0F2D24),
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: _photoTaken
                                ? const Color(0xFF0E6347)
                                : const Color(0xFFCBD5E1),
                            width: 1.2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    Text(
                      'Reached can be marked only within 200 m. Time is saved for the agent and admin.',
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

            // Bottom Button: Confirm reached
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
                        builder: (context) => SupplierOnShiftScreen(
                          venue: widget.venue,
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
                    'Confirm reached',
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
