import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:catering/constants/app_colors.dart';
import 'package:catering/agent_sections/payments/pay_with_upi_screen.dart';
import 'package:catering/agent_sections/payments/card_payment_screen.dart';
import 'package:catering/agent_sections/payments/payment_overdue_screen.dart';
import 'package:catering/agent_sections/payments/new_bookings_paused_screen.dart';
import 'package:catering/agent_sections/payments/account_on_hold_screen.dart';

class PayShiftScreen extends StatefulWidget {
  final String venue;
  final int boys;
  final int shifts;
  final int ratePerBoy;
  final int totalAmount;
  final String timeRemaining;

  const PayShiftScreen({
    super.key,
    this.venue = 'Annai Mahal, Peelamedu',
    this.boys = 10,
    this.shifts = 1,
    this.ratePerBoy = 400,
    this.totalAmount = 4000,
    this.timeRemaining = '0:54:12',
  });

  @override
  State<PayShiftScreen> createState() => _PayShiftScreenState();
}

class _PayShiftScreenState extends State<PayShiftScreen> {
  // 0 = UPI, 1 = Card or bank
  int _selectedPaymentMethod = 0;

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
                    'Clear shift payment within 1 hour to maintain your agent rating.',
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
                      'Pay for the shift',
                      style: GoogleFonts.inter(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0F2D24),
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Pay within 1 hour banner (warm yellow/cream)
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
                          Row(
                            children: [
                              Text(
                                'Pay within 1 hour · ',
                                style: GoogleFonts.inter(
                                  fontSize: 14.5.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFFB45309),
                                ),
                              ),
                              Text(
                                widget.timeRemaining,
                                style: GoogleFonts.inter(
                                  fontSize: 14.5.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFFC2410C),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            'Shift marked complete. Spot payment keeps your account active.',
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              color: const Color(0xFF9A5B13),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Shift Breakdown Card
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20.r),
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
                          _buildDetailRow('Boys', '${widget.boys}'),
                          SizedBox(height: 12.h),
                          _buildDetailRow('Shifts', '${widget.shifts}'),
                          SizedBox(height: 12.h),
                          _buildDetailRow(
                            'Rate per boy',
                            '₹${widget.ratePerBoy}',
                          ),
                          SizedBox(height: 14.h),
                          const Divider(color: Color(0xFFF1F5F9), height: 1),
                          SizedBox(height: 14.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total to pay',
                                style: GoogleFonts.inter(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F2D24),
                                ),
                              ),
                              Text(
                                '₹${widget.totalAmount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                                style: GoogleFonts.inter(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xFF0E6347),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Pay using Selector
                    Text(
                      'Pay using',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F2D24),
                      ),
                    ),
                    SizedBox(height: 12.h),

                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () =>
                                setState(() => _selectedPaymentMethod = 0),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              decoration: BoxDecoration(
                                color: _selectedPaymentMethod == 0
                                    ? const Color(0xFFE6F4EA)
                                    : AppColors.white,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: _selectedPaymentMethod == 0
                                      ? const Color(0xFF0E6347)
                                      : const Color(0xFFCBD5E1),
                                  width: _selectedPaymentMethod == 0 ? 1.5 : 1.0,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'UPI',
                                style: GoogleFonts.inter(
                                  fontSize: 14.5.sp,
                                  fontWeight: _selectedPaymentMethod == 0
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  color: _selectedPaymentMethod == 0
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
                            onTap: () =>
                                setState(() => _selectedPaymentMethod = 1),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              decoration: BoxDecoration(
                                color: _selectedPaymentMethod == 1
                                    ? const Color(0xFFE6F4EA)
                                    : AppColors.white,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: _selectedPaymentMethod == 1
                                      ? const Color(0xFF0E6347)
                                      : const Color(0xFFCBD5E1),
                                  width: _selectedPaymentMethod == 1 ? 1.5 : 1.0,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Card or bank',
                                style: GoogleFonts.inter(
                                  fontSize: 14.5.sp,
                                  fontWeight: _selectedPaymentMethod == 1
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  color: _selectedPaymentMethod == 1
                                      ? const Color(0xFF0E6347)
                                      : const Color(0xFF64748B),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 18.h),

                    // Admin notice
                    Text(
                      '₹300 per boy was already paid automatically to each supplier. This payment goes to the admin.',
                      style: GoogleFonts.inter(
                        fontSize: 12.5.sp,
                        color: const Color(0xFF64748B),
                        height: 1.45,
                      ),
                    ),
                    SizedBox(height: 28.h),

                    // Test escalation scenarios expansion tile
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(14.r),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: const Color(0xFFE2E8F0),
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Preview Overdue & Escalation Flows',
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF475569),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Wrap(
                            spacing: 8.w,
                            runSpacing: 8.h,
                            children: [
                              _buildFlowPill(
                                label: '1) Overdue (1 hr)',
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const PaymentOverdueScreen(),
                                  ),
                                ),
                              ),
                              _buildFlowPill(
                                label: '2) Paused (2 hrs)',
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const NewBookingsPausedScreen(),
                                  ),
                                ),
                              ),
                              _buildFlowPill(
                                label: '3) On Hold (24 hrs)',
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const AccountOnHoldScreen(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),

            // Bottom Primary Button: Pay ₹4,000
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
                    if (_selectedPaymentMethod == 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PayWithUpiScreen(
                            venue: widget.venue,
                            totalAmount: widget.totalAmount,
                            boys: widget.boys,
                            shifts: widget.shifts,
                          ),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CardPaymentScreen(
                            venue: widget.venue,
                            totalAmount: widget.totalAmount,
                            boys: widget.boys,
                            shifts: widget.shifts,
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Pay ₹${widget.totalAmount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
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

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14.5.sp,
            color: const Color(0xFF64748B),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 14.5.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0F2D24),
          ),
        ),
      ],
    );
  }

  Widget _buildFlowPill({required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: const Color(0xFFCBD5E1)),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0F766E),
          ),
        ),
      ),
    );
  }
}
