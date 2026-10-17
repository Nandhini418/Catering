import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:catering/constants/app_colors.dart';

enum SupplierBottomTab {
  home,
  jobs,
  wallet,
  help,
}

class SupplierBottomNav extends StatelessWidget {
  final SupplierBottomTab currentTab;
  final ValueChanged<SupplierBottomTab> onTabSelected;

  const SupplierBottomNav({
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
                tab: SupplierBottomTab.home,
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                label: 'Home',
              ),
              _buildNavItem(
                tab: SupplierBottomTab.jobs,
                icon: Icons.assignment_outlined,
                activeIcon: Icons.assignment,
                label: 'Jobs',
              ),
              _buildNavItem(
                tab: SupplierBottomTab.wallet,
                icon: Icons.account_balance_wallet_outlined,
                activeIcon: Icons.account_balance_wallet,
                label: 'Wallet',
              ),
              _buildNavItem(
                tab: SupplierBottomTab.help,
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
    required SupplierBottomTab tab,
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
