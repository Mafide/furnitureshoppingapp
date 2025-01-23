import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'auth_service.dart';
import 'custom_bottom_navbar.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final userId = authService.currentUser?.uid ?? ''; // Get the current user ID

    return Scaffold(
      appBar: AppBar(
        title: Text('Order History'),
        backgroundColor: Color(0xFFD3D3D3),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('userId', isEqualTo: userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No orders found."));
          }

          final orders = snapshot.data!.docs;

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              final items = List.from(order['items']); // Fetching items only
              final totalPrice = order['totalPrice'] ?? 0.0; // Get the total price
              final totalQuantity = items.fold<int>(0, (sum, item) => sum + (item['quantity'] ?? 0) as int);

              return Card(
                child: ListTile(
                  title: Text('Order on ${order['orderDate'].toDate()}'), // Display order date instead of ID
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...items.map((item) => Text("- ${item['name']} (x${item['quantity']})")), // Display items with quantity
                      SizedBox(height: 10),
                      Text("Total Quantity: $totalQuantity"), // Display total quantity
                      Text("Total Price: \ETB ${totalPrice.toStringAsFixed(2)}"), // Display total price
                    ],
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
