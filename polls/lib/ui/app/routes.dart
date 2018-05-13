// Copyright (c) 2018 Diogo Nunes
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

import 'package:polls/ui/pages/splash_page.dart';
import 'package:polls/ui/pages/home_page.dart';
import 'package:polls/ui/pages/login_page.dart';

class RouteName {
  static var login = "/login";
  static var splash = "/";
  static var home = "/home";
}

class Routes {
  static get routes => ({
        RouteName.splash: (context) => SplashPage(),
        RouteName.login: (context) => LoginPage(),
        RouteName.home: (context) => HomePage(),
      });
}
