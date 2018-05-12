// Copyright (c) 2018 Diogo Nunes
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

import 'package:flutter/material.dart';
import 'package:polls/business/user/user_bloc.dart';
import 'package:polls/business/user/user_provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    final userBloc = UserProvider.of(context);
    userBloc.isLoged.firstWhere(((isLogged) => onLogin(context, isLogged)));
    return Scaffold(
      body: new Container(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: "email"),
                onChanged: (t) => email = t,
              ),
              TextField(
                decoration: InputDecoration(labelText: "password"),
                onChanged: (t) => password = t,
                obscureText: true,
              ),
              RaisedButton(
                child: Text("Login"),
                onPressed: () => userBloc.logUser.add(new LogUser(
                      email.trim().toLowerCase(),
                      password,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool onLogin(BuildContext context, bool isLogged) {
    print("isLog $isLogged");
    if (isLogged) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
              content: Text(
                "Log sucess",
              ),
              actions: <Widget>[
                RaisedButton(
                  child: Text(
                    "COOL",
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ],
            ),
      );
    }
    return isLogged;
  }
}
