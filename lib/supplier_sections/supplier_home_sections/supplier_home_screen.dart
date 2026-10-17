import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:catering/constants/app_colors.dart';
import 'package:catering/supplier_sections/supplier_home_sections/supplier_jobs_screen.dart';
import 'package:catering/widgets/supplier_bottom_nav.dart';

class SupplierHomeScreen extends StatefulWidget {
  final SupplierBottomTab initialTab;

  const SupplierHomeScreen({
    super.key,
    this.initialTab = SupplierBottomTab.home,
  });

  @override
  State<SupplierHomeScreen> createState() => _SupplierHomeScreenState();
}

class _SupplierHomeScreenState extends State<SupplierHomeScreen> {
  late SupplierBottomTab _currentTab;
  JobsSubTab _jobsSubTab = JobsSubTab.nearby;

  @override
  void initState() {
    super.initState();
    _currentTab = widget.initialTab;
  }

  void _onBottomTabSelected(SupplierBottomTab tab) {
    if (tab == SupplierBottomTab.wallet) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Wallet balance: ₹2,400. Payout transfers weekly.',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: AppColors.primary,
        ),
      );
      return;
    }
    if (tab == SupplierBottomTab.help) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Support available 24/7 at support@caterconnect.com',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: AppColors.primary,
        ),
      );
      return;
    }
    setState(() => _currentTab = tab);
  }

  void _switchToJobsWithSubTab(JobsSubTab subTab) {
    setState(() {
      _currentTab = SupplierBottomTab.jobs;
      _jobsSubTab = subTab;
    });
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

    if (_currentTab == SupplierBottomTab.jobs) {
      return SupplierJobsScreen(
        initialSubTab: _jobsSubTab,
        onTabChanged: _onBottomTabSelected,
      );
    }

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
                    'Your CaterConnect Supplier Dashboard.',
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

                    // Category / Location Tag
                    Text(
                      'SUPPLIER / COIMBATORE',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F766E),
                        letterSpacing: 0.6,
                      ),
                    ),
                    SizedBox(height: 8.h),

                    // Main Greeting Title
                    Text(
                      'Welcome back,\nKarthik R',
                      style: GoogleFonts.inter(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0F2D24),
                        height: 1.25,
                        letterSpacing: -0.6,
                      ),
                    ),
                    SizedBox(height: 22.h),

                    // Card 1: Gold Gradient Monthly Earnings Card
                    _buildEarningsCard(),
                    SizedBox(height: 16.h),

                    // Card 2: 2 new jobs near you (Mint Green Card)
                    _buildJobsAlertCard(),
                    SizedBox(height: 22.h),

                    // Section Title: Upcoming job & View all
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Upcoming job',
                          style: GoogleFonts.inter(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F2D24),
                          ),
                        ),
                        GestureDetector(
                          onTap: () =>
                              _switchToJobsWithSubTab(JobsSubTab.upcoming),
                          child: Text(
                            'View all',
                            style: GoogleFonts.inter(
                              fontSize: 14.5.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0F766E),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),

                    // Card 3: Upcoming Job Card
                    _buildUpcomingJobCard(),
                    SizedBox(height: 16.h),

                    // Card 4: My profile & settings
                    _buildProfileSettingsCard(),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),

            // Bottom Navigation Bar
            SupplierBottomNav(
              currentTab: _currentTab,
              onTabSelected: _onBottomTabSelected,
            ),
          ],
        ),
      ),
    );
  }

  // Card 1: Gold Gradient Monthly Earnings Card
  Widget _buildEarningsCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 22.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        gradient: const LinearGradient(
          colors: [
            Color(0xFFF4CE75),
            Color(0xFFBB8406),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB8851B).withValues(alpha: 0.25),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Earned this month',
            style: GoogleFonts.inter(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white.withValues(alpha: 0.94),
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            '₹2,400',
            style: GoogleFonts.inter(
              fontSize: 38.sp,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: -0.6,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            '8 shifts completed',
            style: GoogleFonts.inter(
              fontSize: 14.5.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white.withValues(alpha: 0.92),
            ),
          ),
        ],
      ),
    );
  }

  // Card 2: 2 new jobs near you (Mint Green Card)
  Widget _buildJobsAlertCard() {
    return GestureDetector(
      onTap: () => _switchToJobsWithSubTab(JobsSubTab.nearby),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(18.r),
        decoration: BoxDecoration(
          color: const Color(0xFFE6F4EA),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '2 new jobs near you',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F766E),
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Closest is 4.2 km away · View jobs',
              style: GoogleFonts.inter(
                fontSize: 13.5.sp,
                color: const Color(0xFF334155),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Card 3: Upcoming Job Card
  Widget _buildUpcomingJobCard() {
    return GestureDetector(
      onTap: () => _switchToJobsWithSubTab(JobsSubTab.upcoming),
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
                  'Annai Mahal',
                  style: GoogleFonts.inter(
                    fontSize: 16.5.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F2D24),
                  ),
                ),
                Text(
                  'Upcoming',
                  style: GoogleFonts.inter(
                    fontSize: 14.5.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0F766E),
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
                    color: const Color(0xFF0F766E),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Card 4: My profile & settings
  Widget _buildProfileSettingsCard() {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Profile & settings for Karthik R',
              style: GoogleFonts.inter(),
            ),
            backgroundColor: AppColors.primary,
          ),
        );
      },
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: const Color(0xFFE2E8F0),
            width: 1.2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'My profile & settings',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F2D24),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: const Color(0xFF0F766E),
              size: 22.r,
            ),
          ],
        ),
      ),
    );
  }
}
