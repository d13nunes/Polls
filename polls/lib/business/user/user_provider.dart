// Copyright (c) 2018 Diogo Nunes
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

import 'package:flutter/widgets.dart';
import 'package:polls/business/user/user_bloc.dart';

class LogedUserProvider extends InheritedWidget {
  final LogedUserBloc _userBloc;

  LogedUserProvider(this._userBloc,
      {Key key, LogedUserBloc userBloc, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LogedUserBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(LogedUserProvider)
              as LogedUserProvider)
          ._userBloc;
}
