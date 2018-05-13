// Copyright (c) 2018 Diogo Nunes
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

import 'package:flutter/material.dart';
import 'package:polls/business/login/login_bloc.dart';
import 'package:polls/services/implementations/firebase_login_service.dart';
import 'package:polls/ui/app/routes.dart';

class LoginPage extends StatefulWidget {
  final loginBloc = LoginBloc(loginService: FirebaseLoginService());

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
    widget.loginBloc.isLoged
        .firstWhere(((isLogged) => onLogin(context, isLogged)));
    return Scaffold(
      body: new Container(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: new InputField(
                    placeholder: "email", onTextChanged: (t) => email = t),
              ),
              new Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: new InputField(
                  placeholder: "password",
                  onTextChanged: (t) => password = t,
                  obscureText: true,
                ),
              ),
              new Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        child: Text("register"),
                        onPressed: () => widget.loginBloc.emailPasswordSignIn
                                .add(new EmailPasswordSignIn(
                              email.trim().toLowerCase(),
                              password,
                            )),
                      ),
                      RaisedButton(
                        child: Text("Login"),
                        onPressed: () =>
                            widget.loginBloc.emailPasswordLogIn.add(
                              new EmailPasswordLogIn(
                                email.trim().toLowerCase(),
                                password,
                              ),
                            ),
                      ),
                    ],
                  ),
                  new Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: RaisedButton(
                      child: Text(
                        "Google Sign in",
                      ),
                      onPressed: () =>
                          widget.loginBloc.googleSignIn.add(DoGoogleSignIn()),
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

  bool onLogin(BuildContext context, bool isLogged) {
    print("isLog $isLogged");
    if (isLogged) {
      var routeName = RouteName.home;
      Navigator.of(context).pushReplacementNamed(routeName);
    }
    return isLogged;
  }
}

class InputField extends StatelessWidget {
  final String placeholder;
  final ValueChanged<String> onTextChanged;
  final bool obscureText;

  const InputField({
    this.placeholder,
    this.onTextChanged,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: _buildInputDecoration(context, placeholder: placeholder),
      onChanged: onTextChanged,
      obscureText: obscureText,
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
}
