import 'package:flutter/material.dart';
import 'orderHistoryPage.dart'; // Import the Order page
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'custom_bottom_navbar.dart';
class PaymentPage extends StatefulWidget {
  final double totalPrice;
  final List<Map<String, dynamic>> cartItems;

  const PaymentPage(
      {super.key, required this.totalPrice, required this.cartItems});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? selectedPaymentMethod = 'Credit/Debit Card'; // Default payment method
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final double shippingPrice = 300.00; // Updated shipping fee

  double get subtotal =>
      widget.totalPrice; // Subtotal is the price of the items
  double get total => subtotal + shippingPrice; // Total is subtotal + shipping
  void _completePurchase() async {
    if (fullNameController.text.isEmpty ||
        addressController.text.isEmpty ||
        phoneController.text.isEmpty ||
        selectedPaymentMethod == null) {
      // Show a warning if any field is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Please fill in all fields before completing the purchase.')),
      );
    } else {
      // Create order data
      final orderData = {
        'userId': FirebaseAuth.instance.currentUser?.uid,
        'fullName': fullNameController.text,
        'address': addressController.text,
        'phoneNumber': phoneController.text,
        'paymentMethod': selectedPaymentMethod,
        'items': widget.cartItems,
        'totalPrice': total,
        'orderDate': Timestamp.now(),
      };

      try {
        // Save the order to Firestore
        await FirebaseFirestore.instance.collection('orders').add(orderData);

        _showThankYouDialog(); // Show Thank You dialog when form is valid

        // Optionally, clear the cart or navigate to a confirmation page
      } catch (e) {
        // Handle errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error completing purchase: $e')),
        );
      }
    }
  }

  void _showThankYouDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Purchase Complete'),
          content: Text(
              'Thank you for your purchase! Your order has been successfully placed.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        backgroundColor: Color(0xFFD3D3D3),
      ),
      body: SingleChildScrollView(
        // Wrap the body with SingleChildScrollView
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Subtotal: \ETB ${subtotal.toStringAsFixed(2)}', // Show the subtotal
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Shipping Fee: \ETB ${shippingPrice.toStringAsFixed(2)}', // Show shipping fee
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Total: \ETB ${total.toStringAsFixed(2)}', // Show the total price (items + shipping)
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: fullNameController,
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            TextField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedPaymentMethod,
              onChanged: (value) {
                setState(() {
                  selectedPaymentMethod = value;
                });
              },
              items: [
                DropdownMenuItem(
                  value: 'Credit/Debit Card',
                  child: Text('Credit/Debit Card'),
                ),
                DropdownMenuItem(
                  value: 'Mobile Money',
                  child: Text('Mobile Money'),
                ),
                DropdownMenuItem(
                  value: 'Bank Transfer',
                  child: Text('Bank Transfer'),
                ),
                DropdownMenuItem(
                  value: 'Telebirr', // Added Telebirr option
                  child: Text('Telebirr'),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: _completePurchase,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text('Complete Purchase'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(context: context),
    );
  }
}
