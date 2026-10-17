import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:catering/constants/app_colors.dart';
import 'package:catering/widgets/supplier_bottom_nav.dart';
import 'package:catering/supplier_sections/supplier_shift_sections/supplier_new_job_screen.dart';
import 'package:catering/supplier_sections/supplier_shift_sections/supplier_booked_screen.dart';
import 'package:catering/supplier_sections/supplier_shift_sections/supplier_shift_completed_screen.dart';
import 'package:catering/supplier_sections/supplier_home_location_screen.dart';

enum JobsSubTab { nearby, upcoming, completed }

class SupplierJobsScreen extends StatefulWidget {
  final JobsSubTab initialSubTab;
  final ValueChanged<SupplierBottomTab>? onTabChanged;

  const SupplierJobsScreen({
    super.key,
    this.initialSubTab = JobsSubTab.nearby,
    this.onTabChanged,
  });

  @override
  State<SupplierJobsScreen> createState() => _SupplierJobsScreenState();
}

class _SupplierJobsScreenState extends State<SupplierJobsScreen> {
  late JobsSubTab _selectedSubTab;
  bool _showEmptyNearby = false;
  bool _jobAlertsEnabled = true;

  @override
  void initState() {
    super.initState();
    _selectedSubTab = widget.initialSubTab;
  }

