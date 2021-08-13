import 'package:flutter/material.dart';
import 'package:save_user/pages/home_page.dart';
import 'package:save_user/pages/login_page.dart';
import 'package:save_user/pages/register_page.dart';

class RouteGenerator {
  static const LOGIN_PAGE = "/login";
  static const REGISTER_PAGE = "/register";
  static const HOME_PAGE = "/home";

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch(routeSettings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (_) => Login()
        );

      case REGISTER_PAGE:
        return MaterialPageRoute(
          builder: (_) => Register()
        );

      case HOME_PAGE:
        return MaterialPageRoute(
          builder: (_) => Home()
        );

      case LOGIN_PAGE:
        return MaterialPageRoute(
          builder: (_) => Login()
        );
    }
  }
}