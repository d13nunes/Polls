import 'dart:async';

// Copyright (c) 2018 Diogo Nunes
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

import 'package:polls/models/user.dart';

abstract class LoginService {
  Future<User> login({String email, String password});
  Future<User> register({String email, String password});
  Future<User> googleSignIn();
  Future<User> logedUser();

  Future<bool> signOut();
}