  String get _title {
    switch (_selectedSubTab) {
      case JobsSubTab.nearby:
        return 'Nearby jobs';
      case JobsSubTab.upcoming:
        return 'Your upcoming jobs';
      case JobsSubTab.completed:
        return 'Completed shifts';
    }
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
          onPressed: () {
            if (widget.onTabChanged != null) {
              widget.onTabChanged!(SupplierBottomTab.home);
            } else {
              Navigator.pop(context);
            }
          },
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
                    'Explore shifts in your service area.',
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

                    // Top Category / Location Tag
                    Text(
                      'SUPPLIER / COIMBATORE',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFB45309),
                        letterSpacing: 0.6,
                      ),
                    ),
                    SizedBox(height: 8.h),

                    // Title
                    Text(
                      _title,
                      style: GoogleFonts.inter(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0F2D24),
                        letterSpacing: -0.6,
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // 3-Option Segmented Tab Bar (Nearby, Upcoming, Completed)
                    _buildSegmentedTabBar(),
                    SizedBox(height: 22.h),

                    // Content for Selected Sub-Tab
                    if (_selectedSubTab == JobsSubTab.nearby)
                      _buildNearbyContent(),
                    if (_selectedSubTab == JobsSubTab.upcoming)
                      _buildUpcomingContent(),
                    if (_selectedSubTab == JobsSubTab.completed)
                      _buildCompletedContent(),

                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),

            // Supplier Bottom Nav
            if (widget.onTabChanged != null)
              SupplierBottomNav(
                currentTab: SupplierBottomTab.jobs,
                onTabSelected: widget.onTabChanged!,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSegmentedTabBar() {
    return Row(
      children: [
        _buildPillTab(
          tab: JobsSubTab.nearby,
          label: 'Nearby',
        ),
        SizedBox(width: 10.w),
        _buildPillTab(
          tab: JobsSubTab.upcoming,
          label: 'Upcoming',
        ),
        SizedBox(width: 10.w),
        _buildPillTab(
          tab: JobsSubTab.completed,
          label: 'Completed',
        ),
      ],
    );
  }

  Widget _buildPillTab({
    required JobsSubTab tab,
    required String label,
  }) {
    final isSelected = _selectedSubTab == tab;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedSubTab = tab),
        child: Container(
          height: 48.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFFEF5E7) : AppColors.white,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFFB89035)
                  : const Color(0xFFE2E8F0),
              width: isSelected ? 1.5 : 1.2,
            ),
          ),
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14.5.sp,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected
                  ? const Color(0xFFB45309)
                  : const Color(0xFF64748B),
            ),
          ),
        ),
      ),
    );
  }

  // --- Sub-Tab 1: Nearby Content (Figma Screen 2 & 3) ---
  Widget _buildNearbyContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Mode toggle header (allows viewing both the 2 jobs list and the empty state from Figma screen 2)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _showEmptyNearby
                  ? 'No jobs in your area'
                  : '2 nearby jobs · sorted by distance',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: const Color(0xFF64748B),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() => _showEmptyNearby = !_showEmptyNearby);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF5E7),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: const Color(0xFFFDE68A)),
                ),
                child: Text(
                  _showEmptyNearby ? 'Show jobs' : 'Show empty state',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFB45309),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),

        if (_showEmptyNearby) ...[
          // Figma Screen 2: No new jobs nearby card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(18.r),
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
                  'No new jobs nearby',
                  style: GoogleFonts.inter(
                    fontSize: 15.5.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFB45309),
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  "You're up to date. We'll notify you when an agent requests boys in your area.",
                  style: GoogleFonts.inter(
                    fontSize: 13.5.sp,
                    color: const Color(0xFF9A5B13),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // Home area and Job alerts Card
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Home area',
                      style: GoogleFonts.inter(
                        fontSize: 14.5.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0F2D24),
                      ),
                    ),
                    Text(
                      'Peelamedu',
                      style: GoogleFonts.inter(
                        fontSize: 14.5.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFB45309),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 14.h),
                const Divider(color: Color(0xFFF1F5F9), height: 1),
                SizedBox(height: 14.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Job alerts',
                      style: GoogleFonts.inter(
                        fontSize: 14.5.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0F2D24),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          _jobAlertsEnabled ? 'On' : 'Off',
                          style: GoogleFonts.inter(
                            fontSize: 14.5.sp,
                            fontWeight: FontWeight.w600,
                            color: _jobAlertsEnabled
                                ? const Color(0xFF0E6347)
                                : const Color(0xFF64748B),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Switch(
                          value: _jobAlertsEnabled,
                          activeThumbColor: AppColors.primary,
                          onChanged: (val) {
                            setState(() => _jobAlertsEnabled = val);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 18.h),

          // Refresh button
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: OutlinedButton(
              onPressed: () {
                setState(() => _showEmptyNearby = false);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Checking for shifts in Peelamedu... 2 new jobs found!',
                      style: GoogleFonts.inter(),
                    ),
                    backgroundColor: AppColors.primary,
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: Color(0xFFCBD5E1),
                  width: 1.2,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Refresh',
                style: GoogleFonts.inter(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0F2D24),
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),

          // Update home location button
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SupplierHomeLocationScreen(),
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
                'Update home location',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ] else ...[
          // Job Card 1: Annai Mahal -> Opens SupplierNewJobScreen
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SupplierNewJobScreen(
                    venue: 'Annai Mahal',
                    area: 'Peelamedu',
                    date: 'Sat, 11 Oct',
                    reportingTime: '6:00 AM',
                    earnings: 300,
                    distance: '4.2 km from you',
                  ),
                ),
              );
            },
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
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Annai Mahal',
                        style: GoogleFonts.inter(
                          fontSize: 16.5.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F2D24),
                        ),
                      ),
                      Text(
                        '4.2 km',
                        style: GoogleFonts.inter(
                          fontSize: 14.5.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFB45309),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    'Peelamedu, Coimbatore',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Sat, 11 Oct · 6:00 AM',
                    style: GoogleFonts.inter(
                      fontSize: 15.sp,
                      color: const Color(0xFF0F2D24),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Serving boy · 1 shift',
                        style: GoogleFonts.inter(
                          fontSize: 15.5.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F2D24),
                        ),
                      ),
                      Text(
                        '₹300',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFB45309),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // Job Card 2: Another nearby offer
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SupplierNewJobScreen(
                    venue: 'Sri Krishna Grand',
                    area: 'R.S. Puram',
                    date: 'Sun, 12 Oct',
                    reportingTime: '7:00 AM',
                    earnings: 350,
                    distance: '5.8 km from you',
                  ),
                ),
              );
            },
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Another nearby offer',
                        style: GoogleFonts.inter(
                          fontSize: 16.5.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F2D24),
                        ),
                      ),
                      Text(
                        'View',
                        style: GoogleFonts.inter(
                          fontSize: 14.5.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFB45309),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Open the offer to see its date, area and payout.',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: const Color(0xFF64748B),
                      height: 1.35,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'Tap to view shift details and accept',
                    style: GoogleFonts.inter(
                      fontSize: 12.5.sp,
                      color: const Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 18.h),

          // Button: Refresh nearby jobs
          InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Nearby jobs refreshed successfully.',
                    style: GoogleFonts.inter(),
                  ),
                  backgroundColor: AppColors.primary,
                ),
              );
            },
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
                'Refresh nearby jobs',
                style: GoogleFonts.inter(
                  fontSize: 15.5.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFB89035),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  // --- Sub-Tab 2: Upcoming Content (Figma Screen 4) ---
  Widget _buildUpcomingContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Card 1: Accepted upcoming job card -> Opens SupplierBookedScreen
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SupplierBookedScreen(),
              ),
            );
          },
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
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Annai Mahal',
                      style: GoogleFonts.inter(
                        fontSize: 16.5.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F2D24),
                      ),
                    ),
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
                        'Accepted',
                        style: GoogleFonts.inter(
                          fontSize: 12.5.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF166534),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Text(
                  'Peelamedu, Coimbatore',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: const Color(0xFF64748B),
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Sat, 11 Oct · 6:00 AM',
                  style: GoogleFonts.inter(
                    fontSize: 15.sp,
                    color: const Color(0xFF0F2D24),
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Serving boy · 1 shift',
                      style: GoogleFonts.inter(
                        fontSize: 15.5.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F2D24),
                      ),
                    ),
                    Text(
                      '₹300',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFB45309),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.h),

        // Card 2: Reporting Instruction Box
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
                'Be ready for 6:00 AM',
                style: GoogleFonts.inter(
                  fontSize: 15.5.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFB45309),
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                'Check the dress and reporting instructions before leaving.',
                style: GoogleFonts.inter(
                  fontSize: 13.5.sp,
                  color: const Color(0xFF785B38),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 18.h),

        // Card 3: Button View accepted job -> Opens SupplierBookedScreen
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SupplierBookedScreen(),
              ),
            );
          },
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
              'View accepted job',
              style: GoogleFonts.inter(
                fontSize: 15.5.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFB89035),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // --- Sub-Tab 3: Completed Content (Figma Screen 6) ---
  Widget _buildCompletedContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Card 1: Monthly shifts summary card
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            color: const Color(0xFFFEF5E7),
            borderRadius: BorderRadius.circular(18.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'This month',
                style: GoogleFonts.inter(
                  fontSize: 14.5.sp,
                  color: const Color(0xFF785B38),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                '8 shifts',
                style: GoogleFonts.inter(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFFB45309),
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                '₹2,400 earned',
                style: GoogleFonts.inter(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF785B38),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),

        // Card 2: Completed shifts list container
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
              // Shift 1: Annai Mahal, Peelamedu -> Opens SupplierShiftCompletedScreen
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SupplierShiftCompletedScreen(
                        venue: 'Annai Mahal, Peelamedu',
                        area: 'Peelamedu, Coimbatore',
                        shiftsCount: 1,
                        payout: 300,
                      ),
                    ),
                  );
                },
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Annai Mahal, Peelamedu',
                            style: GoogleFonts.inter(
                              fontSize: 15.5.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F2D24),
                            ),
                          ),
                          Text(
                            '+₹300',
                            style: GoogleFonts.inter(
                              fontSize: 15.5.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFB45309),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Today · 1 shift · Credited',
                        style: GoogleFonts.inter(
                          fontSize: 13.5.sp,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              const Divider(color: Color(0xFFF1F5F9), height: 1),
              SizedBox(height: 16.h),

              // Shift 2: Kalyana Mandapam -> Opens SupplierShiftCompletedScreen
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SupplierShiftCompletedScreen(
                        venue: 'Kalyana Mandapam, Ganapathy',
                        area: 'Ganapathy, Coimbatore',
                        shiftsCount: 2,
                        payout: 600,
                      ),
                    ),
                  );
                },
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Kalyana Mandapam',
                            style: GoogleFonts.inter(
                              fontSize: 15.5.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F2D24),
                            ),
                          ),
                          Text(
                            '+₹600',
                            style: GoogleFonts.inter(
                              fontSize: 15.5.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFB45309),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Ganapathy · 4 Oct · 2 shifts',
                        style: GoogleFonts.inter(
                          fontSize: 13.5.sp,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),

        // Helper text below card
        Text(
          'Open a completed shift to see its payout and review.',
          style: GoogleFonts.inter(
            fontSize: 13.5.sp,
            color: const Color(0xFF64748B),
          ),
        ),
      ],
    );
  }
}
