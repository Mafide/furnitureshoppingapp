import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_service.dart';
import 'custom_bottom_navbar.dart';
import 'SettingsPage.dart';
import 'orderHistoryPage.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String fullName = "";
  String email = "";
  String phone = "0934567890";

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final user = authService.currentUser;

    if (user != null) {
      final profileData = await authService.getUserProfile(user.uid);
      setState(() {
        fullName = profileData?['username'] ?? "No Name";
        email = profileData?['email'] ?? "No Email";
        phone = profileData?['phone'] ?? "No Phone";
      });
    }
  }

  void _updateProfile() {
    setState(() {
      fullName = _nameController.text;
      email = _emailController.text;
      phone = _phoneController.text;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Profile saved successfully!')),
    );
    Navigator.pop(context);
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final authService =
                  Provider.of<AuthService>(context, listen: false);
              await authService.signOut();
              Navigator.pushReplacementNamed(context, '/loginSignup');
            },
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure you want to delete your account?'),
        content: Text('This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final authService =
                  Provider.of<AuthService>(context, listen: false);
              await authService.deleteAccount();
              Navigator.pushReplacementNamed(context, '/loginSignup');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Account deleted successfully!')),
              );
            },
            child: Text('Delete'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Color(0xFFD3D3D3),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 30),
            Center(
              child: CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('assets/profile.jpg'),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                "Hello, $fullName",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Text(email, style: TextStyle(color: Colors.grey)),
            ),
            SizedBox(height: 20),
            Divider(),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Edit Profile"),
              onTap: () => _showEditProfileDialog(),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text("Order History"), // Add Order History option
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderHistoryPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: _showLogoutDialog,
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text("Delete Account"),
              onTap: _showDeleteAccountDialog,
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(context: context),
    );
  }

  void _showEditProfileDialog() {
    _nameController.text = fullName;
    _emailController.text = email;
    _phoneController.text = phone;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Profile"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Full Name"),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: "Phone Number"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: _updateProfile,
            child: Text("Save"),
          ),
        ],
      ),
    );
  }
}
