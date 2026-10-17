import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:catering/constants/app_colors.dart';
import 'package:catering/supplier_sections/supplier_profile_screen.dart';
import 'package:catering/agent_sections/agent_profile_screen.dart';

enum CaterRole { agent, supplier }

class CaterConnectSelectionScreen extends StatefulWidget {
  const CaterConnectSelectionScreen({super.key});

  @override
  State<CaterConnectSelectionScreen> createState() =>
      _CaterConnectSelectionScreenState();
}

class _CaterConnectSelectionScreenState
    extends State<CaterConnectSelectionScreen> {
  CaterRole _selectedRole = CaterRole.agent;

  void _navigateToSupplierProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SupplierProfileScreen(),
      ),
    );
  }

  void _navigateToAgentProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AgentProfileScreen(),
      ),
    );
  }

  void _handleContinue() {
    if (_selectedRole == CaterRole.supplier) {
      _navigateToSupplierProfile();
    } else if (_selectedRole == CaterRole.agent) {
      _navigateToAgentProfile();
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
                    'CaterConnect connects catering agents with verified serving staff.',
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
                    SizedBox(height: 28.h),

                    // Top Label: WELCOME
                    Text(
                      'WELCOME',
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                        letterSpacing: 0.8,
                      ),
                    ),
                    SizedBox(height: 8.h),

                    // Heading: How will you use CaterConnect?
                    Text(
                      'How will you use\nCaterConnect?',
                      style: GoogleFonts.inter(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                        height: 1.25,
                        letterSpacing: -0.4,
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // Subtitle: Pick one. Create your profile in the next step.
                    Text(
                      'Pick one. Create your profile in the next step.',
                      style: GoogleFonts.inter(
                        fontSize: 14.5.sp,
                        color: AppColors.textMuted,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 28.h),

                    // Card 1: I am an Agent
                    _buildRoleCard(
                      role: CaterRole.agent,
                      title: 'I am an Agent',
                      description:
                          'I take catering orders and need serving boys for events.',
                    ),
                    SizedBox(height: 18.h),

                    // Card 2: I am a Supplier
                    _buildRoleCard(
                      role: CaterRole.supplier,
                      title: 'I am a Supplier',
                      description: 'I want to take serving shifts near me.',
                    ),
                    SizedBox(height: 18.h),

                    // Card 3: Admin access
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
                            'Admin access',
                            style: GoogleFonts.inter(
                              fontSize: 15.5.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFB45309),
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            'Admin accounts are created by the owner only.',
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              color: AppColors.textMuted,
                              height: 1.35,
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

            // Pinned Bottom Button
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
                  onPressed: _handleContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    _selectedRole == CaterRole.agent
                        ? 'Continue as Agent'
                        : 'Continue as Supplier',
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

  Widget _buildRoleCard({
    required CaterRole role,
    required String title,
    required String description,
  }) {
    final isSelected = _selectedRole == role;

    return GestureDetector(
      onTap: () {
        setState(() => _selectedRole = role);
        if (role == CaterRole.supplier) {
          _navigateToSupplierProfile();
        } else if (role == CaterRole.agent) {
          _navigateToAgentProfile();
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(18.r),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFF9ED) : AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? AppColors.primary : const Color(0xFFB89035),
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
                if (isSelected) ...[
                  SizedBox(width: 8.w),
                  Text(
                    'Selected',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              description,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: AppColors.textMuted,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
