import 'package:flutter/material.dart';
import 'AddToCartPage.dart';
import 'custom_bottom_navbar.dart';
import 'product_details.dart';
import 'ReviewPage.dart';
import 'home_page.dart';
import 'profilepage.dart';
import 'auth_service.dart'; 

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final AuthService authService = AuthService(); 
  List<Map<String, dynamic>> wishlist = [];

  @override
  void initState() {
    super.initState();
    
    _loadWishlist();
  }

  
  Future<void> _loadWishlist() async {
    try {
      List<Map<String, dynamic>> fetchedWishlist =
          await authService.getWishlist();
      setState(() {
        wishlist = fetchedWishlist;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading wishlist: $e')),
      );
    }
  }

  // Remove item from wishlist
  Future<void> _removeFromWishlist(int index) async {
    try {
      // Remove the item locally
      setState(() {
        wishlist.removeAt(index);
      });

      // Update the wishlist in Firestore
      await authService.updateWishlist(wishlist);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error removing item from wishlist: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wishlist"),
        backgroundColor: const Color(0xFFD3D3D3),
      ),
      body: wishlist.isEmpty
          ? const Center(
              child: Text(
                "Your wishlist is currently empty.",
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            )
          : ListView.builder(
              itemCount: wishlist.length,
              itemBuilder: (context, index) {
                final item = wishlist[index];
                return ListTile(
                  leading: Image.asset('assets/${item['image']}'),
                  title: Text(item['name']),
                  subtitle: Text("\$${item['price']}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      
                      _removeFromWishlist(index);
                    },
                  ),
                  onTap: () {
                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsPage(
                          name: item['name'],
                          image: item['image'],
                          description: item['description'],
                          price: item['price'].toString(), product: {},
                        ),
                      ),
                    );
                  },
                );
              },
            ),
      bottomNavigationBar: CustomBottomNavBar(context: context),
    );
  }
}
