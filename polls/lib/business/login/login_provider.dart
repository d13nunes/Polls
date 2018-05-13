// Copyright (c) 2018 Diogo Nunes
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

import 'package:flutter/widgets.dart';
import 'package:polls/business/login/login_bloc.dart';

class LoginProvider extends InheritedWidget {
  final LoginBloc loginBloc;

  LoginProvider({Key key, LoginBloc loginBloc, Widget child})
      : loginBloc = loginBloc ?? LoginBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(LoginProvider) as LoginProvider)
          .loginBloc;
}
