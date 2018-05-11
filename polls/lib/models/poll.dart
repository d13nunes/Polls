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
