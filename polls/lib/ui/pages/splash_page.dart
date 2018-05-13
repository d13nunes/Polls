import 'dart:async';

// Copyright (c) 2018 Diogo Nunes
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

import 'package:flutter/material.dart';
import 'package:polls/business/login/login_provider.dart';
import 'package:polls/ui/app/routes.dart';

class SplashPage extends StatefulWidget {
  @override
  SplashPageState createState() {
    return new SplashPageState();
  }

  doDelayedNavigation(BuildContext context, isLogged) {
    if (isLogged == null) {
      return false;
    }
    final loginBloc = LoginProvider.of(context);
    print(loginBloc.user.first);
    Timer(Duration(seconds: 1), () => doNavigation(context, isLogged));
    return true;
  }

  doNavigation(BuildContext context, bool isLogged) {
    String routeName;
    if (isLogged) {
      routeName = RouteName.home;
    } else {
      routeName = RouteName.login;
    }
    Navigator.of(context).pushReplacementNamed(routeName);
  }
}

class SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    final userBloc = LoginProvider.of(context);
    userBloc.isLoged.firstWhere(
        ((isLogged) => widget.doDelayedNavigation(context, isLogged)));
    return new Scaffold(
      body: Center(
        child: Text("splash"),
      ),
    );
  }
}
