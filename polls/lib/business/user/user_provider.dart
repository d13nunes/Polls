// Copyright (c) 2018 Diogo Nunes
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

import 'package:flutter/widgets.dart';
import 'package:polls/business/user/user_bloc.dart';

class UserProvider extends InheritedWidget {
  final UserBloc pollListBloc;

  UserProvider({Key key, UserBloc userBloc, Widget child})
      : pollListBloc = userBloc ?? UserBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static UserBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(UserProvider) as UserProvider)
          .pollListBloc;
}
