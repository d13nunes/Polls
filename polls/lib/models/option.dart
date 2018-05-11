// Copyright (c) 2018 Diogo Nunes
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

import 'package:polls/models/user.dart';

class Option {
  final String name;
  List<User> votes;

  Option({this.name, this.votes});
}
