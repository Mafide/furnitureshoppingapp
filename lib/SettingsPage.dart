import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_service.dart';
import 'custom_bottom_navbar.dart';
import 'theme_provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsEnabled = true;
  String selectedLanguage = "English";

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
              final authService = Provider.of<AuthService>(context, listen: false);
              await authService.signOut();
              Navigator.pushReplacementNamed(context, '/loginSignup');
            },
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }

  void _showLanguagePicker() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Select Language"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile(
              title: Text("English"),
              value: "English",
              groupValue: selectedLanguage,
              onChanged: (value) {
                setState(() {
                  selectedLanguage = value!;
                });
                Navigator.pop(context);
              },
            ),
            RadioListTile(
              title: Text("Amharic"),
              value: "Amharic",
              groupValue: selectedLanguage,
              onChanged: (value) {
                setState(() {
                  selectedLanguage = value!;
                });
                Navigator.pop(context);
              },
            ),
            RadioListTile(
              title: Text("French"),
              value: "French",
              groupValue: selectedLanguage,
              onChanged: (value) {
                setState(() {
                  selectedLanguage = value!;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Settings'),
       backgroundColor: Color(0xFFD3D3D3),),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: Icon(Icons.dark_mode),
            title: Text("Dark Mode"),
            trailing: Switch(
              value: themeProvider.themeMode == ThemeMode.dark,
              onChanged: (value) {
                themeProvider.toggleTheme(value);
              },
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.language),
            title: Text("Language"),
            subtitle: Text(selectedLanguage),
            onTap: _showLanguagePicker,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text("Notifications"),
            trailing: Switch(
              value: notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  notificationsEnabled = value;
                });
              },
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: _showLogoutDialog,
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(context: context),
    );
  }
}
