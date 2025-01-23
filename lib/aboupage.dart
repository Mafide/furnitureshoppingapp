import 'package:flutter/material.dart';

import 'custom_bottom_navbar.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD3D3D3),
        elevation: 0,
        title: Text(
          "About the App",
          style: TextStyle(
            color:Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(  // Wrap with SingleChildScrollView to fix overflow
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // App Description
              Text(
                "FurnitureApp is a modern mobile application designed to provide an easy and convenient way to explore and purchase furniture online.",
                style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.bodyLarge?.color),
              ),
              SizedBox(height: 20),
              
              // Features
              Text(
                "Features:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "1. Browse and shop a wide variety of furniture items.\n"
                "2. Detailed product descriptions and images.\n"
                "3. Easy checkout process.\n"
                "4. Wishlist and shopping cart functionalities.\n"
                "5. User profiles for personalized experience.\n"
                "6. Dark and light theme support for better readability.",
                style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.bodyLarge?.color),
              ),
              SizedBox(height: 20),
              
              // Updated Team section (one individual)
              Text(
                "Developer:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "This app was created by a dedicated individual who worked on all aspects of development, including software engineering, user interface design, and mobile application development.",
                style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.bodyLarge?.color),
              ),
              SizedBox(height: 20),
              
              // Contact Information
              Text(
                "Contact Us:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "For any inquiries, feedback, or suggestions, please contact us at:\n"
                "Email: support@furnitureapp.com\n"
                "Phone: +1 (555) 123-4567",
                style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.bodyLarge?.color),
              ),
              SizedBox(height: 20),
              
              // Version
              Text(
                "App Version: 1.0.0",
                style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.bodyLarge?.color),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(context: context),
    );
  }
}
