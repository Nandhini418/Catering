import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:catering/constants/app_colors.dart';

enum AgentBottomTab {
  home,
  bookings,
  favourites,
  help,
}

class AgentBottomNav extends StatelessWidget {
  final AgentBottomTab currentTab;
  final ValueChanged<AgentBottomTab> onTabSelected;

  const AgentBottomNav({
    super.key,
    required this.currentTab,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFF1F5F9), width: 1.0),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64.h,
          child: Row(
            children: [
              _buildNavItem(
                tab: AgentBottomTab.home,
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                label: 'Home',
              ),
              _buildNavItem(
                tab: AgentBottomTab.bookings,
                icon: Icons.assignment_outlined,
                activeIcon: Icons.assignment,
                label: 'Bookings',
              ),
              _buildNavItem(
                tab: AgentBottomTab.favourites,
                icon: Icons.favorite_border,
                activeIcon: Icons.favorite,
                label: 'Favourites',
              ),
              _buildNavItem(
                tab: AgentBottomTab.help,
                icon: Icons.help_outline,
                activeIcon: Icons.help,
                label: 'Help',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required AgentBottomTab tab,
    required IconData icon,
    required IconData activeIcon,
    required String label,
  }) {
    final isSelected = currentTab == tab;
    final color = isSelected ? AppColors.primary : const Color(0xFF64748B);

    return Expanded(
      child: InkWell(
        onTap: () => onTabSelected(tab),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              color: color,
              size: 24.r,
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
