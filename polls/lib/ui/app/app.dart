// Copyright (c) 2018 Diogo Nunes
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

import 'package:flutter/material.dart';
import 'package:polls/business/login/login_provider.dart';
import 'package:polls/debug/logger.dart';
import 'package:polls/services/implementations/firebase_login_service.dart';
import 'package:polls/ui/app/routes.dart';
import 'package:polls/business/login/login_bloc.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    startLogger();
    return new LoginProvider(
      loginBloc: LoginBloc(loginService: FirebaseLoginService()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        initialRoute: RouteName.splash,
        routes: Routes.routes,
      ),
    );
  }
}
