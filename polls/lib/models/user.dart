// Copyright (c) 2018 Diogo Nunes
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

import 'package:firebase_auth/firebase_auth.dart';

class User {
  String get email => firebaseUser.email;
  String get name => firebaseUser.displayName;

  FirebaseUser firebaseUser;

  User.fromFirebase(this.firebaseUser);
}
