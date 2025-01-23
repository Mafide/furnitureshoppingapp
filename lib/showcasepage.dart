import 'package:flutter/material.dart';
import 'AddToCartPage.dart';
import 'ReviewPage.dart';
import 'custom_bottom_navbar.dart';
import 'home_page.dart';
import 'profilepage.dart';
import 'wishlistpage.dart';

class ShowcasePage extends StatelessWidget {
  final List<Map<String, String>> showrooms = [
    {
      'title': 'Elegant Living Room',
      'image': 'showroom1.jpg',
    },
    {
      'title': 'Modern Bedroom',
      'image': 'modernbedrooom.webp',
    },
    {
      'title': 'Stylish Kitchen',
      'image': 'stylish.jpeg',
    },
    {
      'title': 'Cozy Dining Area',
      'image': 'cozy.webp',
    },
    {
      'title': 'Luxurious Office',
      'image': 'luxury.jpg',
    },
  ];

  ShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Showcase'),
        backgroundColor: Color(0xFFD3D3D3),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: showrooms.map((showroom) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Stack(
                children: [
                  Card(
                    margin: EdgeInsets.all(16),
                    elevation: 5,
                    child: Image.asset(
                      'assets/${showroom['image']}',
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 0,
                    right: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          showroom['title']!,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                offset: Offset(1, 1),
                                blurRadius: 4,
                                color: Colors.black45,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal.withOpacity(0.9),
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage()),
                            );
                          },
                          child: Text(
                            'Shop Now',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(context: context),
    );
  }
}
