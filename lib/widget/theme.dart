import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color blueClr = Color(0xFF4e5ae8);
const Color yellowClr = Color(0xFFFFB746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const Color darkGreyClr = Color(0xFF122323);
const Color primaryClr = blueClr;
Color darkHeaderClr = Color(0xFF424242);

class Themes {
  Color backgroundColor = darkGreyClr;
  static final light = ThemeData(
    appBarTheme: AppBarTheme(
      color: Colors.white,
    ),
    brightness: Brightness.light,
  );
  static final dark = ThemeData(
    appBarTheme: AppBarTheme(
      color: darkGreyClr,
    ),
    brightness: Brightness.dark,
  );
}

TextStyle get HeadingStyle1 {
  return GoogleFonts.lato(
      textStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      color: Get.isDarkMode ? Colors.white : Colors.grey[700]);
}

TextStyle get HeadingStyle2 {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
    color: Get.isDarkMode ? Colors.white : Colors.black,
  );
}

TextStyle get HeadingStyle3 {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 23,
      fontWeight: FontWeight.bold,
    ),
    color: Get.isDarkMode ? Colors.white : Color.fromARGB(221, 32, 32, 32),
  );
}

TextStyle get subtitleStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
  );
}
