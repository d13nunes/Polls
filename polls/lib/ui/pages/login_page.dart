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
              new Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  decoration:
                      _buildInputDecoration(context, placeholder: "email"),
                  onChanged: (t) => email = t,
                ),
              ),
              new Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: TextField(
                  decoration:
                      _buildInputDecoration(context, placeholder: "password"),
                  onChanged: (t) => password = t,
                  obscureText: true,
                ),
              ),
              new Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RaisedButton(
                        child: Text("register"),
                        onPressed: () =>
                            userBloc.registerUser.add(new SignInEmailPassword(
                              email.trim().toLowerCase(),
                              password,
                            )),
                      ),
                      RaisedButton(
                        child: Text("Login"),
                        onPressed: () =>
                            userBloc.logUser.add(new LogInEmailPassword(
                              email.trim().toLowerCase(),
                              password,
                            )),
                      ),
                    ],
                  ),
                  new Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Center(
                      child: RaisedButton(
                        child: Text(
                          "Google Sign in",
                        ),
                        onPressed: () =>
                            userBloc.googleSignIn.add(DoGoogleSignIn()),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(BuildContext context,
      {String placeholder}) {
    return InputDecoration(
      labelText: placeholder,
      border: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 1.0,
              style: BorderStyle.solid)),
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
