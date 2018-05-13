// Copyright (c) 2018 Diogo Nunes
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

import 'dart:async';

import 'package:polls/models/user.dart';
import 'package:polls/services/interfaces/login_service.dart';
import 'package:rxdart/subjects.dart';

class SetLogedUser {
  User user;
  SetLogedUser(this.user);
}

class Logout {}

class LogedUserBloc {
  final BehaviorSubject<User> _logedUserSubject =
      BehaviorSubject<User>(seedValue: null);

  final StreamController<SetLogedUser> _logedUserController =
      StreamController<SetLogedUser>();

  final StreamController<Logout> _logoutController = StreamController<Logout>();

  Stream<User> get user => _logedUserSubject.stream;

  Sink<SetLogedUser> get logUser => _logedUserController.sink;
  Sink<Logout> get logout => _logoutController.sink;

  LoginService _loginService;

  LogedUserBloc({LoginService loginService}) {
    _loginService = loginService;
    _logedUserController.stream.listen(_onLogedUser);
    _logoutController.stream.listen(_onLogout);
    _loginService.logedUser().then((user) => _logedUserSubject.add(user));
  }

  void _onLogedUser(SetLogedUser event) {
    _logedUserSubject.add(event.user);
  }

  Future _onLogout(Logout event) async {
    await _loginService.signOut();
    _logedUserSubject.add(null);
  }

  void dispose() {
    _logedUserSubject.close();
    _logedUserController.close();
    _logoutController.close();
  }
}
