import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:catering/constants/app_colors.dart';
import 'package:catering/supplier_sections/supplier_shift_sections/widgets/map_view_widget.dart';
import 'package:catering/supplier_sections/supplier_shift_sections/supplier_confirm_reached_screen.dart';
import 'package:catering/supplier_sections/supplier_shift_sections/supplier_move_closer_screen.dart';

class SupplierGoToEventScreen extends StatefulWidget {
  final String venue;
  final String area;
  final String dateTime;

  const SupplierGoToEventScreen({
    super.key,
    this.venue = 'Annai Mahal, Peelamedu',
    this.area = 'Peelamedu',
    this.dateTime = '6:00 AM',
  });

  @override
  State<SupplierGoToEventScreen> createState() =>
      _SupplierGoToEventScreenState();
}

class _SupplierGoToEventScreenState extends State<SupplierGoToEventScreen> {
  bool _isNearVenue = true; // simulation toggle: < 200m vs > 200m

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
                    'GPS confirms arrival automatically once within 200 m of the kitchen entrance.',
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
                      'Go to the event',
                      style: GoogleFonts.inter(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0F2D24),
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Map View Widget
                    MapViewWidget(
                      locationTag:
                          '${widget.area.toUpperCase()} · VENUE & ARRIVAL AREA',
                      showArrivalRadius: true,
                      isInsideRadius: _isNearVenue,
                    ),
                    SizedBox(height: 16.h),

                    // Venue and Distance Info
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.venue,
                          style: GoogleFonts.inter(
                            fontSize: 15.5.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F2D24),
                          ),
                        ),
                        Text(
                          widget.dateTime,
                          style: GoogleFonts.inter(
                            fontSize: 14.5.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFB45309),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '4.2 km · about 15 min',
                      style: GoogleFonts.inter(
                        fontSize: 13.5.sp,
                        color: const Color(0xFF64748B),
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
                                'Opening turn-by-turn navigation in Google Maps...',
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
                    SizedBox(height: 20.h),

                    // Status Checklist Card
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
                        children: [
                          _buildChecklistRow(
                            title: 'Job accepted',
                            statusWidget: const Icon(
                              Icons.check_circle,
                              color: Color(0xFF0E6347),
                              size: 20,
                            ),
                          ),
                          SizedBox(height: 14.h),
                          const Divider(color: Color(0xFFF1F5F9), height: 1),
                          SizedBox(height: 14.h),
                          _buildChecklistRow(
                            title: 'On the way',
                            statusWidget: const Icon(
                              Icons.check_circle,
                              color: Color(0xFF0E6347),
                              size: 20,
                            ),
                          ),
                          SizedBox(height: 14.h),
                          const Divider(color: Color(0xFFF1F5F9), height: 1),
                          SizedBox(height: 14.h),
                          _buildChecklistRow(
                            title: 'Reached the place',
                            statusWidget: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 3.h,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFEF3C7),
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              child: Text(
                                'Next',
                                style: GoogleFonts.inter(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFFB45309),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 14.h),
                          const Divider(color: Color(0xFFF1F5F9), height: 1),
                          SizedBox(height: 14.h),
                          _buildChecklistRow(
                            title: 'Shift completed',
                            statusWidget: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 3.h,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              child: Text(
                                'Pending',
                                style: GoogleFonts.inter(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF94A3B8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 18.h),

                    // Test GPS Toggle: Inside 200m vs Outside 200m
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _isNearVenue
                                ? 'GPS: Inside 200 m (40 m)'
                                : 'GPS: Outside 200 m (4.2 km)',
                            style: GoogleFonts.inter(
                              fontSize: 12.5.sp,
                              fontWeight: FontWeight.w600,
                              color: _isNearVenue
                                  ? const Color(0xFF0E6347)
                                  : const Color(0xFFB91C1C),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() => _isNearVenue = !_isNearVenue);
                            },
                            child: Text(
                              'Switch distance',
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                              ),
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

            // Bottom Button: I have reached
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
                    if (_isNearVenue) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SupplierConfirmReachedScreen(
                            venue: widget.venue,
                            distanceMeters: 40,
                          ),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SupplierMoveCloserScreen(
                            venue: widget.venue,
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'I have reached',
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

  Widget _buildChecklistRow({
    required String title,
    required Widget statusWidget,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 14.5.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0F2D24),
          ),
        ),
        statusWidget,
      ],
    );
  }
}
