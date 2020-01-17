import 'package:albus_dashboard/dashboard.dart';
import 'package:albus_dashboard/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //handle authentication
  handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          return Dashboard();
        } else {
          return LoginPage();
        }
      },
    );
  }

  // //create user object based on firebaser user
  // User _userFromFirebaseUser(FirebaseUser user) {
  //   return user != null ? User(uid: user.uid) : null;
  // }

  // //auth change user stream (with mapping FireBasUser to custom user class)
  // Stream<User> get user {
  //   return _auth.onAuthStateChanged
  //       .map((FirebaseUser user) => _userFromFirebaseUser(user));
  // }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print('error: ' + e.toString());
    }
  }

  //sign in with email +pw
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  void signInWithEmailAndPasswordBeta(String _email, String _password) async {
    FirebaseUser user = (await _auth.signInWithEmailAndPassword(
      email: _email,
      password: _password,
    ))
        .user;
    if (user != null) {}
  }
}
