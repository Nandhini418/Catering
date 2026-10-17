import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:catering/constants/app_colors.dart';
import 'package:catering/agent_sections/agent_event_details_screen.dart';

class BookFavouritesFirstScreen extends StatefulWidget {
  final String initialVenue;
  final int initialBoysCount;
  final int initialShifts;

  const BookFavouritesFirstScreen({
    super.key,
    this.initialVenue = 'Annai Mahal, Peelamedu',
    this.initialBoysCount = 10,
    this.initialShifts = 1,
  });

  @override
  State<BookFavouritesFirstScreen> createState() =>
      _BookFavouritesFirstScreenState();
}

class _BookFavouritesFirstScreenState extends State<BookFavouritesFirstScreen> {
  late TextEditingController _venueController;
  late int _selectedShifts;
  late int _boysNeeded;
  String _searchDistance = 'Below 10 km';

  final int _ratePerShiftPerBoy = 400;

  @override
  void initState() {
    super.initState();
    _venueController = TextEditingController(text: widget.initialVenue);
    _selectedShifts = widget.initialShifts;
    _boysNeeded = widget.initialBoysCount;
  }

  @override
  void dispose() {
    _venueController.dispose();
    super.dispose();
  }

  int get _totalAmount => _boysNeeded * _selectedShifts * _ratePerShiftPerBoy;

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
                    'Favourites are given an exclusive 15-minute head-start to accept your shift.',
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

                    // AGENT Tag
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

                    // Title
                    Text(
                      'Book favourites first',
                      style: GoogleFonts.inter(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0F2D24),
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(height: 6.h),

                    // Subtitle
                    Text(
                      'Start with the boys you already trust.',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Priority Alerts Selected Banner (soft yellow/cream)
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
                            'Priority alerts selected',
                            style: GoogleFonts.inter(
                              fontSize: 14.5.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFB45309),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Karthik R, Arun S and Suresh P receive the alert before other nearby boys.',
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              color: const Color(0xFF9A5B13),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Event place input
                    Text(
                      'Event place',
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: const Color(0xFFCBD5E1),
                          width: 1.2,
                        ),
                      ),
                      child: TextField(
                        controller: _venueController,
                        style: GoogleFonts.inter(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0F2D24),
                        ),
                        decoration: InputDecoration(
                          hintText: 'Enter hall or venue name',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 14.h,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Shift selector
                    Row(
                      children: [
                        _buildShiftChip(1, '1 shift', '₹400'),
                        SizedBox(width: 8.w),
                        _buildShiftChip(2, '2 shifts', '₹800'),
                        SizedBox(width: 8.w),
                        _buildShiftChip(3, '3 shifts', '₹1,200'),
                      ],
                    ),
                    SizedBox(height: 20.h),

                    // Boys needed row
                    Row(
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
                            _buildStepperButton(
                              icon: Icons.remove,
                              onTap: () {
                                if (_boysNeeded > 1) {
                                  setState(() => _boysNeeded--);
                                }
                              },
                            ),
                            SizedBox(width: 14.w),
                            Text(
                              '$_boysNeeded',
                              style: GoogleFonts.inter(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F2D24),
                              ),
                            ),
                            SizedBox(width: 14.w),
                            _buildStepperButton(
                              icon: Icons.add,
                              onTap: () {
                                setState(() => _boysNeeded++);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 18.h),

                    // Search distance row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Search distance',
                          style: GoogleFonts.inter(
                            fontSize: 14.5.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F2D24),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _searchDistance =
                                  _searchDistance == 'Below 10 km'
                                      ? 'Below 20 km'
                                      : 'Below 10 km';
                            });
                          },
                          child: Text(
                            _searchDistance,
                            style: GoogleFonts.inter(
                              fontSize: 14.5.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0F766E),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 22.h),

                    // Total booking amount calculation card (soft cream/gold)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20.r),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF9ED),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: const Color(0xFFFDE68A),
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total booking amount',
                            style: GoogleFonts.inter(
                              fontSize: 13.5.sp,
                              color: const Color(0xFF64748B),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            '₹${_totalAmount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                            style: GoogleFonts.inter(
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFFB45309),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            '$_boysNeeded boys × $_selectedShifts ${_selectedShifts == 1 ? 'shift' : 'shifts'} · favourites first',
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              color: const Color(0xFF9A5B13),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 14.h),

                    // Note on priority
                    Text(
                      'Your favourites get priority, not a guaranteed place. Remaining places are offered to nearby boys.',
                      style: GoogleFonts.inter(
                        fontSize: 12.5.sp,
                        color: const Color(0xFF94A3B8),
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),

            // Bottom Primary Button: Next: event details
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AgentEventDetailsScreen(
                          venue: _venueController.text.trim().isEmpty
                              ? 'Annai Mahal, Peelamedu'
                              : _venueController.text.trim(),
                          shifts: _selectedShifts,
                          boysCount: _boysNeeded,
                          distance: _searchDistance,
                          totalAmount: _totalAmount,
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
                    'Next: event details',
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

  Widget _buildShiftChip(int shifts, String label, String price) {
    final bool isSelected = _selectedShifts == shifts;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedShifts = shifts;
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFFFF9ED) : AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isSelected ? AppColors.primary : const Color(0xFFCBD5E1),
              width: isSelected ? 1.5 : 1.0,
            ),
          ),
          child: Column(
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected
                      ? const Color(0xFF9A5B13)
                      : const Color(0xFF0F2D24),
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                price,
                style: GoogleFonts.inter(
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w700,
                  color: isSelected
                      ? const Color(0xFFB45309)
                      : const Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepperButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32.r,
        height: 32.r,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(icon, size: 18.r, color: const Color(0xFF0F2D24)),
      ),
    );
  }
}
