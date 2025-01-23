import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'custom_bottom_navbar.dart';
import 'checkout.dart'; 


class AddToCartPage extends StatefulWidget {
  const AddToCartPage({Key? key}) : super(key: key);

  @override
  _AddToCartPageState createState() => _AddToCartPageState();
}

class _AddToCartPageState extends State<AddToCartPage> {
   int _selectedIndex = 1;
   
  final AuthService _authService = AuthService();
  List<Map<String, dynamic>> cartItems = [];

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  
  Future<void> _loadCartItems() async {
    try {
      final items = await _authService.getCart();
      setState(() {
        cartItems = items;
      });
    } catch (e) {
      print('Error loading cart items: $e');
    }
  }

  
  double get totalPrice => cartItems.fold(0.0, (sum, item) {
        return sum +
            ((item['price'] as num).toDouble() * (item['quantity'] as int));
      });

  
  void _increaseQuantity(int index) {
    setState(() {
      cartItems[index]['quantity']++;
    });
    _authService.addToCart(cartItems[index]); // Update cart quantity in Firebase
  }

  
  void _decreaseQuantity(int index) {
    if (cartItems[index]['quantity'] > 1) {
      setState(() {
        cartItems[index]['quantity']--;
      });
      _authService.addToCart(cartItems[index]); 
    }
  }

  
  void _deleteItem(int index) async {
    final item = cartItems[index];
    
    print('Deleting item: ${item['id']} - ${item['name']}');

    
    await _authService.removeFromCart(item);

    
    setState(() {
      cartItems.removeAt(index);
    });

    
    print('Cart after deletion: $cartItems');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        backgroundColor: Color(0xFFD3D3D3),
  

      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text(
                "Your cart is empty.",
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              
                              Image.asset(
                                'assets/${item['image']}',
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),

                              // Item details
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['name'],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                          '\ETB ${item['price'].toStringAsFixed(2)}'),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          
                                          IconButton(
                                            icon: const Icon(Icons.remove),
                                            onPressed: () =>
                                                _decreaseQuantity(index),
                                          ),
                                          
                                          Text('${item['quantity']}'),
                                          
                                          IconButton(
                                            icon: const Icon(Icons.add),
                                            onPressed: () =>
                                                _increaseQuantity(index),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // Delete button
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => _deleteItem(index),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Total: \ETB ${totalPrice.toStringAsFixed(2)}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Checkout(
                                  totalPrice: totalPrice, cartItems: cartItems),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text('Proceed to Checkout'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
      bottomNavigationBar: CustomBottomNavBar(context: context),
    );
  }
}