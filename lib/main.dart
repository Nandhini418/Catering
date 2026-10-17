import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:catering/constants/app_colors.dart';
import 'package:catering/login_sections/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(460, 1024),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Catering App',
          theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: AppColors.white,
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primary,
            ),
            fontFamily: GoogleFonts.inter().fontFamily,
            textTheme: GoogleFonts.interTextTheme(
              Theme.of(context).textTheme,
            ),
          ),
          home: const SplashScreen(),
        );
      },
    );
  }
}
