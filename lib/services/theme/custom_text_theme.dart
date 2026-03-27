import 'package:flutter/material.dart';

class CustomTextTheme {
  CustomTextTheme._();

  static light() {
    double ukText = 21;
    var warna = Colors.black;
    return TextTheme(
      labelLarge: TextStyle().copyWith(fontSize: ukText, color: warna),
      labelMedium: TextStyle().copyWith(fontSize: ukText - 5, color: warna),
      labelSmall: TextStyle().copyWith(fontSize: ukText - 7, color: warna),
      headlineLarge: TextStyle().copyWith(fontSize: ukText - 2, color: warna),
      displayLarge: TextStyle().copyWith(fontSize: ukText, color: warna),
      displayMedium: TextStyle().copyWith(fontSize: ukText - 2, color: warna),
      displaySmall: TextStyle().copyWith(fontSize: ukText - 5, color: warna),
    );
  }

  static dark() {
    double ukText = 21;
    var warna = Colors.white;
    return TextTheme(
      labelLarge: TextStyle().copyWith(fontSize: ukText, color: warna),
      labelMedium: TextStyle().copyWith(fontSize: ukText - 5, color: warna),
      labelSmall: TextStyle().copyWith(fontSize: ukText - 7, color: warna),
      headlineLarge: TextStyle().copyWith(fontSize: ukText - 2, color: warna),
      displayLarge: TextStyle().copyWith(fontSize: ukText, color: warna),
      displayMedium: TextStyle().copyWith(fontSize: ukText - 2, color: warna),
      displaySmall: TextStyle().copyWith(fontSize: ukText - 5, color: warna),
    );
  }
}
