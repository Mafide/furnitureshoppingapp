import 'package:flutter/material.dart';
import 'dart:async';
import 'splash_screen.dart'; // Import the SplashScreen class

class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({super.key});

  @override
  _SplashScreen1State createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {
  @override
  void initState() {
    super.initState();

    // Navigate to SplashScreen after a 3-second delay
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => SplashScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(200, 200, 200, 0.64), // Set the background color
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.chair,
                size: 120, // Increased the icon size
                color: Colors.black,
              ),
              SizedBox(height: 20),
              Text(
                'FURNITURE',
                style: TextStyle(
                  fontSize: 36, // Increased font size
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'BEST QUALITY',
                style: TextStyle(
                  fontSize: 24, // Increased font size
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 30), // Space before the loading indicator
              CircularProgressIndicator(
                color: Colors.black,
                strokeWidth: 2.0, // Adjust thickness of the indicator
              ),
            ],
          ),
        ),
      ),
    );
  }
}
