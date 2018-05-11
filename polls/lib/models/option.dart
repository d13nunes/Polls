import 'package:the_polls/models/user.dart';

class Option {
  final String name;
  List<User> votes;

  Option({this.name, this.votes});
}
