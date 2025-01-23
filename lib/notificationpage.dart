import 'package:flutter/material.dart';

import 'custom_bottom_navbar.dart';

class NotificationPage extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {
      'image': 'assets/coll.jpg',
      'title': 'New Chair Collection',
      'description': 'Check out our new collection of chairs!',
      'postedDate': '2024-12-28',
    },
    {
      'image': 'assets/sofas.jpg',
      'title': 'Exclusive Sofa Sale',
      'description': 'Get up to 50% off on select sofas.',
      'postedDate': '2024-12-27',
    },
    {
      'image': 'assets/luxury.webp',
      'title': 'Luxury Beds on Sale',
      'description': 'Luxury beds now available at discounted prices.',
      'postedDate': '2024-12-26',
    },
    {
      'image': 'assets/luxtable.jpg',
      'title': 'Luxury Tabels on Sale',
      'description': 'Luxury Tables now available at discounted prices.',
      'postedDate': '2024-12-26',
    },
  ];

  NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Center '),
        backgroundColor: Color(0xFFD3D3D3),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.asset(
                      notification['image']!,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notification['title']!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          notification['description']!,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Posted on: ${notification['postedDate']}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(context: context),
    );
  }
}
