import 'package:flutter/material.dart';

class warna {
  static Hitam() => Colors.black;
  static Putih() => Colors.white;
  static buttonPutih() => const Color.fromARGB(255, 238, 238, 238);
  static Hijau() => Color(0xFF25D366);
  static buttonHijau() => Color.fromARGB(255, 195, 255, 216);
  static HijauTua() => Color.fromARGB(255, 13, 85, 39);
  static Transparan() => Colors.transparent;
  static AbuAbu() => Color.fromARGB(255, 200, 200, 200);
  static AbuAbuTua() => Color.fromARGB(255, 98, 97, 97);
  static Merah() => const Color.fromARGB(255, 255, 89, 78);
  // static Hitam() => Colors.black;
}

class AppTheme {
  static light() {
    return ThemeData(
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: Color(value),
        onPrimary: onPrimary,
        secondary: secondary,
        onSecondary: onSecondary,
        error: error,
        onError: onError,
        surface: surface,
        onSurface: onSurface,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(),

      textTheme: TextTheme(bodyLarge: TextStyle()),
      listTileTheme: ListTileThemeData(),
      inputDecorationTheme: InputDecorationTheme(),
    );
  }

  static dark() {
    return ThemeData();
  }
}
