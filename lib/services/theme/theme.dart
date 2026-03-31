import 'package:flutter/material.dart';
import 'package:whatsapp_clone/services/theme/custom_elevated_button_theme.dart';
import 'package:whatsapp_clone/services/theme/custom_text_theme.dart';

class warna {
  warna._();

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

class CustomAppTheme {
  // Jika kita mendeklarasikan class dengan ._(), maka kita mendelkarasikan class tersebut sebagai private class. Artinya, class tersebut hanya berisikan value static yang tidak bisa diinstance diluar dari class tersebut.
  CustomAppTheme._();

  static light() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFF25D366),
        onPrimary: HSLColor.fromColor(
          Color(0xFF25D366),
        ).withLightness(0.5).toColor(),
        primaryContainer: Color.fromARGB(255, 195, 255, 216),
        onPrimaryContainer: HSLColor.fromColor(
          Color.fromARGB(255, 195, 255, 216),
        ).withLightness(0.5).toColor(),
        secondary: HSLColor.fromColor(
          Colors.white,
        ).withLightness(0.7).toColor(),
        secondaryContainer: HSLColor.fromColor(
          Colors.white,
        ).withLightness(0.5).toColor(),
        onSecondary: Colors.black,
        error: Colors.red,
        onError: Colors.white,
        surface: Colors.white,
        surfaceDim: const Color.fromARGB(255, 202, 202, 202),
        onSurface: Colors.black,
        onSurfaceVariant: const Color.fromARGB(255, 39, 39, 39),
      ),
      textTheme: CustomTextTheme.light(),

      elevatedButtonTheme: CustomElevatedButtonTheme.light(),
    );
  }

  static dark() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xFF25D366),
        onPrimary: HSLColor.fromColor(
          Color(0xFF25D366),
        ).withLightness(0.5).toColor(),
        primaryContainer: Color.fromARGB(255, 195, 255, 216),
        onPrimaryContainer: HSLColor.fromColor(
          Color.fromARGB(255, 195, 255, 216),
        ).withLightness(0.5).toColor(),
        secondary: HSLColor.fromColor(
          Colors.white,
        ).withLightness(0.7).toColor(),
        secondaryContainer: HSLColor.fromColor(
          Colors.white,
        ).withLightness(0.5).toColor(),
        onSecondary: Colors.white,
        error: Colors.red,
        onError: Colors.black,
        surface: Colors.black,
        surfaceDim: const Color.fromARGB(255, 29, 29, 29),
        onSurface: Colors.white,
        onSurfaceVariant: const Color.fromARGB(255, 196, 196, 196),
      ),

      textTheme: CustomTextTheme.dark(),

      elevatedButtonTheme: CustomElevatedButtonTheme.dark(),
    );
  }
  
}
