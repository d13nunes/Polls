// Copyright (c) 2018 Diogo Nunes
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:polls/models/user.dart';

import 'package:polls/services/interfaces/login_service.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class FirebaseLoginService extends LoginService {
  @override
  Future<User> googleSignIn() async {
    GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    FirebaseUser user = await _auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return User.fromFirebase(user);
  }

  @override
  Future<User> logedUser() async {
    var user = await _auth.currentUser();
    if (user != null) {
      return User.fromFirebase(user);
    }
    return null;
  }

  @override
  Future<User> login({String email, String password}) async {
    var user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    print("loged?");
    print("$user");
    if (user != null) {
      return User.fromFirebase(user);
    }
    return null;
  }

  @override
  Future<User> register({String email, String password}) async {
    var user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    if (user != null) {
      return User.fromFirebase(user);
    }
    return null;
  }

  @override
  Future<bool> signOut() async {
    try {
      var user = await _auth.currentUser();
      if (user != null) {
        _auth.signOut();
      }
    } catch (e) {
      return false;
    }
    return false;
  }
}
