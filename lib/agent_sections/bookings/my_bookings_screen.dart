import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:catering/constants/app_colors.dart';
import 'package:catering/widgets/agent_bottom_nav.dart';
import 'package:catering/agent_sections/agent_home_screen.dart';
import 'package:catering/agent_sections/favourites/favourite_boys_screen.dart';
import 'package:catering/agent_sections/bookings/booking_confirmed_screen.dart';
import 'package:catering/agent_sections/bookings/past_booking_details_screen.dart';

class MyBookingsScreen extends StatefulWidget {
  final bool initialShowPast;

  const MyBookingsScreen({
    super.key,
    this.initialShowPast = false,
  });

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  late bool _showPast;

  @override
  void initState() {
    super.initState();
    _showPast = widget.initialShowPast;
  }

  void _onBottomTabSelected(AgentBottomTab tab) {
    if (tab == AgentBottomTab.home) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AgentHomeScreen()),
      );
    } else if (tab == AgentBottomTab.bookings) {
      // Already on bookings
    } else if (tab == AgentBottomTab.favourites) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const FavouriteBoysScreen()),
      );
    } else if (tab == AgentBottomTab.help) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Agent hotline support: 1800-419-CATER (9 AM - 10 PM)',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: AppColors.primary,
        ),
      );
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
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AgentHomeScreen()),
              );
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
                    'Manage your ongoing and completed catering bookings.',
                    style: GoogleFonts.inter(),
                  ),
                  backgroundColor: AppColors.primary,
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: AgentBottomNav(
        currentTab: AgentBottomTab.bookings,
        onTabSelected: _onBottomTabSelected,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h),

              // Category tag: AGENT / COIMBATORE
              Text(
                'AGENT / COIMBATORE',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                  letterSpacing: 0.8,
                ),
              ),
              SizedBox(height: 8.h),

              // Title: My bookings
              Text(
                'My bookings',
                style: GoogleFonts.inter(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF0F2D24),
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(height: 20.h),

              // Tab Switcher: [ Active ] [ Past ]
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _showPast = false),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          color: !_showPast
                              ? const Color(0xFFFFF9ED)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: !_showPast
                                ? AppColors.primary
                                : const Color(0xFFE2E8F0),
                            width: 1.2,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Active',
                          style: GoogleFonts.inter(
                            fontSize: 14.5.sp,
                            fontWeight: !_showPast
                                ? FontWeight.w700
                                : FontWeight.w500,
                            color: !_showPast
                                ? const Color(0xFF9A5B13)
                                : const Color(0xFF64748B),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _showPast = true),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          color: _showPast
                              ? const Color(0xFFFFF9ED)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: _showPast
                                ? AppColors.primary
                                : const Color(0xFFE2E8F0),
                            width: 1.2,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Past',
                          style: GoogleFonts.inter(
                            fontSize: 14.5.sp,
                            fontWeight:
                                _showPast ? FontWeight.w700 : FontWeight.w500,
                            color: _showPast
                                ? const Color(0xFF9A5B13)
                                : const Color(0xFF64748B),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              if (!_showPast) ...[
                // ACTIVE BOOKING CARD
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BookingConfirmedScreen(),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.r),
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
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Venue & Status Badge
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Annai Mahal',
                              style: GoogleFonts.inter(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F2D24),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE8F5E9),
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              child: Text(
                                'Confirmed',
                                style: GoogleFonts.inter(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF2E7D32),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Peelamedu, Coimbatore',
                          style: GoogleFonts.inter(
                            fontSize: 13.5.sp,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                        SizedBox(height: 14.h),

                        // Date & Time
                        Text(
                          'Sat, 11 Oct · 6:00 AM',
                          style: GoogleFonts.inter(
                            fontSize: 14.5.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F2D24),
                          ),
                        ),
                        SizedBox(height: 4.h),

                        // Boys count & rate
                        Text(
                          '10 boys · 1 shift ₹4,000',
                          style: GoogleFonts.inter(
                            fontSize: 13.5.sp,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                        SizedBox(height: 18.h),

                        // Progress Bar Header
                        Row(
                          children: [
                            Text(
                              'Boys ready',
                              style: GoogleFonts.inter(
                                fontSize: 13.5.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF0F2D24),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              '10 of 10',
                              style: GoogleFonts.inter(
                                fontSize: 13.5.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0E6347),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),

                        // Linear progress indicator
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4.r),
                          child: LinearProgressIndicator(
                            value: 1.0,
                            minHeight: 6.h,
                            backgroundColor: const Color(0xFFE2E8F0),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xFF0E6347),
                            ),
                          ),
                        ),
                        SizedBox(height: 18.h),

                        const Divider(color: Color(0xFFF1F5F9), height: 1),
                        SizedBox(height: 14.h),

                        // View booking & attendance >
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'View booking & attendance',
                              style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF0F2D24),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 14.r,
                              color: const Color(0xFF64748B),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 28.h),

                // Recent Bookings Header
                Text(
                  'Recent bookings',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F2D24),
                  ),
                ),
                SizedBox(height: 12.h),

                _buildRecentBookingCard(
                  venue: 'Kalyana Mandapam',
                  price: '₹6,400',
                  details: 'Ganapathy · 4 Oct · 8 boys · 2 shifts',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PastBookingDetailsScreen(
                          venue: 'Kalyana Mandapam',
                          location: 'Ganapathy',
                          date: '4 Oct',
                          boys: 8,
                          shifts: 2,
                          ratePerBoy: 400,
                          totalAmount: 6400,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 12.h),

                _buildRecentBookingCard(
                  venue: 'Hotel Hall',
                  price: '₹4,800',
                  details: 'Race Course · 27 Sep · 12 boys · 1 shift',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PastBookingDetailsScreen(
                          venue: 'Hotel Hall',
                          location: 'Race Course',
                          date: '27 Sep',
                          boys: 12,
                          shifts: 1,
                          ratePerBoy: 400,
                          totalAmount: 4800,
                        ),
                      ),
                    );
                  },
                ),
              ] else ...[
                // PAST TAB CONTENT
                _buildPastBookingCard(
                  venue: 'Kalyana Mandapam',
                  status: 'Completed',
                  location: 'Ganapathy',
                  date: '4 Oct',
                  boys: 8,
                  shifts: 2,
                  price: '₹6,400',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PastBookingDetailsScreen(
                          venue: 'Kalyana Mandapam',
                          location: 'Ganapathy',
                          date: '4 Oct',
                          boys: 8,
                          shifts: 2,
                          ratePerBoy: 400,
                          totalAmount: 6400,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 12.h),

                _buildPastBookingCard(
                  venue: 'Hotel Hall',
                  status: 'Completed',
                  location: 'Race Course',
                  date: '27 Sep',
                  boys: 12,
                  shifts: 1,
                  price: '₹4,800',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PastBookingDetailsScreen(
                          venue: 'Hotel Hall',
                          location: 'Race Course',
                          date: '27 Sep',
                          boys: 12,
                          shifts: 1,
                          ratePerBoy: 400,
                          totalAmount: 4800,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 12.h),

                _buildPastBookingCard(
                  venue: 'Sri Krishna Hall',
                  status: 'Completed',
                  location: 'Gandhipuram',
                  date: '18 Sep',
                  boys: 8,
                  shifts: 1,
                  price: '₹3,200',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PastBookingDetailsScreen(
                          venue: 'Sri Krishna Hall',
                          location: 'Gandhipuram',
                          date: '18 Sep',
                          boys: 8,
                          shifts: 1,
                          ratePerBoy: 400,
                          totalAmount: 3200,
                        ),
                      ),
                    );
                  },
                ),
              ],

              SizedBox(height: 28.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentBookingCard({
    required String venue,
    required String price,
    required String details,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  venue,
                  style: GoogleFonts.inter(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F2D24),
                  ),
                ),
                Text(
                  price,
                  style: GoogleFonts.inter(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0E6347),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Text(
              details,
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                color: const Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPastBookingCard({
    required String venue,
    required String status,
    required String location,
    required String date,
    required int boys,
    required int shifts,
    required String price,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(18.r),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  venue,
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
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
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    status,
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF2E7D32),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.h),
            Text(
              '$location · $date',
              style: GoogleFonts.inter(
                fontSize: 13.5.sp,
                color: const Color(0xFF64748B),
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$boys boys · $shifts ${shifts == 1 ? 'shift' : 'shifts'}',
                  style: GoogleFonts.inter(
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF0F2D24),
                  ),
                ),
                Text(
                  price,
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0E6347),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
