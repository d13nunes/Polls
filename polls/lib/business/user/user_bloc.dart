// Copyright (c) 2018 Diogo Nunes
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

import 'dart:async';
import 'package:rxdart/subjects.dart';
import 'package:polls/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

// TODO: Wrap FirebaseAuth in a interface in order to respect separation of concerns
final FirebaseAuth _auth = FirebaseAuth.instance;

class LogUser {
  final String email;
  final String password;

  LogUser(this.email, this.password);
}

class UserBloc {
  final User _user = User();
  final BehaviorSubject<User> _userSubject =
      BehaviorSubject<User>(seedValue: null);

  final BehaviorSubject<bool> _isLoged =
      BehaviorSubject<bool>(seedValue: false);

  final BehaviorSubject<bool> _isLoggin =
      BehaviorSubject<bool>(seedValue: false);

  final StreamController<LogUser> _logUserController =
      StreamController<LogUser>();

  UserBloc() {
    _logUserController.stream.listen(onLogin);
    // //Is this a good pratice? maybe not
    // //TODO: Check how dart ctor handles async code
    // _auth.currentUser().then(onCurrentUser);
  }

  Sink<LogUser> get logUser => _logUserController.sink;

  Stream<User> get user => _userSubject.stream;
  Stream<bool> get isLoged => _isLoged.stream;
  Stream<bool> get isLoggin => _isLoggin.stream;

  Future onLogin(LogUser logUser) async {
    _isLoggin.add(true);
    try {
      print("email:${logUser.email} pass:${logUser.password}");
      var user = await _auth.createUserWithEmailAndPassword(
        email: logUser.email,
        password: logUser.password,
      );
      if (user != null) {
        _isLoged.add(true);
        _userSubject.add(User(
          id: await user.getIdToken(),
          name: user.displayName,
        ));
      }
    } catch (e) {
      print("error on login $e");
    }
    _isLoggin.add(false);
  }

  // void onCurrentUser(FirebaseUser fuser) {
  //   if (fuser != null) {
  //     logUser.add(LogUser(
  //       id: fuser.getIdToken(),
  //       name: fuser.displayName,
  //     ));
  //   }
  // }

  void dispose() {
    _userSubject.close();
    _isLoged.close();
    _isLoggin.close();
    _logUserController.close();
  }
}
