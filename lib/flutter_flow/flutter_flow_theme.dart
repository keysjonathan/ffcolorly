import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: avoid_classes_with_only_static_members
class FlutterFlowTheme {
  static const Color primaryColor = Color(0xFFE5831D);
  static const Color secondaryColor = Color(0xFF63CF93);
  static const Color tertiaryColor = Color(0xFF39D23D);

  static const Color customColor1 = Color(0xFFE5831D);
  static const Color customColor2 = Color(0xFF2F2F2F);
  static const Color customColor3 = Color(0xFFDDDDDD);
  static const Color customColor4 = Color(0xFFE5471D);

  String primaryFontFamily = 'Poppins';
  String secondaryFontFamily = 'Roboto';

  static TextStyle get title1 => GoogleFonts.getFont(
        'Poppins',
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 32,
      );
  static TextStyle get title2 => GoogleFonts.getFont(
        'Quicksand',
        color: primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 28,
      );
  static TextStyle get title3 => GoogleFonts.getFont(
        'Roboto',
        color: secondaryColor,
        fontWeight: FontWeight.w600,
        fontSize: 24,
      );
  static TextStyle get subtitle1 => GoogleFonts.getFont(
        'Poppins',
        color: Color(0xFF424242),
        fontWeight: FontWeight.bold,
        fontSize: 20,
      );
  static TextStyle get subtitle2 => GoogleFonts.getFont(
        'Quicksand',
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 18,
      );
  static TextStyle get bodyText1 => GoogleFonts.getFont(
        'Roboto',
        color: Colors.white,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
  static TextStyle get bodyText2 => GoogleFonts.getFont(
        'Quicksand',
        color: Color(0xFF424242),
        fontWeight: FontWeight.w300,
        fontSize: 14,
      );
}

extension TextStyleHelper on TextStyle {
  TextStyle override(
          {String fontFamily,
          Color color,
          double fontSize,
          FontWeight fontWeight,
          FontStyle fontStyle}) =>
      GoogleFonts.getFont(
        fontFamily,
        color: color ?? this.color,
        fontSize: fontSize ?? this.fontSize,
        fontWeight: fontWeight ?? this.fontWeight,
        fontStyle: fontStyle ?? this.fontStyle,
      );
}
