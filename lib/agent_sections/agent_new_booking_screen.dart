import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:catering/constants/app_colors.dart';
import 'package:catering/agent_sections/agent_choose_event_place_screen.dart';
import 'package:catering/agent_sections/agent_event_details_screen.dart';

class AgentNewBookingScreen extends StatefulWidget {
  const AgentNewBookingScreen({super.key});

  @override
  State<AgentNewBookingScreen> createState() => _AgentNewBookingScreenState();
}

class _AgentNewBookingScreenState extends State<AgentNewBookingScreen> {
  String _eventPlace = 'Annai Mahal, Peelamedu';
  int _selectedShifts = 1;
  final int _ratePerShift = 400;
  int _boysNeeded = 10;
  String _selectedDistance = 'Below 10 km';

  final List<Map<String, dynamic>> _shiftOptions = [
    {'shifts': 1, 'price': 400, 'label': '1 shift\n₹400'},
    {'shifts': 2, 'price': 800, 'label': '2 shifts\n₹800'},
    {'shifts': 3, 'price': 1200, 'label': '3 shifts\n₹1,200'},
  ];

  final List<String> _distanceOptions = [
    'Below 10 km',
    '10 to 20 km',
    '20 to 50 km',
    'More than 50 km',
  ];

  int get _totalAmount => _boysNeeded * _selectedShifts * _ratePerShift;

  Future<void> _chooseEventPlace() async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => AgentChooseEventPlaceScreen(
          currentVenue: _eventPlace,
        ),
      ),
    );

    if (result != null && result.isNotEmpty && mounted) {
      setState(() {
        _eventPlace = result;
      });
    }
  }

  void _goToEventDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AgentEventDetailsScreen(
          venue: _eventPlace,
          shifts: _selectedShifts,
          boysCount: _boysNeeded,
          distance: _selectedDistance,
          totalAmount: _totalAmount,
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
                    'Step 1 of 2: Enter location, shifts, required boys count and search radius.',
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

                    // Step Tag
                    Text(
                      'AGENT · STEP 1 OF 2',
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
                      'New booking',
                      style: GoogleFonts.inter(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0F2D24),
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Event place card
                    GestureDetector(
                      onTap: _chooseEventPlace,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 14.h,
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
                              'Event place',
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    _eventPlace,
                                    style: GoogleFonts.inter(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF0F2D24),
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right,
                                  color: const Color(0xFF64748B),
                                  size: 20.r,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 22.h),

                    // Number of shifts
                    Text(
                      'Number of shifts',
                      style: GoogleFonts.inter(
                        fontSize: 14.5.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0F2D24),
                      ),
                    ),
                    SizedBox(height: 10.h),

                    Row(
                      children: _shiftOptions.map((opt) {
                        final shifts = opt['shifts'] as int;
                        final isSelected = _selectedShifts == shifts;
                        final label = opt['label'] as String;

                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: shifts < 3 ? 10.w : 0,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedShifts = shifts;
                                });
                              },
                              child: Container(
                                height: 64.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFFFFF9ED)
                                      : AppColors.white,
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.primary
                                        : const Color(0xFFE2E8F0),
                                    width: isSelected ? 1.5 : 1.2,
                                  ),
                                ),
                                child: Text(
                                  label,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                    fontSize: 13.5.sp,
                                    fontWeight: isSelected
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                    color: isSelected
                                        ? const Color(0xFFB45309)
                                        : const Color(0xFF0F2D24),
                                    height: 1.3,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 22.h),

                    // Boys needed Counter
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Boys needed',
                            style: GoogleFonts.inter(
                              fontSize: 14.5.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0F2D24),
                            ),
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (_boysNeeded > 1) {
                                    setState(() => _boysNeeded--);
                                  }
                                },
                                child: Container(
                                  width: 32.r,
                                  height: 32.r,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF1F5F9),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Text(
                                    '–',
                                    style: GoogleFonts.inter(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF0F2D24),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 14.w),
                                child: Text(
                                  '$_boysNeeded',
                                  style: GoogleFonts.inter(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF0F2D24),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() => _boysNeeded++);
                                },
                                child: Container(
                                  width: 32.r,
                                  height: 32.r,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF1F5F9),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Text(
                                    '+',
                                    style: GoogleFonts.inter(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF0F2D24),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 22.h),

                    // Search distance for boys
                    Text(
                      'Search distance for boys',
                      style: GoogleFonts.inter(
                        fontSize: 14.5.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0F2D24),
                      ),
                    ),
                    SizedBox(height: 10.h),

                    // 2x2 distance buttons
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _distanceOptions.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 2.8,
                      ),
                      itemBuilder: (context, index) {
                        final dist = _distanceOptions[index];
                        final isSelected = _selectedDistance == dist;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedDistance = dist;
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFFFFF9ED)
                                  : AppColors.white,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primary
                                    : const Color(0xFFE2E8F0),
                                width: isSelected ? 1.5 : 1.2,
                              ),
                            ),
                            child: Text(
                              dist,
                              style: GoogleFonts.inter(
                                fontSize: 13.5.sp,
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                color: isSelected
                                    ? const Color(0xFFB45309)
                                    : const Color(0xFF0F2D24),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 22.h),

                    // Total Calculation Summary Card
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
                            '$_boysNeeded boys × $_selectedShifts shift × ₹$_ratePerShift',
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFB45309),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Total booking amount: ₹$_totalAmount',
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

            // Bottom Pinned: Next: event details
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
                  onPressed: _goToEventDetails,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Next: event details',
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
