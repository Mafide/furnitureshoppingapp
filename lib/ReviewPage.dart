import 'package:flutter/material.dart';
import 'package:furnituree/AddToCartPage.dart';
import 'package:furnituree/home_page.dart';
import 'package:furnituree/profilepage.dart';
import 'custom_bottom_navbar.dart';


class ReviewPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const ReviewPage({super.key, required this.product});

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final TextEditingController _commentController = TextEditingController();
  String? _imagePath;
  final List<Map<String, dynamic>> _reviews = [
    {
      'profileImage': 'assets/profile.jpg',
      'reviewImage': 'assets/Ottoman.webp',
      'comment': 'This is a great piece of furniture! Very stylish and comfortable.',
      'likes': 5,
      'comments': [
        {
          'profileImage': 'assets/profile.jpg',
          'comment': 'Great product!',
        },
        {
          'profileImage': 'assets/accent.jpg',
          'comment': 'Highly recommended!',
        },
        {
          'profileImage': 'assets/profile.jpg',
          'comment': 'Excellent quality!',
        }
      ]
    },
    // Other reviews...
  ];

  void _addReview() {
    if (_commentController.text.isNotEmpty) {
      setState(() {
        _reviews.add({
          'profileImage': 'assets/profile.jpg',
          'reviewImage': _imagePath ?? 'assets/accent.jpg',
          'comment': _commentController.text,
          'likes': 0,
          'comments': [],
        });
        _commentController.clear();
        _imagePath = null;
      });
      _showSubmissionDialog();
    }
  }

  void _showSubmissionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Review Submitted'),
          content: Text('Thank you for your review! It has been successfully submitted.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _likeReview(int index) {
    setState(() {
      _reviews[index]['likes']++;
    });
  }

  void _viewComments(int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Comments', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              if (_reviews[index]['comments'] != null)
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _reviews[index]['comments']!.length,
                    itemBuilder: (context, commentIndex) {
                      final commentData = _reviews[index]['comments']![commentIndex];
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(commentData['profileImage']),
                              radius: 20,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                commentData['comment'],
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              SizedBox(height: 16),
              TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  labelText: 'Add a comment',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_commentController.text.isNotEmpty) {
                    setState(() {
                      _reviews[index]['comments']!.add({
                        'profileImage': 'assets/accent.jpg',
                        'comment': _commentController.text,
                      });
                    });
                    _commentController.clear();
                  }
                },
                child: Text('Add Comment'),
              ),
            ],
          ),
        );
      },
    );
  }

  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else if (index == 1) {
      Map<String, String> product = {
        'id': '1',
        'name': 'Bar Stools',
        'description': 'Chic bar stools for home decor.',
        'price': '300',
        'image': 'bar.webp',
      };
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddToCartPage(),
        ),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review ${widget.product['name']}'),
        backgroundColor: Color(0xFFD3D3D3),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add Your Review',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      labelText: 'Your Comment',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.comment),
                    ),
                    maxLines: 5,
                    minLines: 1,
                  ),
                  SizedBox(height: 16),
                  _imagePath == null
                      ? TextButton.icon(
                          onPressed: _selectImage,
                          icon: Icon(Icons.camera_alt),
                          label: Text('Select Image'),
                        )
                      : Image.asset(_imagePath!, height: 100, width: 100),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _addReview,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: Text(
                      'Submit Review',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 32),
                  Text(
                    'Reviews',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 300, 
                    child: ListView.builder(
                      itemCount: _reviews.length,
                      itemBuilder: (context, index) {
                        final review = _reviews[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: AssetImage(review['profileImage']),
                              radius: 25,
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(review['reviewImage'], height: 150, width: double.infinity, fit: BoxFit.cover),
                                SizedBox(height: 8),
                                Text(
                                  review['comment'],
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.thumb_up),
                                      onPressed: () => _likeReview(index),
                                    ),
                                    Text('${review['likes']} Likes'),
                                    Spacer(),
                                    IconButton(
                                      icon: Icon(Icons.comment),
                                      onPressed: () => _viewComments(index),
                                    ),
                                    
                                    if (review['profileImage'] == 'assets/accent.jpg')
                                      IconButton(
                                        icon: Icon(Icons.delete, color: Colors.red),
                                        onPressed: () {
                                          setState(() {
                                            _reviews.removeAt(index);
                                          });
                                        },
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(context: context),
    );
  }

  void _selectImage() async {
    setState(() {
      _imagePath = 'assets/accent.jpg';
      _imagePath = 'assets/velvet.jpg';
      _imagePath = 'assets/corner.jpg';
    });
  }
}
