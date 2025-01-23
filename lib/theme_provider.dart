import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  ThemeData get lightTheme => ThemeData(
        primarySwatch: Colors.teal,
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFD3D3D3), 
          foregroundColor: Colors.black,    
          titleTextStyle: TextStyle(         
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: Colors.black,             
          ),
        ),
      );

  ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.teal,
        scaffoldBackgroundColor: Color(0xFF121212),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF212121), 
          foregroundColor: Colors.black,    
          titleTextStyle: TextStyle(
            color: Colors.black,            
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: Colors.black,             
          ),
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(color: Colors.black), 
        ),
      );

  void toggleTheme(bool value) {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
