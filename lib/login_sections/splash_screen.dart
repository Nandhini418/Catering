import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:catering/constants/app_colors.dart';
import 'package:catering/login_sections/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Navigate to LoginScreen after 3 seconds
    _timer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Set status bar to transparent with light icons
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          // Top Golden Background
          Container(
            width: double.infinity,
            height: double.infinity,
            color: AppColors.primary,
          ),

          // Caterers Image Logo
          Positioned(
            top: 116.h,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/splash_logo.png',
              width: 460.w,
              fit: BoxFit.contain,
            ),
          ),

          // Bottom White Card / Sheet with Smooth Curved Dome Arch
          Positioned.fill(
            child: ClipPath(
              clipper: SplashScreenCurveClipper(),
              child: Container(
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom Clipper that shapes the dome-like curve separating
/// the top golden catering section from the bottom white screen area.
/// All curve dimensions use ScreenUtil (.h, .w) for responsive adaptation.
class SplashScreenCurveClipper extends CustomClipper<Path> {
  const SplashScreenCurveClipper();

  @override
  Path getClip(Size size) {
    final Path path = Path();

    // The starting height on the left and right edges (scaled with ScreenUtil)
    final double startY = 505.h;

    // The peak of the dome arch in the horizontal center
    final double peakY = 411.h;

    // For a quadratic Bézier curve where the midpoint at t=0.5 reaches peakY:
    // B(0.5) = (startY + controlY) / 2 => controlY = 2 * peakY - startY
    final double controlY = 2 * peakY - startY;

    // Start at the left edge
    path.moveTo(0, startY);

    // Smooth quadratic curve to the right edge with peak at horizontal center
    path.quadraticBezierTo(
      size.width / 2,
      controlY,
      size.width,
      startY,
    );

    // Complete the path covering the entire lower half
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
