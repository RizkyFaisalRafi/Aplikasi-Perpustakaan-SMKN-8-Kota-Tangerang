import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  // 1
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  // Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Sign In
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Sign Up
  static Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print(e.toString());
      return;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  static Stream<User?> get firebaseUserStream => _firebaseAuth.authStateChanges();
}
