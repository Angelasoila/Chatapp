import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // Instance of Firebase Auth and Firestore
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Login with email and password
  Future<UserCredential> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Debug log
      print("User logged in: ${userCredential.user?.email}");

      // Optionally verify the user exists in Firestore
      DocumentSnapshot userDoc = await _firestore
          .collection("Users")
          .doc(userCredential.user!.uid)
          .get();

      if (!userDoc.exists) {
        print("Firestore document not found for user ${userCredential.user!.uid}");
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Log error and rethrow for handling in the UI
      print("Login failed: ${e.message}");
      throw Exception(e.message ?? "An error occurred during login.");
    }
  }

  // Signup with email and password
  Future<UserCredential> signUpWithEmailPassword(String email, String password) async {
    try {
      // Create user
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save user info in Firestore
      await _firestore.collection("Users").doc(userCredential.user!.uid).set({
        "email": email,
        "uid": userCredential.user!.uid,
        "createdAt": FieldValue.serverTimestamp(),
      });

      // Debug log
      print("User registered: ${userCredential.user?.email}");

      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Log error and rethrow for handling in the UI
      print("Signup failed: ${e.message}");
      throw Exception(e.message ?? "An error occurred during signup.");
    }
  }

  // Sign out the user
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      print("User signed out successfully.");
    } catch (e) {
      print("Sign out failed: $e");
      throw Exception("An error occurred while signing out.");
    }
  }
}
