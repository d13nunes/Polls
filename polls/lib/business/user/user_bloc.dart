// Copyright (c) 2018 Diogo Nunes
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

import 'dart:async';
import 'package:polls/debug/logger.dart';
import 'package:rxdart/subjects.dart';
import 'package:polls/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// TODO: Wrap FirebaseAuth in a interface in order to respect separation of concerns
final FirebaseAuth _auth = FirebaseAuth.instance;

class DoGoogleSignIn {}

class SignInEmailPassword {
  final String email;
  final String password;

  SignInEmailPassword(this.email, this.password);
}

class LogInEmailPassword {
  final String email;
  final String password;

  LogInEmailPassword(this.email, this.password);
}

class UserBloc {
  final BehaviorSubject<User> _userSubject =
      BehaviorSubject<User>(seedValue: null);

  final BehaviorSubject<bool> _isLoged =
      BehaviorSubject<bool>(seedValue: _auth.currentUser() != null);

  final BehaviorSubject<bool> _isLoggin =
      BehaviorSubject<bool>(seedValue: false);

  final StreamController<LogInEmailPassword> _logUserController =
      StreamController<LogInEmailPassword>();
  final StreamController<SignInEmailPassword> _regiterUserController =
      StreamController<SignInEmailPassword>();

  final StreamController<DoGoogleSignIn> _googleSignInController =
      StreamController<DoGoogleSignIn>();

  UserBloc() {
    _logUserController.stream.listen(onLogin);
    _regiterUserController.stream.listen(onRegister);
    _googleSignInController.stream.listen(onGoogleSignIn);
  }

  Sink<LogInEmailPassword> get logUser => _logUserController.sink;
  Sink<SignInEmailPassword> get registerUser => _regiterUserController.sink;
  Sink<DoGoogleSignIn> get googleSignIn => _googleSignInController.sink;

  Stream<User> get user => _userSubject.stream;
  Stream<bool> get isLoged => _isLoged.stream;
  Stream<bool> get isLoggin => _isLoggin.stream;

  Future onLogin(LogInEmailPassword logUser) async {
    _isLoggin.add(true);
    try {
      var user = await _auth.createUserWithEmailAndPassword(
        email: logUser.email,
        password: logUser.password,
      );
      log(name: "user loged", value: "success");
    } catch (e) {
      log(name: "user loged with error", value: e.toString());
    }
    _isLoggin.add(false);
  }

  Future onRegister(SignInEmailPassword registerUser) async {
    _isLoggin.add(true);
    try {
      var user = await _auth.signInWithEmailAndPassword(
        email: registerUser.email,
        password: registerUser.password,
      );
      log(name: "register user", value: "success");
      if (user != null) {
        _isLoged.add(true);
        _userSubject.add(User(
          id: await user.getIdToken(),
          name: user.displayName,
        ));
      }
    } catch (e) {
      log(name: "register user with error", value: e.toString());
    }
    _isLoggin.add(false);
  }

  Future onGoogleSignIn(DoGoogleSignIn event) async {
    GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    FirebaseUser user = await _auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    void dispose() {
      _userSubject.close();
      _isLoged.close();
      _isLoggin.close();
      _logUserController.close();
      _regiterUserController.close();
      _googleSignInController.close();
    }
  }
}
