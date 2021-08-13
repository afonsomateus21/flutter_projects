import 'package:flutter/material.dart';
import 'package:whatsapp/Home.dart';
import 'package:whatsapp/Login.dart';
import 'package:whatsapp/Messages.dart';
import 'package:whatsapp/Register.dart';
import 'package:whatsapp/Settings.dart';

class RouteGenerator {
  static const HOME_ROUTE = "/home";
  static const LOGIN_ROUTE = "/login";
  static const REGISTER_ROUTE = "/login";
  static const SETTINGS_ROUTE = "/settings";
  static const MESSAGES_ROUTE = "/messages";

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final arguments = routeSettings.arguments;

    switch(routeSettings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (_) => Login()
        );

      case LOGIN_ROUTE:
        return MaterialPageRoute(
          builder: (_) => Login()
        );

      case REGISTER_ROUTE:
        return MaterialPageRoute(
          builder: (_) => Register()
        );

      case HOME_ROUTE:
        return MaterialPageRoute(
          builder: (_) => Home()
        );

      case SETTINGS_ROUTE:
        return MaterialPageRoute(
          builder: (_) => Settings()
        );

      case MESSAGES_ROUTE:
        return MaterialPageRoute(
          builder: (_) => Messages(arguments)
        );

      default:
        _routeError();
    }
  }

  static Route<dynamic> _routeError() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text("Tela não encontrada."),
        ),
        body: Center(
          child: Text("Tela não encontrada."),
        )
      )
    );
  }
}