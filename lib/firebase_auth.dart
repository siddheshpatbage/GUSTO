// firebase_auth_service.dart

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Sign up with email and password
  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print('Error during sign-up: ${e.message}');
      rethrow;
    }
  }

  // Sign in with email and password
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print('Error during sign-in: ${e.message}');
      rethrow;
    }
  }

  // Sign out the current user
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // Get the currently signed-in user
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }
}
