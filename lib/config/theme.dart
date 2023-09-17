import 'package:flutter/material.dart';

class AppThemeData {
  static final ThemeData lightMode = ThemeData(
    primaryColor: const Color.fromARGB(255, 0, 96, 164),
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color.fromARGB(255, 253, 252, 255),
    colorScheme: const ColorScheme(
      primary: Color.fromARGB(255, 0, 96, 164),
      primaryContainer: Color.fromARGB(255, 209, 228, 255),
      onPrimaryContainer: Color.fromARGB(255, 0, 29, 54),
      secondary: Color.fromARGB(255, 83, 95, 112),
      surface: Color.fromARGB(255, 253, 252, 255),
      background: Color.fromARGB(255, 253, 252, 255),
      error: Color.fromARGB(255, 216, 37, 37),
      onPrimary: Color.fromARGB(255, 253, 252, 255),
      onSecondary: Color.fromARGB(255, 253, 252, 255),
      onSurface: Color.fromARGB(255, 62, 72, 93),
      onBackground: Color.fromARGB(255, 62, 72, 93),
      onError: Color.fromARGB(255, 201, 18, 18),
      brightness: Brightness.light,
      tertiary: Color.fromARGB(255, 107, 87, 120),
      tertiaryContainer: Color.fromARGB(255, 242, 218, 255),
      onTertiary: Color.fromARGB(255, 255, 255, 255),
      onTertiaryContainer: Color.fromARGB(255, 37, 20, 49),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      bodySmall: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      displayLarge: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      labelLarge: TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.bold,
      ),
      labelMedium: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      labelSmall: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  static final ThemeData darkMode = ThemeData(
    primaryColor: const Color.fromARGB(255, 0, 159, 255),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color.fromARGB(255, 32, 32, 32),
    colorScheme: const ColorScheme(
        primary: Color.fromARGB(255, 0, 159, 255),
        primaryContainer: Color.fromARGB(255, 46, 54, 77),
        onPrimaryContainer: Color.fromARGB(255, 255, 226, 177),
        secondary: Color.fromARGB(255, 172, 160, 143),
        surface: Color.fromARGB(255, 32, 32, 32),
        background: Color.fromARGB(255, 32, 32, 32),
        error: Color.fromARGB(255, 216, 37, 37),
        onPrimary: Color.fromARGB(255, 32, 32, 32),
        onSecondary: Color.fromARGB(255, 32, 32, 32),
        onSurface: Color.fromARGB(255, 193, 183, 162),
        onBackground: Color.fromARGB(255, 32, 32, 32),
        onError: Color.fromARGB(255, 201, 18, 18),
        brightness: Brightness.dark,
        tertiary: Color.fromARGB(255, 148, 168, 135),
        tertiaryContainer: Color.fromARGB(255, 13, 37, 66),
        onTertiary: Color.fromARGB(255, 32, 32, 32),
        onTertiaryContainer: Color.fromARGB(255, 218, 235, 255)),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodySmall: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      displayLarge: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      displayMedium: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      displaySmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      labelLarge: TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      labelMedium: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      labelSmall: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}
