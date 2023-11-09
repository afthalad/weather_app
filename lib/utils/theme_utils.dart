import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

final ThemeData themeData = ThemeData(
  textTheme: GoogleFonts.poppinsTextTheme(
    TextTheme(
      titleLarge: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 30.sp,
      ),
      titleMedium: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 10.sp,
      ),
      titleSmall: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w300,
        fontSize: 10.sp,
      ),
    ),
  ),
);
