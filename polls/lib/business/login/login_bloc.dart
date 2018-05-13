import 'dart:async';
import 'package:polls/debug/logger.dart';
import 'package:polls/services/interfaces/login_service.dart';
import 'package:rxdart/subjects.dart';
import 'package:polls/models/user.dart';

class DoGoogleSignIn {}

class EmailPasswordSignIn {
  final String email;
  final String password;

  EmailPasswordSignIn(this.email, this.password);
}

class EmailPasswordLogIn {
  final String email;
  final String password;

  EmailPasswordLogIn(this.email, this.password);
}

class LoginBloc {
  final BehaviorSubject<User> _userSubject =
      BehaviorSubject<User>(seedValue: null);

  final BehaviorSubject<bool> _isLoged =
      BehaviorSubject<bool>(seedValue: false);

  final BehaviorSubject<bool> _isLoggin =
      BehaviorSubject<bool>(seedValue: false);

  final StreamController<EmailPasswordLogIn> _logUserController =
      StreamController<EmailPasswordLogIn>();
  final StreamController<EmailPasswordSignIn> _regiterUserController =
      StreamController<EmailPasswordSignIn>();

  final StreamController<DoGoogleSignIn> _googleSignInController =
      StreamController<DoGoogleSignIn>();

  LoginService _loginService;

  LoginBloc({LoginService loginService}) {
    _loginService = loginService;

    _logUserController.stream.listen(_onLogin);
    _regiterUserController.stream.listen(_onRegister);
    _googleSignInController.stream.listen(_onGoogleSignIn);
    _loginService.logedUser().then((logedUser) {
      if (logedUser != null) {
        _userSubject.add(logedUser);
      }
    });
  }

  Sink<EmailPasswordLogIn> get emailPasswordLogIn => _logUserController.sink;
  Sink<EmailPasswordSignIn> get emailPasswordSignIn =>
      _regiterUserController.sink;
  Sink<DoGoogleSignIn> get googleSignIn => _googleSignInController.sink;

  Stream<User> get user => _userSubject.stream;
  Stream<bool> get isLoged => _isLoged.stream;
  Stream<bool> get isLoggin => _isLoggin.stream;

  Future _onLogin(EmailPasswordLogIn logUser) async {
    _isLoggin.add(true);
    try {
      var user = await _loginService.login(
          email: logUser.email, password: logUser.password);
      setUser(user);
      log(name: "user loged", value: "success");
    } catch (e) {
      log(name: "user loged with error", value: e.toString());
    }
    _isLoggin.add(false);
  }

  Future _onRegister(EmailPasswordSignIn registerUser) async {
    _isLoggin.add(true);
    try {
      var user = await _loginService.register(
          email: registerUser.email, password: registerUser.password);
      log(name: "register user", value: "success");
      setUser(user);
    } catch (e) {
      log(name: "register user with error", value: e.toString());
    }
    _isLoggin.add(false);
  }

  void setUser(User user) {
    if (user != null) {
      _isLoged.add(true);
      _userSubject.add(user);
    } else {
      _isLoged.add(false);
    }
  }

  Future _onGoogleSignIn(DoGoogleSignIn event) async {
    _isLoggin.add(true);
    try {
      var user = await _loginService.googleSignIn();

      setUser(user);
    } catch (e) {}
    _isLoggin.add(false);
  }

  void dispose() {
    _userSubject.close();
    _isLoged.close();
    _isLoggin.close();
    _logUserController.close();
    _regiterUserController.close();
    _googleSignInController.close();
  }
}
