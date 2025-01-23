import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'SettingsPage.dart';
import 'login_signup.dart';
import 'splashscreen1.dart';
import 'theme_provider.dart';
import 'auth_service.dart';
import 'user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const FurnitureApp());
}

class FurnitureApp extends StatelessWidget {
  const FurnitureApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        Provider<AuthService>(create: (_) => AuthService()), // Provide AuthService
        ChangeNotifierProvider(create: (_) => UserProvider()), // Provide UserProvider
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Furniture App',
            theme: ThemeData(
              primarySwatch: Colors.teal,
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFFD3D3D3), 
                foregroundColor: Colors.black,     
                titleTextStyle: TextStyle(
                  color: Colors.black,             
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,             
                ),
              ),
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.teal,
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFF212121), 
                foregroundColor: Colors.white,     
                titleTextStyle: TextStyle(
                  color: Colors.white,             
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                  color: Colors.white,             
                ),
              ),
            ),
            themeMode: themeProvider.themeMode,
            home: const AuthWrapper(), 
            routes: {
              '/settings': (context) => const SettingsPage(),
              '/loginSignup': (context) => LoginSignupPage(),
            },
          );
        },
      ),
    );
  }
}

/// **AuthWrapper**: Manages navigation based on authentication state.
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return StreamBuilder(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          
          final user = snapshot.data;
          if (user != null) {
            Provider.of<UserProvider>(context, listen: false)
                .setUser(user.displayName ?? '', user.email ?? '');
            return const SplashScreen1(); 
          }
        }
        return LoginSignupPage(); 
      },
    );
  }
}
