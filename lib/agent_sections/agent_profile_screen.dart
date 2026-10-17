import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:catering/constants/app_colors.dart';
import 'package:catering/agent_sections/agent_home_screen.dart';

class AgentProfileScreen extends StatefulWidget {
  const AgentProfileScreen({super.key});

  @override
  State<AgentProfileScreen> createState() => _AgentProfileScreenState();
}

class _AgentProfileScreenState extends State<AgentProfileScreen> {
  final TextEditingController _nameController =
      TextEditingController(text: 'Murugan K');
  final TextEditingController _businessNameController =
      TextEditingController(text: 'Sri Murugan Caterers');
  final TextEditingController _addressController =
      TextEditingController(text: 'RS Puram, Coimbatore');

  bool _agreeTerms = true;

  @override
  void dispose() {
    _nameController.dispose();
    _businessNameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _handleAcceptAndContinue() {
    final name = _nameController.text.trim();
    final businessName = _businessNameController.text.trim();
    final address = _addressController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter your name',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: AppColors.primary,
        ),
      );
      return;
    }

    if (businessName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter your catering business name',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: AppColors.primary,
        ),
      );
      return;
    }

    if (address.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter your area or address',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: AppColors.primary,
        ),
      );
      return;
    }

    if (!_agreeTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please accept terms and conditions to proceed',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: AppColors.primary,
        ),
      );
      return;
    }

    // Extract city from address if possible
    final parts = address.split(',');
    final city = parts.length > 1 ? parts.last.trim() : 'Coimbatore';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AgentHomeScreen(
          businessName: businessName,
          city: city,
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
                    'Set up your catering agent profile to start booking verified boys.',
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

                    // Tag: AGENT SETUP
                    Text(
                      'AGENT SETUP',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                        letterSpacing: 0.8,
                      ),
                    ),
                    SizedBox(height: 8.h),

                    // Title: Create your profile
                    Text(
                      'Create your profile',
                      style: GoogleFonts.inter(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0F2D24),
                        letterSpacing: -0.6,
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Card 1: Your name
                    _buildInputCard(
                      label: 'Your name',
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                    ),
                    SizedBox(height: 16.h),

                    // Card 2: Catering business name
                    _buildInputCard(
                      label: 'Catering business name',
                      controller: _businessNameController,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                    ),
                    SizedBox(height: 16.h),

                    // Card 3: Area / address
                    _buildInputCard(
                      label: 'Area / address',
                      controller: _addressController,
                      keyboardType: TextInputType.streetAddress,
                      textCapitalization: TextCapitalization.words,
                    ),
                    SizedBox(height: 16.h),

                    // Card 4: Terms and conditions
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
                          Text(
                            'Terms and conditions',
                            style: GoogleFonts.inter(
                              fontSize: 15.5.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F2D24),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Shift rates are set by admin. Payment must be completed within 1 hour after the shift is marked complete. Supplier details are shared only after acceptance.',
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              color: const Color(0xFF64748B),
                              height: 1.45,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 18.h),

                    // Checkbox: I agree to the terms and conditions
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _agreeTerms = !_agreeTerms;
                        });
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 22.r,
                            height: 22.r,
                            decoration: BoxDecoration(
                              color: _agreeTerms
                                  ? const Color(0xFF0E6347)
                                  : AppColors.white,
                              borderRadius: BorderRadius.circular(5.r),
                              border: Border.all(
                                color: _agreeTerms
                                    ? const Color(0xFF0E6347)
                                    : const Color(0xFFCBD5E1),
                                width: 1.5,
                              ),
                            ),
                            child: _agreeTerms
                                ? Icon(
                                    Icons.check,
                                    size: 16.r,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              'I agree to the terms and conditions',
                              style: GoogleFonts.inter(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F2D24),
                              ),
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

            // Pinned Bottom Button: Accept and continue
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
                  onPressed: _handleAcceptAndContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Accept and continue',
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

  Widget _buildInputCard({
    required String label,
    required TextEditingController controller,
    required TextInputType keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
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
            label,
            style: GoogleFonts.inter(
              fontSize: 12.5.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF64748B),
            ),
          ),
          SizedBox(height: 4.h),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            textCapitalization: textCapitalization,
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0F2D24),
            ),
            decoration: const InputDecoration(
              isDense: true,
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }
}
