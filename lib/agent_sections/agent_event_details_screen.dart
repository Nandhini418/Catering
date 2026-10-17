import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:catering/constants/app_colors.dart';
import 'package:catering/agent_sections/agent_date_reporting_time_screen.dart';
import 'package:catering/agent_sections/agent_finding_team_screen.dart';

class AgentEventDetailsScreen extends StatefulWidget {
  final String venue;
  final int shifts;
  final int boysCount;
  final String distance;
  final int totalAmount;

  const AgentEventDetailsScreen({
    super.key,
    this.venue = 'Annai Mahal, Peelamedu',
    this.shifts = 1,
    this.boysCount = 10,
    this.distance = 'Below 10 km',
    this.totalAmount = 4000,
  });

  @override
  State<AgentEventDetailsScreen> createState() =>
      _AgentEventDetailsScreenState();
}

class _AgentEventDetailsScreenState extends State<AgentEventDetailsScreen> {
  String _date = 'Sat, 11 Oct';
  String _time = '6:00 AM';

  late TextEditingController _dressController;
  late TextEditingController _instructionsController;

  String _selectedUniform = 'Own uniform';
  bool _foodProvided = true;
  bool _transportProvided = false;

  @override
  void initState() {
    super.initState();
    _dressController = TextEditingController(text: 'White shirt, black pant');
    _instructionsController = TextEditingController(
      text:
          'Report to the kitchen gate. Wear clean footwear. Ask for Murugan at the entrance.',
    );
  }

  @override
  void dispose() {
    _dressController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  Future<void> _pickDateTime() async {
    final result = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (context) => AgentDateReportingTimeScreen(
          initialDate: _date,
          initialTime: _time,
        ),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        if (result['date'] != null) _date = result['date']!;
        if (result['time'] != null) _time = result['time']!;
      });
    }
  }

  void _sendRequest() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AgentFindingTeamScreen(
          venue: widget.venue,
          area: 'Peelamedu, Coimbatore',
          dateTime: '$_date · $_time',
          boysCount: widget.boysCount,
          shifts: widget.shifts,
          totalAmount: widget.totalAmount,
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
                    'Step 2 of 2: Set dress code, meal provision, and staff instructions.',
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

                    // Tag
                    Text(
                      'AGENT · STEP 2 OF 2',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                        letterSpacing: 0.8,
                      ),
                    ),
                    SizedBox(height: 8.h),

                    // Title
                    Text(
                      'Event details',
                      style: GoogleFonts.inter(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0F2D24),
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Date & Time Chips Row
                    Row(
                      children: [
                        // Date Chip
                        GestureDetector(
                          onTap: _pickDateTime,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24.w,
                              vertical: 12.h,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF9ED),
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: AppColors.primary,
                                width: 1.2,
                              ),
                            ),
                            child: Text(
                              _date,
                              style: GoogleFonts.inter(
                                fontSize: 13.5.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFB45309),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),

                        // Time Chip
                        GestureDetector(
                          onTap: _pickDateTime,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24.w,
                              vertical: 12.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: const Color(0xFFE2E8F0),
                                width: 1.2,
                              ),
                            ),
                            child: Text(
                              _time,
                              style: GoogleFonts.inter(
                                fontSize: 13.5.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF0F2D24),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 18.h),

                    // Dress Input Card
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
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
                            'Dress',
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          TextFormField(
                            controller: _dressController,
                            style: GoogleFonts.inter(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
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

                    // Uniform Row
                    Row(
                      children: [
                        // Own uniform
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedUniform = 'Own uniform';
                              });
                            },
                            child: Container(
                              height: 48.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: _selectedUniform == 'Own uniform'
                                    ? const Color(0xFFFFF9ED)
                                    : AppColors.white,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: _selectedUniform == 'Own uniform'
                                      ? AppColors.primary
                                      : const Color(0xFFE2E8F0),
                                  width: _selectedUniform == 'Own uniform'
                                      ? 1.5
                                      : 1.2,
                                ),
                              ),
                              child: Text(
                                'Own uniform',
                                style: GoogleFonts.inter(
                                  fontSize: 13.5.sp,
                                  fontWeight:
                                      _selectedUniform == 'Own uniform'
                                          ? FontWeight.w700
                                          : FontWeight.w500,
                                  color: _selectedUniform == 'Own uniform'
                                      ? const Color(0xFFB45309)
                                      : const Color(0xFF0F2D24),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),

                        // Uniform provided
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedUniform = 'Uniform provided';
                              });
                            },
                            child: Container(
                              height: 48.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: _selectedUniform == 'Uniform provided'
                                    ? const Color(0xFFFFF9ED)
                                    : AppColors.white,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: _selectedUniform == 'Uniform provided'
                                      ? AppColors.primary
                                      : const Color(0xFFE2E8F0),
                                  width: _selectedUniform == 'Uniform provided'
                                      ? 1.5
                                      : 1.2,
                                ),
                              ),
                              child: Text(
                                'Uniform provided',
                                style: GoogleFonts.inter(
                                  fontSize: 13.5.sp,
                                  fontWeight:
                                      _selectedUniform == 'Uniform provided'
                                          ? FontWeight.w700
                                          : FontWeight.w500,
                                  color: _selectedUniform == 'Uniform provided'
                                      ? const Color(0xFFB45309)
                                      : const Color(0xFF0F2D24),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 18.h),

                    // Checkbox 1: Food provided for boys
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _foodProvided = !_foodProvided;
                        });
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 22.r,
                            height: 22.r,
                            decoration: BoxDecoration(
                              color: _foodProvided
                                  ? const Color(0xFF0E6347)
                                  : AppColors.white,
                              borderRadius: BorderRadius.circular(5.r),
                              border: Border.all(
                                color: _foodProvided
                                    ? const Color(0xFF0E6347)
                                    : const Color(0xFFCBD5E1),
                                width: 1.5,
                              ),
                            ),
                            child: _foodProvided
                                ? Icon(
                                    Icons.check,
                                    size: 16.r,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            'Food provided for boys',
                            style: GoogleFonts.inter(
                              fontSize: 14.5.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0F2D24),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 14.h),

                    // Checkbox 2: Transport provided
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _transportProvided = !_transportProvided;
                        });
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 22.r,
                            height: 22.r,
                            decoration: BoxDecoration(
                              color: _transportProvided
                                  ? const Color(0xFF0E6347)
                                  : AppColors.white,
                              borderRadius: BorderRadius.circular(5.r),
                              border: Border.all(
                                color: _transportProvided
                                    ? const Color(0xFF0E6347)
                                    : const Color(0xFFCBD5E1),
                                width: 1.5,
                              ),
                            ),
                            child: _transportProvided
                                ? Icon(
                                    Icons.check,
                                    size: 16.r,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            'Transport provided',
                            style: GoogleFonts.inter(
                              fontSize: 14.5.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0F2D24),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 18.h),

                    // Instructions for boys
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
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
                            'Instructions for boys',
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          TextFormField(
                            controller: _instructionsController,
                            maxLines: 3,
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF0F2D24),
                              height: 1.4,
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
                    SizedBox(height: 18.h),

                    // Total Summary Card
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(18.r),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF9ED),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.boysCount} boys · ${widget.shifts} shift · ${widget.distance.toLowerCase()}',
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFB45309),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Total: ₹${widget.totalAmount}',
                            style: GoogleFonts.inter(
                              fontSize: 13.5.sp,
                              color: const Color(0xFF9A5B13),
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

            // Bottom Pinned: Send request to boys
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
                  onPressed: _sendRequest,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Send request to boys',
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
