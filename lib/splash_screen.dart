import 'package:flutter/material.dart';
import 'login_signup.dart';
import 'create_account_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(200, 200, 200, 0.64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,  // Aligning to top
          children: [
            // Padding before Elegant Simple Furnitures text
            Padding(
              padding: const EdgeInsets.only(top: 71.0, left: 20.0, right: 20.0), // Added padding before the title and left alignment
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,  
                children: [
                  Text(
                    'Elegant\nSimple\nFurnitures.',
                    style: TextStyle(
                      fontSize: 48, 
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 30), 
                ],
              ),
            ),
            
            // Image next
            Center(
              child: Image.asset(
                'assets/clipped.jpg',
                height: 310, // Increase image size
              ),
            ),
            
            SizedBox(height: 30), // Increased space between the image and the next text

            // Affordable home furniture designs & ideas text last
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Affordable home furniture designs & ideas.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),
            ),
            
            Spacer(), // Spacer to push buttons to the bottom
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Sign Up Button
                  Container(
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CreateAccountPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  // Sign In Button
                  Container(
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginSignupPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
