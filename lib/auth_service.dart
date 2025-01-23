import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Stream to listen for auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  // Get current user ID
  String? getCurrentUserId() => currentUser?.uid;


  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return userCredential.user;
    } catch (e) {
      throw Exception('Error signing in: ${e.toString()}');
    }
  }

  // Sign up with email, password, and username
 Future<void> signUp(String email, String password, String username) async {
  try {
    // Create user with email and password
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // After user is created, add user data to Firestore
    User? user = userCredential.user;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'username': username,
        'email': email,
        'cart': [],  // Initialize cart and wishlist
        'wishlist': [],
      });
    }
  } catch (e) {
    print('Error during sign-up: ${e.toString()}');
    throw Exception('Error during sign-up: ${e.toString()}');
  }
}


  // Get the user profile from Firestore
  Future<Map<String, dynamic>?> getUserProfile(String uid) async {
  try {
    // Fetch the document from Firestore
    DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
    
    // Check if the document exists
    if (doc.exists) {
      // Safely check the data and cast it to Map<String, dynamic>
      final data = doc.data();
      if (data is Map<String, dynamic>) {
        // Log the user profile data for debugging
        print('User Profile: $data');
        return data;  // Return the data if it's in the expected format
      } else {
        // Handle unexpected data format
        throw Exception('User profile data is not in the expected format.');
      }
    } else {
      return null; // If document doesn't exist, return null
    }
  } catch (e) {
    // Catch and display any errors during the data retrieval
    print('Error retrieving user profile: ${e.toString()}');
    throw Exception('Error retrieving user profile: ${e.toString()}');
  }
}




// Add to cart
  Future<void> addToCart(Map<String, dynamic> product) async {
    try {
      final userDoc = _firestore.collection('users').doc(currentUser?.uid);

      // Fetch the current cart
      DocumentSnapshot doc = await userDoc.get();

      // Check if the cart field exists, if not, initialize it
      List<dynamic> cart =
          doc.exists && doc.data() != null && doc['cart'] != null
              ? List.from(doc['cart'])
              : [];

      // Check if the product already exists in the cart
      int index = cart.indexWhere((item) => item['name'] == product['name']);
      if (index == -1) {
        // Add new product
        cart.add(product);
      } else {
        // Increment quantity if it already exists
        cart[index]['quantity'] += 1;
      }

      // Update the Firestore cart
      await userDoc.update({'cart': cart});
    } catch (e) {
      throw Exception('Error adding item to cart: ${e.toString()}');
    }
  }

  // Get cart items from Firestore
  Future<List<Map<String, dynamic>>> getCart() async {
  try {
    final userId = getCurrentUserId();  // Assuming this function returns the current user's ID
    final userDoc = _firestore.collection('users').doc(userId);

    // Fetch the cart field from the user's document
    DocumentSnapshot doc = await userDoc.get();

    // Check if the cart field exists, if not, return an empty list
    if (doc.exists && doc.data() != null && doc['cart'] != null) {
      return List<Map<String, dynamic>>.from(doc['cart']);
    } else {
      return [];
    }
  } catch (e) {
    throw Exception('Error loading cart items: $e');
  }
}


  // Add to wishlist
  Future<void> addToWishlist(Map<String, dynamic> product) async {
    try {
      final userDoc = _firestore.collection('users').doc(currentUser?.uid);

      // Fetch the current wishlist
      DocumentSnapshot doc = await userDoc.get();

      // Check if the wishlist field exists, if not, initialize it
      List<dynamic> wishlist =
          doc.exists && doc.data() != null && doc['wishlist'] != null
              ? List.from(doc['wishlist'])
              : [];

      // Add the new product to the wishlist
      wishlist.add(product);

      // Update the Firestore wishlist
      await userDoc.update({'wishlist': wishlist});
    } catch (e) {
      throw Exception('Error adding item to wishlist: ${e.toString()}');
    }
  }

  Future<void> updateWishlist(List<Map<String, dynamic>> wishlistItems) async {
    try {
      await _firestore
          .collection('users')
          .doc(currentUser?.uid)
          .update({'wishlist': wishlistItems});
    } catch (e) {
      throw Exception('Error updating wishlist: ${e.toString()}');
    }
  }

  Future<void> removeFromCart(Map<String, dynamic> item) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        final userDoc = _firestore.collection('users').doc(userId);
        DocumentSnapshot doc = await userDoc.get();

        if (doc.exists && doc['cart'] != null) {
          List<dynamic> cart = List.from(doc['cart']);

          // Ensure both IDs are strings for comparison
          String itemId = item['id'].toString(); // Ensure 'item' ID is a string

          // Debugging: Check the itemId that we are trying to delete
          print('Trying to remove item with id: $itemId');

          // Remove item by matching IDs
          cart.removeWhere((cartItem) {
            String cartItemId = cartItem['id'].toString();
            print('Comparing $cartItemId with $itemId'); // Debugging line
            return cartItemId == itemId; // Remove item by ID match
          });

          // Update cart in Firebase
          await userDoc.update({'cart': cart});
          print('Cart updated in Firebase');
        }
      }
    } catch (e) {
      print('Error removing item from Firebase: $e');
    }
  }

  
  

  Future<List<Map<String, dynamic>>> getWishlist() async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(currentUser?.uid).get();
      return List<Map<String, dynamic>>.from(doc['wishlist'] ?? []);
    } catch (e) {
      throw Exception('Error retrieving wishlist: ${e.toString()}');
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Delete user account
  Future<void> deleteAccount() async {
    try {
      await _firestore.collection('users').doc(currentUser?.uid).delete();
      await currentUser?.delete();
    } catch (e) {
      throw Exception('Error deleting account: ${e.toString()}');
    }
  }
}
