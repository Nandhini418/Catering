import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:catering/constants/app_colors.dart';
import 'package:catering/agent_sections/payments/payment_successful_screen.dart';

class PayWithUpiScreen extends StatefulWidget {
  final String venue;
  final int totalAmount;
  final int boys;
  final int shifts;

  const PayWithUpiScreen({
    super.key,
    this.venue = 'Annai Mahal, Peelamedu',
    this.totalAmount = 4000,
    this.boys = 10,
    this.shifts = 1,
  });

  @override
  State<PayWithUpiScreen> createState() => _PayWithUpiScreenState();
}

class _PayWithUpiScreenState extends State<PayWithUpiScreen> {
  // 0 = UPI ID, 1 = UPI app
  int _upiMode = 0;
  late TextEditingController _upiController;

  @override
  void initState() {
    super.initState();
    _upiController = TextEditingController(text: 'agent@oksbi');
  }

  @override
  void dispose() {
    _upiController.dispose();
    super.dispose();
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
                    'UPI payments are processed securely through your preferred UPI app.',
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

                    // AGENT Tag
                    Text(
                      'AGENT',
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
                      'Pay with UPI',
                      style: GoogleFonts.inter(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0F2D24),
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(height: 4.h),

                    // Subtitle (Venue)
                    Text(
                      widget.venue,
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Mint Green Admin Pay Card
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20.r),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: const Color(0xFFC8E6C9),
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pay to CaterConnect admin',
                            style: GoogleFonts.inter(
                              fontSize: 13.5.sp,
                              color: const Color(0xFF2E7D32),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            '₹${widget.totalAmount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                            style: GoogleFonts.inter(
                              fontSize: 34.sp,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF1B5E20),
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            '${widget.boys} boys · ${widget.shifts} ${widget.shifts == 1 ? 'shift' : 'shifts'}',
                            style: GoogleFonts.inter(
                              fontSize: 13.5.sp,
                              color: const Color(0xFF2E7D32),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // UPI ID vs UPI App Switcher
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _upiMode = 0),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              decoration: BoxDecoration(
                                color: _upiMode == 0
                                    ? const Color(0xFFE6F4EA)
                                    : AppColors.white,
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(
                                  color: _upiMode == 0
                                      ? const Color(0xFF0E6347)
                                      : const Color(0xFFCBD5E1),
                                  width: _upiMode == 0 ? 1.5 : 1.0,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'UPI ID',
                                style: GoogleFonts.inter(
                                  fontSize: 14.sp,
                                  fontWeight: _upiMode == 0
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  color: _upiMode == 0
                                      ? const Color(0xFF0E6347)
                                      : const Color(0xFF64748B),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _upiMode = 1),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              decoration: BoxDecoration(
                                color: _upiMode == 1
                                    ? const Color(0xFFE6F4EA)
                                    : AppColors.white,
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(
                                  color: _upiMode == 1
                                      ? const Color(0xFF0E6347)
                                      : const Color(0xFFCBD5E1),
                                  width: _upiMode == 1 ? 1.5 : 1.0,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'UPI app',
                                style: GoogleFonts.inter(
                                  fontSize: 14.sp,
                                  fontWeight: _upiMode == 1
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  color: _upiMode == 1
                                      ? const Color(0xFF0E6347)
                                      : const Color(0xFF64748B),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),

                    // Input Field (Your UPI ID)
                    Text(
                      _upiMode == 0 ? 'Your UPI ID' : 'Selected UPI App',
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: const Color(0xFFCBD5E1),
                          width: 1.2,
                        ),
                      ),
                      child: TextField(
                        controller: _upiController,
                        enabled: _upiMode == 0,
                        style: GoogleFonts.inter(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0F2D24),
                        ),
                        decoration: InputDecoration(
                          hintText: _upiMode == 0
                              ? 'Enter your UPI ID (e.g. name@bank)'
                              : 'Google Pay / PhonePe / Paytm',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 14.h,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Warning / Security Box (soft mint)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0FDF4),
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(
                          color: const Color(0xFFDCFCE7),
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Approve in your UPI app',
                            style: GoogleFonts.inter(
                              fontSize: 14.5.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF166534),
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            'Verify the amount before authorising. Never enter a UPI PIN in CaterConnect.',
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              color: const Color(0xFF15803D),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h),

                    Text(
                      'Enter your UPI ID to continue. No payment credentials are supplied.',
                      style: GoogleFonts.inter(
                        fontSize: 12.5.sp,
                        color: const Color(0xFF94A3B8),
                        height: 1.35,
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),

            // Bottom Primary Button: Continue to UPI · ₹4,000
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
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentSuccessfulScreen(
                          venue: widget.venue,
                          totalAmount: widget.totalAmount,
                          boys: widget.boys,
                          shifts: widget.shifts,
                          paymentMethod: 'UPI',
                        ),
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
                    'Continue to UPI · ₹${widget.totalAmount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
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
