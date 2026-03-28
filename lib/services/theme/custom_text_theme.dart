import 'package:flutter/material.dart';

class CustomTextTheme {
  CustomTextTheme._();

  static light() {
    double ukText = 21;
    var warna = Colors.black;
    return TextTheme(
      labelLarge: TextStyle().copyWith(color: warna),
      labelMedium: TextStyle().copyWith(color: warna),
      labelSmall: TextStyle().copyWith(color: warna),
      headlineLarge: TextStyle().copyWith(color: warna),
      displayLarge: TextStyle().copyWith(color: warna),
      displayMedium: TextStyle().copyWith(color: warna),
      displaySmall: TextStyle().copyWith(color: warna),
    );
  }

  static dark() {
    double ukText = 21;
    var warna = Colors.white;
    return TextTheme(
      labelLarge: TextStyle().copyWith(color: warna),
      labelMedium: TextStyle().copyWith(color: warna),
      labelSmall: TextStyle().copyWith(color: warna),
      headlineLarge: TextStyle().copyWith(color: warna),
      displayLarge: TextStyle().copyWith(color: warna),
      displayMedium: TextStyle().copyWith(color: warna),
      displaySmall: TextStyle().copyWith(color: warna),
    );
  }
}
