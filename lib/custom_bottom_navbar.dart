import 'package:flutter/material.dart';
import 'AddToCartPage.dart';
import 'ReviewPage.dart';
import 'home_page.dart';
import 'profilepage.dart';
import 'wishlistpage.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key, required BuildContext context});

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0; // Tracks the selected index

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AddToCartPage()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => WishlistPage()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ReviewPage(
              product: {
                'id': '1',
                'name': 'Furniture',
                'description': 'High-quality furniture',
                'price': '100',
                'image': 'round.jpg',
              },
            ),
          ),
        );
        break;
      case 4:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex, // Set the current selected index
      selectedItemColor: Colors.teal, // Color for selected icon
      unselectedItemColor: Colors.grey, // Color for unselected icons
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: "Add to Cart",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: "Wishlist",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.reviews),
          label: "Reviews",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        ),
      ],
      onTap: _onItemTapped, // Update the selected index when an item is tapped
    );
  }
}
