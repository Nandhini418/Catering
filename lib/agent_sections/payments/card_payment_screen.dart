import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:catering/constants/app_colors.dart';
import 'package:catering/agent_sections/payments/bank_payment_screen.dart';
import 'package:catering/agent_sections/payments/payment_successful_screen.dart';

class CardPaymentScreen extends StatefulWidget {
  final String venue;
  final int totalAmount;
  final int boys;
  final int shifts;

  const CardPaymentScreen({
    super.key,
    this.venue = 'Annai Mahal, Peelamedu',
    this.totalAmount = 4000,
    this.boys = 10,
    this.shifts = 1,
  });

  @override
  State<CardPaymentScreen> createState() => _CardPaymentScreenState();
}

class _CardPaymentScreenState extends State<CardPaymentScreen> {
  final _cardNumberController = TextEditingController();
  final _nameController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  bool _saveCard = false;

  @override
  void dispose() {
    _cardNumberController.dispose();
    _nameController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
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
                    'All credit and debit cards processed with 256-bit encryption.',
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
                      'Card payment',
                      style: GoogleFonts.inter(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0F2D24),
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Mint Green Amount to Pay Box
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(
                          color: const Color(0xFFC8E6C9),
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Amount to pay · ₹${widget.totalAmount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                            style: GoogleFonts.inter(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1B5E20),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            '${widget.venue.split(',').first.trim()} · ${widget.boys} boys · ${widget.shifts} ${widget.shifts == 1 ? 'shift' : 'shifts'}',
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              color: const Color(0xFF2E7D32),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Card Number Field
                    Text(
                      'Card number',
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
                        controller: _cardNumberController,
                        keyboardType: TextInputType.number,
                        style: GoogleFonts.inter(
                          fontSize: 15.sp,
                          color: const Color(0xFF0F2D24),
                        ),
                        decoration: InputDecoration(
                          hintText: 'Enter card number',
                          prefixIcon: Icon(
                            Icons.credit_card,
                            color: const Color(0xFF94A3B8),
                            size: 20.r,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 14.h,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Cardholder Name Field
                    Text(
                      'Cardholder name',
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
                        controller: _nameController,
                        textCapitalization: TextCapitalization.words,
                        style: GoogleFonts.inter(
                          fontSize: 15.sp,
                          color: const Color(0xFF0F2D24),
                        ),
                        decoration: InputDecoration(
                          hintText: 'Name on card',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 14.h,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Expiry & CVV Row
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Expiry',
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
                                  controller: _expiryController,
                                  keyboardType: TextInputType.datetime,
                                  style: GoogleFonts.inter(
                                    fontSize: 15.sp,
                                    color: const Color(0xFF0F2D24),
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'MM / YY',
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                      vertical: 14.h,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 14.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'CVV',
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
                                  controller: _cvvController,
                                  obscureText: true,
                                  keyboardType: TextInputType.number,
                                  style: GoogleFonts.inter(
                                    fontSize: 15.sp,
                                    color: const Color(0xFF0F2D24),
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'CVV',
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                      vertical: 14.h,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // Save card for future payments Checkbox
                    Row(
                      children: [
                        SizedBox(
                          width: 24.r,
                          height: 24.r,
                          child: Checkbox(
                            value: _saveCard,
                            activeColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            onChanged: (val) {
                              setState(() => _saveCard = val ?? false);
                            },
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          'Save card for future payments',
                          style: GoogleFonts.inter(
                            fontSize: 13.5.sp,
                            color: const Color(0xFF0F2D24),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 18.h),

                    // Secure payment box (soft mint)
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
                            'Secure payment',
                            style: GoogleFonts.inter(
                              fontSize: 14.5.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF166534),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Card credentials are not stored in this design. Complete all fields to continue.',
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              color: const Color(0xFF15803D),
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

            // Bottom Buttons
            Container(
              padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 20.h),
              decoration: const BoxDecoration(
                color: AppColors.white,
                border: Border(
                  top: BorderSide(color: Color(0xFFF1F5F9), width: 1),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
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
                              paymentMethod: 'Card',
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
                        'Pay ₹${widget.totalAmount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} securely',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BankPaymentScreen(
                            venue: widget.venue,
                            totalAmount: widget.totalAmount,
                            boys: widget.boys,
                            shifts: widget.shifts,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Choose bank payment',
                      style: GoogleFonts.inter(
                        fontSize: 14.5.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
