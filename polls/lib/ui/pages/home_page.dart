import 'dart:async';

// Copyright (c) 2018 Diogo Nunes
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

import 'package:flutter/material.dart';
import 'package:polls/business/user/user_bloc.dart';
import 'package:polls/business/user/user_provider.dart';
import 'package:polls/models/user.dart';
import 'package:polls/services/implementations/firebase_login_service.dart';
import 'package:polls/ui/app/routes.dart';

class HomePage extends StatefulWidget {
  @override
  final userBloc = LogedUserBloc(loginService: FirebaseLoginService());

  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  final String welcomeMessage = "not initialized";

  StreamSubscription<User> a;

  void onLogout(BuildContext context) {
    a.cancel();
    print("onLogout");
    widget.userBloc.dispose();
    Navigator.of(context).pushReplacementNamed(RouteName.login);
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    a?.cancel();
    a = widget.userBloc.user.listen((user) {
      if (user == null) {
        onLogout(context);
      }
    });

    return new Scaffold(
        body: new Center(
      child: new Column(
        children: <Widget>[
          new StreamBuilder<String>(
            initialData: welcomeMessage,
            builder: (context, snapshot) {
              return Text(
                snapshot.data ?? "",
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              );
            },
            stream: widget.userBloc.user.map((u) => u?.name),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 10.0,
            ),
            child: RaisedButton(
              child: Text(
                "LogOut",
              ),
              onPressed: () => logout(context),
            ),
          ),
        ],
      ),
    ));
  }

  void logout(BuildContext context) {
    widget.userBloc.logout.add(Logout());
  }
}
