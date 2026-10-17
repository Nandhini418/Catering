import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:catering/constants/app_colors.dart';
import 'package:catering/widgets/agent_bottom_nav.dart';
import 'package:catering/agent_sections/agent_home_screen.dart';
import 'package:catering/agent_sections/bookings/my_bookings_screen.dart';
import 'package:catering/agent_sections/bookings/supplier_profile_screen.dart';
import 'package:catering/agent_sections/favourites/book_favourites_first_screen.dart';

class FavouriteBoysScreen extends StatefulWidget {
  const FavouriteBoysScreen({super.key});

  @override
  State<FavouriteBoysScreen> createState() => _FavouriteBoysScreenState();
}

class _FavouriteBoysScreenState extends State<FavouriteBoysScreen> {
  final List<Map<String, dynamic>> _favourites = [
    {
      'initials': 'KR',
      'name': 'Karthik R',
      'rating': 4.8,
      'shifts': 12,
      'area': 'Peelamedu',
      'isFavourite': true,
    },
    {
      'initials': 'AS',
      'name': 'Arun S',
      'rating': 4.6,
      'shifts': 7,
      'area': 'Saravanampatti',
      'isFavourite': true,
    },
    {
      'initials': 'SP',
      'name': 'Suresh P',
      'rating': 4.5,
      'shifts': 4,
      'area': 'Gandhipuram',
      'isFavourite': true,
    },
  ];

  void _onBottomTabSelected(AgentBottomTab tab) {
    if (tab == AgentBottomTab.home) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AgentHomeScreen()),
      );
    } else if (tab == AgentBottomTab.bookings) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyBookingsScreen()),
      );
    } else if (tab == AgentBottomTab.favourites) {
      // Already here
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

  void _toggleFavourite(int index) {
    setState(() {
      _favourites[index]['isFavourite'] =
          !(_favourites[index]['isFavourite'] as bool);
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
                    'Your favourite staff receive priority shift notifications before public broadcast.',
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
        currentTab: AgentBottomTab.favourites,
        onTabSelected: _onBottomTabSelected,
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

                    // AGENT / COIMBATORE Tag
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

                    // Title
                    Text(
                      'Favourite boys',
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
                      'Book your best boys first. They get the alert before others.',
                      style: GoogleFonts.inter(
                        fontSize: 13.5.sp,
                        color: const Color(0xFF64748B),
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // List of favourite boys cards
                    ..._favourites.asMap().entries.map((entry) {
                      final int index = entry.key;
                      final boy = entry.value;
                      final bool isFav = boy['isFavourite'] as bool;

                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SupplierProfileScreen(
                                  name: boy['name'] as String,
                                  initials: boy['initials'] as String,
                                  area: boy['area'] as String,
                                  rating: (boy['rating'] as num).toDouble(),
                                  shifts: boy['shifts'] as int,
                                  initialIsFavourite: isFav,
                                ),
                              ),
                            );
                          },
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
                            child: Row(
                              children: [
                                // Avatar circle
                                Container(
                                  width: 44.r,
                                  height: 44.r,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFEF5E7),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color(0xFFFDE68A),
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Text(
                                    boy['initials'] as String,
                                    style: GoogleFonts.inter(
                                      fontSize: 14.5.sp,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF9A5B13),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 14.w),

                                // Name & Stats
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        boy['name'] as String,
                                        style: GoogleFonts.inter(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF0F2D24),
                                        ),
                                      ),
                                      SizedBox(height: 3.h),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            size: 14.r,
                                            color: const Color(0xFFEAB308),
                                          ),
                                          SizedBox(width: 4.w),
                                          Text(
                                            '${boy['rating']} · ${boy['shifts']} shifts with you',
                                            style: GoogleFonts.inter(
                                              fontSize: 12.5.sp,
                                              color: const Color(0xFF64748B),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                // Heart Icon toggle
                                GestureDetector(
                                  onTap: () => _toggleFavourite(index),
                                  child: Padding(
                                    padding: EdgeInsets.all(4.r),
                                    child: Icon(
                                      isFav
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: isFav
                                          ? const Color(0xFFE11D48)
                                          : const Color(0xFFCBD5E1),
                                      size: 22.r,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                    SizedBox(height: 10.h),

                    // Build your trusted team promo card
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
                            'Build your trusted team',
                            style: GoogleFonts.inter(
                              fontSize: 14.5.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFB45309),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "Tap the heart on a boy's rating screen to add him here.",
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              color: const Color(0xFF9A5B13),
                              height: 1.4,
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

            // Bottom Primary Button: Book favourites first
            Container(
              padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 16.h),
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
                        builder: (context) =>
                            const BookFavouritesFirstScreen(),
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
                    'Book favourites first',
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
