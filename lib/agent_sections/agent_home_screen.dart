import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:catering/constants/app_colors.dart';
import 'package:catering/agent_sections/agent_new_booking_screen.dart';
import 'package:catering/agent_sections/agent_profile_screen.dart';
import 'package:catering/agent_sections/bookings/my_bookings_screen.dart';
import 'package:catering/agent_sections/bookings/booking_confirmed_screen.dart';
import 'package:catering/agent_sections/bookings/past_booking_details_screen.dart';
import 'package:catering/agent_sections/favourites/favourite_boys_screen.dart';
import 'package:catering/agent_sections/payments/pay_shift_screen.dart';
import 'package:catering/widgets/agent_bottom_nav.dart';

class AgentHomeScreen extends StatefulWidget {
  final String businessName;
  final String city;

  const AgentHomeScreen({
    super.key,
    this.businessName = 'Sri Murugan Caterers',
    this.city = 'COIMBATORE',
  });

  @override
  State<AgentHomeScreen> createState() => _AgentHomeScreenState();
}

class _AgentHomeScreenState extends State<AgentHomeScreen> {
  AgentBottomTab _currentTab = AgentBottomTab.home;

  void _onBottomTabSelected(AgentBottomTab tab) {
    if (tab == AgentBottomTab.bookings) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyBookingsScreen()),
      );
      return;
    }
    if (tab == AgentBottomTab.favourites) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const FavouriteBoysScreen()),
      );
      return;
    }
    if (tab == AgentBottomTab.help) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Agent hotline support: 1800-419-CATER (9 AM - 10 PM)',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: AppColors.primary,
        ),
      );
      return;
    }
    setState(() => _currentTab = tab);
  }

  void _navigateToNewBooking() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AgentNewBookingScreen(),
      ),
    );
  }

  void _navigateToActiveBooking() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BookingConfirmedScreen(
          venue: 'Annai Mahal',
          location: 'Peelamedu, Coimbatore',
          dateTime: 'Sat, 11 Oct · 6:00 AM',
          boysCount: 10,
          shifts: 1,
          totalAmount: 4000,
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
                    'Agent dashboard: post bookings and manage catering staff.',
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
        currentTab: _currentTab,
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
                'AGENT / ${widget.city.toUpperCase()}',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F766E),
                  letterSpacing: 0.6,
                ),
              ),
              SizedBox(height: 8.h),

              // Catering Business Name
              Text(
                widget.businessName,
                style: GoogleFonts.inter(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF0F2D24),
                  letterSpacing: -0.6,
                  height: 1.25,
                ),
              ),
              SizedBox(height: 20.h),

              // + New booking Button
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  onPressed: _navigateToNewBooking,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0E6347),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: Colors.white, size: 20.r),
                      SizedBox(width: 8.w),
                      Text(
                        'New booking',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 18.h),

              // Payment Due Alert Card
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PayShiftScreen(
                        venue: 'Kalyana Mandapam, Ganapathy',
                        boys: 10,
                        shifts: 1,
                        ratePerBoy: 400,
                        totalAmount: 4000,
                        timeRemaining: '0:54:12',
                      ),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(18.r),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF7E6),
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
                        'Payment due: ₹4,000',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF9A5B13),
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        'Pay within 54 minutes · Pay now',
                        style: GoogleFonts.inter(
                          fontSize: 13.5.sp,
                          color: const Color(0xFF785B38),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              // Active booking Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Active booking',
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F2D24),
                    ),
                  ),
                  GestureDetector(
                    onTap: _navigateToActiveBooking,
                    child: Text(
                      'View',
                      style: GoogleFonts.inter(
                        fontSize: 14.5.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F766E),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),

              // Active booking Card
              GestureDetector(
                onTap: _navigateToActiveBooking,
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
                      Text(
                        'Annai Mahal, Peelamedu',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F2D24),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Text(
                            'Boys ready',
                            style: GoogleFonts.inter(
                              fontSize: 14.5.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0F2D24),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            '10 of 10',
                            style: GoogleFonts.inter(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F766E),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),

                      // Progress Bar (100% full green)
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
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              // Past bookings Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Past bookings',
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F2D24),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const MyBookingsScreen(initialShowPast: true),
                        ),
                      );
                    },
                    child: Text(
                      'View all',
                      style: GoogleFonts.inter(
                        fontSize: 14.5.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F766E),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),

              // Past bookings Card
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const PastBookingDetailsScreen(
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
                      child: _buildPastBookingItem(
                        venue: 'Kalyana Mandapam',
                        price: '₹6,400',
                        details: 'Ganapathy · 4 Oct · 8 boys · 2 shifts',
                      ),
                    ),
                    SizedBox(height: 16.h),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const PastBookingDetailsScreen(
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
                      child: _buildPastBookingItem(
                        venue: 'Hotel Hall',
                        price: '₹4,800',
                        details: 'Race Course · 27 Sep · 12 boys · 1 shift',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              // Profile & settings row
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AgentProfileScreen(),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Profile & settings',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F2D24),
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: const Color(0xFF0F766E),
                        size: 24.r,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 28.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPastBookingItem({
    required String venue,
    required String price,
    required String details,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              venue,
              style: GoogleFonts.inter(
                fontSize: 15.5.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F2D24),
              ),
            ),
            Text(
              price,
              style: GoogleFonts.inter(
                fontSize: 15.5.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F766E),
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          details,
          style: GoogleFonts.inter(
            fontSize: 13.5.sp,
            color: const Color(0xFF64748B),
          ),
        ),
      ],
    );
  }
}
