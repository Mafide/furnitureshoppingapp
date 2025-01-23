import 'package:flutter/material.dart';
import 'AddToCartPage.dart';
import 'custom_bottom_navbar.dart';
import 'global.dart';
import 'wishlistpage.dart';
import 'auth_service.dart';

class ProductDetailsPage extends StatelessWidget {
  final String name;
  final String image;
  final String description;
  final String price;

  const ProductDetailsPage({
    super.key,
    required this.name,
    required this.image,
    required this.description,
    required this.price, required Map<String, String> product,
  });

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService(); // Initialize AuthService

    String additionalDescription = '';
    if (name.toLowerCase().contains('table')) {
      additionalDescription = "Perfectly crafted for your dining room.\n"
          "Available in various sizes and finishes.\n"
          "Durable, easy to clean, and stylish.";
    } else if (name.toLowerCase().contains('cupboard')) {
      additionalDescription = "Spacious and well-organized storage.\n"
          "Perfect for any home or office space.\n"
          "Made with premium materials for longevity.";
    } else if (name.toLowerCase().contains('sofa')) {
      additionalDescription = "Comfortable and stylish seating solution.\n"
          "Available in a variety of fabrics and colors.\n"
          "Designed for everyday comfort and relaxation.";
    } else if (name.toLowerCase().contains('bed')) {
      additionalDescription = "Cozy and durable bed frame.\n"
          "Supports a restful night’s sleep.\n"
          "Available in multiple sizes to fit any room.";
    } else {
      additionalDescription = "Elegant and functional furniture piece.\n"
          "Designed to suit your home and lifestyle.\n"
          "High-quality materials and modern aesthetics.";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: const Color(0xFFD3D3D3),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Image.asset('assets/$image', fit: BoxFit.contain),
            const SizedBox(height: 16),

            // Product Name with Star Ratings
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Product Name
                Expanded(
                  child: Text(
                    name,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8), // Star Ratings
                Row(
                  children: List.generate(5, (index) {
                    return const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 20,
                    );
                  }),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Product Price
            Text(
              "\ETB $price",
              style: const TextStyle(fontSize: 20, color: Colors.green),
            ),
            const SizedBox(height: 8),

            // Product Description
            Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),

            // Additional Details (dynamic description)
            Text(
              additionalDescription,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),

            // Add to Cart Button
            ElevatedButton(
              onPressed: () async {
                // Create a product map
                Map<String, dynamic> product = {
                  'name': name,
                  'image': image,
                  'price': double.tryParse(price) ?? 0.0, // Ensure price is a double
                  'description': description,
                  'quantity': 1, // Default quantity
                };

                try {
                  // Add the product to Firestore cart
                  await authService.addToCart(product);

                  // Show a success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$name added to Cart')),
                  );

                  // Navigate to the AddToCartPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddToCartPage(),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text('Failed to add to cart: ${e.toString()}')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'Add to Cart',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 8),

            // Save to Wishlist Button
            ElevatedButton(
              onPressed: () async {
                // Create a product map for wishlist
                Map<String, dynamic> wishlistItem = {
                  'name': name,
                  'image': image,
                  'price': price,
                  'description': description,
                };

                try {
                  // Add the product to Firestore wishlist
                  await authService.addToWishlist(wishlistItem);

                  // Show a success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$name added to Wishlist')),
                  );

                  // Optionally, navigate to the wishlist page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WishlistPage()),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text('Failed to add to wishlist: ${e.toString()}')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'Save to Wishlist',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(context: context),
    );
  }
} 