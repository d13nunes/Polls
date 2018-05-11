// Copyright (c) 2018 Diogo Nunes
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

import 'package:polls/models/option.dart';

class Poll {
  String id;
  String name;
  String description;
  List<Option> options;
  DateTime creationDate;
  DateTime closeDate;

  Poll({
    this.id,
    this.name,
    this.description,
    this.options,
    this.creationDate,
    this.closeDate,
  });
}
