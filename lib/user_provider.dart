import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  // Private fields to store user details
  String _username = '';
  String _email = '';

  
  String get username => _username;
  String get email => _email;

 
  void setUser(String username, String email) {
    _username = username;
    _email = email;
    notifyListeners(); 
  }

  
  void updateUsername(String newUsername) {
    if (_username != newUsername) {
      _username = newUsername;
      notifyListeners(); 
    }
  }

  
  void updateEmail(String newEmail) {
    if (_email != newEmail) {
      _email = newEmail;
      notifyListeners(); 
    }
  }

  
  void clearUser() {
    _username = '';
    _email = '';
    notifyListeners(); 
  }
}
