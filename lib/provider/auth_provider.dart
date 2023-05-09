import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../util/key.dart';

enum AuthType {
  signUp,
  signIn,
}

class AuthProvider extends ChangeNotifier {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerGender = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance; // Auth
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance; // Firestore
  User? get currentUser => _firebaseAuth.currentUser;

  AuthType _authType = AuthType.signIn;
  AuthType get authType => _authType;

  setAuthType() {
    _authType =
        _authType == AuthType.signIn ? AuthType.signUp : AuthType.signIn;
    notifyListeners();
  }

  Future<void> authenticate() async {
    UserCredential userCredential;
    try {
      if (_authType == AuthType.signIn) {
        userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: controllerEmail.text,
          password: controllerPassword.text,
        );
      }
      if (_authType == AuthType.signUp) {
        userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: controllerEmail.text,
          password: controllerPassword.text,
        );
        firebaseFirestore
            .collection("admin_data")
            .doc(userCredential.user!.uid)
            .set({
          "email": userCredential.user!.email,
          "uid": userCredential.user!.uid,
          "name": controllerName.text,
        });
      }
    } on FirebaseAuthException catch (error) {
      Keys.scaffoldMessengerKey.currentState!.showSnackBar(
        SnackBar(
          content: Text(error.code),
          backgroundColor: Colors.red,
        ),
      );
    } catch (error) {
      Keys.scaffoldMessengerKey.currentState!.showSnackBar(
        SnackBar(
          content: Text(error.toString()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Log Out
  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (error) {
      Keys.scaffoldMessengerKey.currentState!.showSnackBar(
        SnackBar(
          content: Text(error.code),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
