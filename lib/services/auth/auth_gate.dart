import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_4/pages/home_page.dart';
import 'package:flutter_application_4/services/auth/login_or_register.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Debugging user state
          print("AuthGate snapshot: ${snapshot.data}");
          print("Firebase current user: ${FirebaseAuth.instance.currentUser?.email}");

          // User is logged in
          if (snapshot.hasData) {
            return HomePage();
          }

          // User is not logged in
          return const LoginOrRegister();
        },
      ),
    );
  }
}
