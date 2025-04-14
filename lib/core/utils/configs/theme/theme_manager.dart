import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Inter',
      primaryColor: const Color(0xff9C2CF3),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: const Color(0xff9C2CF3),
        secondary: const Color(0xff3A49F9),
      ),
      textTheme: TextTheme(
          labelSmall: TextStyle(
              fontSize: 22.42.sp,
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins'),
          labelMedium: TextStyle(
              fontSize: 24.sp,
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins'),
          displayLarge: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 46.17.sp,
            height: 1,
            color: Color(0xff2E3A59),
          ),
          displayMedium: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 32.sp,
            height: 1,
            color: Color(0xff2E3A59),
          ),
          displaySmall: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 23.09.sp,
            height: 1,
            color: Color(0xff2E3A59),
          ),
          headlineLarge: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 64.sp,
            height: 1.3,
            letterSpacing: -0.02 * 64,
            color: Color(0xff111827),
          ),
          bodyMedium: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20.sp,
            height: 1.4,
            letterSpacing: -0.2,
            color: const Color(0xFF6C7278),
          ),
          labelLarge: TextStyle(
              fontWeight: FontWeight.w600,
              color: const Color(0xff4D81E7),
              fontSize: 20.sp),
          bodySmall: TextStyle(
            fontWeight: FontWeight.w500,
            height: 1.4,
            letterSpacing: -0.2,
            color: const Color(0xFF000000),
          ),
          titleSmall: TextStyle(
              fontWeight: FontWeight.w500,
              height: 1.4,
              letterSpacing: -0.2,
              color: const Color(0xFF6C7278),
              fontSize: 16.sp)),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE4E4E7)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE4E4E7)),
        ),
        hintStyle: TextStyle(
          fontWeight: FontWeight.w500,
          height: 1.4,
          letterSpacing: -0.2,
          color: const Color(0xFF6C7278),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff9C2CF3),
          foregroundColor: Colors.white,
          elevation: 8,
          shadowColor: const Color(0xff375DFB),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Color(0xff9C2CF3), width: 1),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
    );
  }
}
