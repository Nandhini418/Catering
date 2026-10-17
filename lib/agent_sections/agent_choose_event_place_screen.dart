import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:catering/constants/app_colors.dart';

class AgentChooseEventPlaceScreen extends StatefulWidget {
  final String currentVenue;

  const AgentChooseEventPlaceScreen({
    super.key,
    this.currentVenue = 'Annai Mahal, Peelamedu',
  });

  @override
  State<AgentChooseEventPlaceScreen> createState() =>
      _AgentChooseEventPlaceScreenState();
}

class _AgentChooseEventPlaceScreenState
    extends State<AgentChooseEventPlaceScreen> {
  late TextEditingController _searchController;
  late String _selectedVenue;
  String _selectedArea = 'Peelamedu, Coimbatore';

  @override
  void initState() {
    super.initState();
    _selectedVenue = widget.currentVenue;
    _searchController = TextEditingController(text: _selectedVenue);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _confirmSelection() {
    Navigator.pop(context, _selectedVenue);
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
                    'Select or search for the event venue or wedding hall.',
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

                    // Category Tag
                    Text(
                      'AGENT',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                        letterSpacing: 0.8,
                      ),
                    ),
                    SizedBox(height: 8.h),

                    // Screen Title
                    Text(
                      'Choose event place',
                      style: GoogleFonts.inter(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0F2D24),
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Search field
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(
                          color: const Color(0xFFE2E8F0),
                          width: 1.2,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Search for venue or area',
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          TextFormField(
                            controller: _searchController,
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0F2D24),
                            ),
                            decoration: const InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                            onChanged: (val) {
                              setState(() {
                                _selectedVenue = val;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 18.h),

                    // Illustrative Map / Venue Arrival Area Container
                    Container(
                      width: double.infinity,
                      height: 220.h,
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0FDF4),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: const Color(0xFFBBF7D0),
                          width: 1.2,
                        ),
                      ),
                      child: Stack(
                        children: [
                          // Header label
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'PEELAMEDU · VENUE & ARRIVAL AREA',
                              style: GoogleFonts.inter(
                                fontSize: 10.5.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF166534),
                                letterSpacing: 0.6,
                              ),
                            ),
                          ),

                          // Center Graphic: Radar / Route Illustration
                          Center(
                            child: SizedBox(
                              width: 120.r,
                              height: 120.r,
                              child: CustomPaint(
                                painter: _MapRoutePainter(),
                              ),
                            ),
                          ),

                          // Small location pin dot
                          Positioned(
                            left: 14.w,
                            bottom: 24.h,
                            child: Container(
                              width: 10.r,
                              height: 10.r,
                              decoration: const BoxDecoration(
                                color: Color(0xFF16A34A),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),

                          // Bottom note
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 20.w),
                              child: Text(
                                'Illustrative route - not live GPS',
                                style: GoogleFonts.inter(
                                  fontSize: 11.5.sp,
                                  color: const Color(0xFF166534),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 18.h),

                    // Venue Details Card
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
                          Row(
                            children: [
                              Text(
                                _selectedVenue.split(',').first.trim(),
                                style: GoogleFonts.inter(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F2D24),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 3.h,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDCFCE7),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: Text(
                                  'Selected',
                                  style: GoogleFonts.inter(
                                    fontSize: 11.5.sp,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF15803D),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            _selectedArea,
                            style: GoogleFonts.inter(
                              fontSize: 13.5.sp,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            'Move the pin to the event entrance before confirming.',
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              color: const Color(0xFF64748B),
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 18.h),

                    // Use current location button
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selectedVenue = 'Peelamedu Junction, Coimbatore';
                          _selectedArea = 'Coimbatore, Tamil Nadu';
                          _searchController.text = _selectedVenue;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Current GPS location fetched',
                              style: GoogleFonts.inter(),
                            ),
                            backgroundColor: AppColors.primary,
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(14.r),
                      child: Container(
                        width: double.infinity,
                        height: 50.h,
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
                          'Use current location',
                          style: GoogleFonts.inter(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0A6C58),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),

            // Bottom Pinned: Use this location
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
                  onPressed: _confirmSelection,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Use this location',
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

class _MapRoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final strokePaint = Paint()
      ..color = const Color(0xFF16A34A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2.2;

    // Outer circle
    canvas.drawCircle(center, radius, strokePaint);

    // Cross lines / route
    canvas.drawLine(
      Offset(center.dx, center.dy - radius),
      Offset(center.dx, center.dy),
      strokePaint,
    );
    canvas.drawLine(
      Offset(center.dx, center.dy),
      Offset(center.dx - radius, center.dy),
      strokePaint,
    );

    // Pin indicator circle on the top
    final pinPaint = Paint()
      ..color = const Color(0xFF16A34A)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(center.dx, center.dy - radius), 5.r, pinPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
