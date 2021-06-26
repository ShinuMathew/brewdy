import 'package:chaiwala420/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //  "_" means private
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //  Create UserModel object based on User
  UserModel _userFromFirebaseUser(User user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  Stream<UserModel> get user {
    return _auth
        .authStateChanges()
        // .map((User user) => _userFromFirebaseUser(user))
        .map(_userFromFirebaseUser);
    //  The above map code is a shorthand of the one above it
  }

  //  Sign in anonymously
  Future signInAnonymous() async {
    try {
      print("Signing in");
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (err) {
      print(err.toString());
      return null;
    }
  }

  //  Sign in with email and password

  //  Register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (err) {
      print(err.toString());
    }
  }

  //  sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (err) {
      print(err.toString());
      return null;
    }
  }
}
