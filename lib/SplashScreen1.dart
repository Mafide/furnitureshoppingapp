import 'package:flutter/material.dart';
import 'dart:async';
import 'splash_screen.dart'; 

class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({super.key});

  @override
  _SplashScreen1State createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {
  @override
  void initState() {
    super.initState();

    
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
        color: Color.fromRGBO(200, 200, 200, 0.64), 
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.chair,
                size: 120, 
                color: Colors.black,
              ),
              SizedBox(height: 20),
              Text(
                'FURNITURE',
                style: TextStyle(
                  fontSize: 36, 
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'BEST QUALITY',
                style: TextStyle(
                  fontSize: 24, 
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 30), 
              CircularProgressIndicator(
                color: Colors.black,
                strokeWidth: 2.0, 
              ),
            ],
          ),
        ),
      ),
    );
  }
}
