import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  ThemeData get lightTheme => ThemeData(
        primarySwatch: Colors.teal,
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFD3D3D3), // Light mode app bar background color
          foregroundColor: Colors.black,     // Text/icon color for light mode
          titleTextStyle: TextStyle(         // Explicit text style for the title
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: Colors.black,             // Icon color for light mode
          ),
        ),
      );

  ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.teal,
        scaffoldBackgroundColor: Color(0xFF121212), // Dark mode background color
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF212121), // Dark mode app bar background color
          foregroundColor: Colors.black,     // Override default white text color
          titleTextStyle: TextStyle(
            color: Colors.black,             // Explicitly set the title text color
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: Colors.black,             // Icon color for dark mode
          ),
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(color: Colors.black), // App bar text uses headline6
        ),
      );

  void toggleTheme(bool value) {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
