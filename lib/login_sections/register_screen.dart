import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:catering/constants/app_colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int _currentStep = 1;

  // Step 1 Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _selectedGender = 'Male';

  // Step 2 Controllers
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  // Step 3 Photo state
  bool _photoUploaded = false;

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  void _onBack() {
    if (_currentStep > 1) {
      setState(() => _currentStep--);
    } else {
      Navigator.pop(context);
    }
  }

  void _onContinue() {
    if (_currentStep == 1) {
      if (_nameController.text.trim().isEmpty) {
        _showSnack('Please enter your full name');
        return;
      }
      if (_dobController.text.trim().isEmpty) {
        _showSnack('Please select your date of birth');
        return;
      }
      if (_phoneController.text.trim().length != 10) {
        _showSnack('Please enter a valid 10-digit mobile number');
        return;
      }
      setState(() => _currentStep = 2);
    } else if (_currentStep == 2) {
      if (_addressController.text.trim().isEmpty) {
        _showSnack('Please enter your address');
        return;
      }
      if (_cityController.text.trim().isEmpty) {
        _showSnack('Please enter your city / service area');
        return;
      }
      setState(() => _currentStep = 3);
    } else if (_currentStep == 3) {
      // Completed registration -> Navigate back to LoginScreen
      Navigator.pop(context);
    }
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: GoogleFonts.inter()),
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              onSurface: AppColors.textDark,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      final day = picked.day.toString().padLeft(2, '0');
      final month = picked.month.toString().padLeft(2, '0');
      final year = picked.year.toString();
      setState(() {
        _dobController.text = '$day-$month-$year';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),

                    // Top Row: Circular Back Button
                    GestureDetector(
                      onTap: _onBack,
                      child: Container(
                        width: 44.r,
                        height: 44.r,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF2F6FA),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: AppColors.textDark,
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Subtitle: Step X of 3
                    Text(
                      'Step $_currentStep of 3',
                      style: GoogleFonts.inter(
                        fontSize: 13.5.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textMuted,
                      ),
                    ),
                    SizedBox(height: 6.h),

                    // Title: Worker Registration
                    Text(
                      'Worker Registration',
                      style: GoogleFonts.inter(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                        letterSpacing: -0.3,
                      ),
                    ),
                    SizedBox(height: 22.h),

                    // 3-Step Progress Indicators & Labels
                    _buildStepperBar(),
                    SizedBox(height: 28.h),

                    // Step Content
                    if (_currentStep == 1) _buildStep1Personal(),
                    if (_currentStep == 2) _buildStep2Address(),
                    if (_currentStep == 3) _buildStep3Photo(),

                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),

            // Pinned Bottom Button Bar
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
                  onPressed: _onContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                  child: Text(
                    'Continue',
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

  // --- Stepper Bar ---
  Widget _buildStepperBar() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Container(
                height: 4.h,
                decoration: BoxDecoration(
                  color: _currentStep >= 2
                      ? AppColors.primary
                      : const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Container(
                height: 4.h,
                decoration: BoxDecoration(
                  color: _currentStep >= 3
                      ? AppColors.primary
                      : const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.h),
        Row(
          children: [
            Expanded(
              child: Text(
                'Personal Info',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight:
                      _currentStep == 1 ? FontWeight.w700 : FontWeight.w500,
                  color: _currentStep >= 1
                      ? AppColors.primary
                      : const Color(0xFF94A3B8),
                ),
              ),
            ),
            Expanded(
              child: Text(
                'Address',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight:
                      _currentStep == 2 ? FontWeight.w700 : FontWeight.w500,
                  color: _currentStep >= 2
                      ? AppColors.primary
                      : const Color(0xFF94A3B8),
                ),
              ),
            ),
            Expanded(
              child: Text(
                'Photo',
                textAlign: TextAlign.end,
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight:
                      _currentStep == 3 ? FontWeight.w700 : FontWeight.w500,
                  color: _currentStep >= 3
                      ? AppColors.primary
                      : const Color(0xFF94A3B8),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // --- Step 1: Personal Info ---
  Widget _buildStep1Personal() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Full Name
        _buildFieldLabel('Full Name'),
        TextFormField(
          controller: _nameController,
          textCapitalization: TextCapitalization.words,
          style: GoogleFonts.inter(fontSize: 15.sp, color: AppColors.textDark),
          decoration: _buildInputDecoration(hintText: 'Enter your full name'),
        ),
        SizedBox(height: 18.h),

        // Date of Birth
        _buildFieldLabel('Date of Birth'),
        GestureDetector(
          onTap: _selectDate,
          child: AbsorbPointer(
            child: TextFormField(
              controller: _dobController,
              style: GoogleFonts.inter(fontSize: 15.sp, color: AppColors.textDark),
              decoration: _buildInputDecoration(
                hintText: 'dd-mm-yyyy',
                suffixIcon: Icons.calendar_today_outlined,
              ),
            ),
          ),
        ),
        SizedBox(height: 18.h),

        // Gender Pills
        _buildFieldLabel('Gender'),
        Row(
          children: [
            _buildGenderPill('Male'),
            SizedBox(width: 10.w),
            _buildGenderPill('Female'),
            SizedBox(width: 10.w),
            _buildGenderPill('Other'),
          ],
        ),
        SizedBox(height: 18.h),

        // Mobile Number
        _buildFieldLabel('Mobile Number'),
        TextFormField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10),
          ],
          style: GoogleFonts.inter(fontSize: 15.sp, color: AppColors.textDark),
          decoration: _buildInputDecoration(hintText: '10-digit number'),
        ),
      ],
    );
  }

  Widget _buildGenderPill(String gender) {
    final isSelected = _selectedGender == gender;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedGender = gender),
        child: Container(
          height: 48.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary.withValues(alpha: 0.08)
                : AppColors.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: isSelected ? AppColors.primary : const Color(0xFFE2E8F0),
              width: isSelected ? 1.5 : 1.0,
            ),
          ),
          child: Text(
            gender,
            style: GoogleFonts.inter(
              fontSize: 14.5.sp,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected ? AppColors.primary : AppColors.textDark,
            ),
          ),
        ),
      ),
    );
  }

  // --- Step 2: Address ---
  Widget _buildStep2Address() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Full Address
        _buildFieldLabel('Full Address'),
        TextFormField(
          controller: _addressController,
          style: GoogleFonts.inter(fontSize: 15.sp, color: AppColors.textDark),
          decoration: _buildInputDecoration(
            hintText: 'House/Flat, Street, Landmark',
          ),
        ),
        SizedBox(height: 18.h),

        // City / Service Area
        _buildFieldLabel('City / Service Area'),
        TextFormField(
          controller: _cityController,
          style: GoogleFonts.inter(fontSize: 15.sp, color: AppColors.textDark),
          decoration: _buildInputDecoration(hintText: 'e.g. Coimbatore'),
        ),
        SizedBox(height: 22.h),

        // Service Area Info Callout Box
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF9F2),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFFFFEDD5)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '📍',
                style: TextStyle(fontSize: 16.sp),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Service Area',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF78350F),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'We match you with jobs within 10 km of your location.',
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        color: const Color(0xFFB45309),
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- Step 3: Photo ---
  Widget _buildStep3Photo() {
    return Column(
      children: [
        SizedBox(height: 40.h),
        Center(
          child: GestureDetector(
            onTap: () {
              setState(() => _photoUploaded = !_photoUploaded);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    _photoUploaded
                        ? 'Worker photo selected successfully!'
                        : 'Photo removed',
                    style: GoogleFonts.inter(),
                  ),
                  backgroundColor: AppColors.primary,
                ),
              );
            },
            child: Container(
              width: 170.w,
              height: 180.h,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: _photoUploaded
                      ? AppColors.primary
                      : const Color(0xFF1E293B),
                  width: 2.2,
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _photoUploaded
                            ? Icons.check_circle_outline
                            : Icons.image_outlined,
                        size: 74.r,
                        color: _photoUploaded
                            ? AppColors.primary
                            : const Color(0xFF1E293B),
                      ),
                      if (_photoUploaded) ...[
                        SizedBox(height: 8.h),
                        Text(
                          'Photo Ready',
                          style: GoogleFonts.inter(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ],
                  ),
                  // Upload arrow badge in circle at bottom right
                  Positioned(
                    bottom: 14.h,
                    right: 14.w,
                    child: Container(
                      width: 32.r,
                      height: 32.r,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _photoUploaded
                              ? AppColors.primary
                              : const Color(0xFF1E293B),
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        Icons.arrow_upward,
                        size: 18.r,
                        color: _photoUploaded
                            ? AppColors.primary
                            : const Color(0xFF1E293B),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required String hintText,
    IconData? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: GoogleFonts.inter(
        color: const Color(0xFF94A3B8),
        fontSize: 14.5.sp,
        fontWeight: FontWeight.w400,
      ),
      suffixIcon: suffixIcon != null
          ? Icon(suffixIcon, color: const Color(0xFF1E293B), size: 20.r)
          : null,
      filled: true,
      fillColor: AppColors.white,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
    );
  }
}
