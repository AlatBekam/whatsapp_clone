import 'package:flutter/material.dart';

class CustomElevatedButtonTheme {
  CustomElevatedButtonTheme._();

  static light() {
    return ElevatedButtonThemeData(
      // style: ButtonStyle(
      //   elevation: 0,
      //   shadowColor: Colors.transparent,
      //   backgroundColor: Colors.white,
      //   foregroundColor: Colors.black,
      // ),
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: Color(0xFF25D366),
        foregroundColor: Colors.black,
        textStyle: TextStyle(),
      ),
    );
    // return ElevatedButton.styleFrom(
    //   elevation: 0,
    //   shadowColor: Colors.transparent,
    //   backgroundColor: Colors.white,
    //   foregroundColor: Colors.black,
    // );
  }

  static dark() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: Color(0xFF25D366),
        foregroundColor: Colors.white,
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: TextStyle(),
      ),
    );
  }
}
