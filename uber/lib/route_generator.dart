import 'package:flutter/material.dart';
import 'package:uber/screens/driver_page.dart';
import 'package:uber/screens/home_page.dart';
import 'package:uber/screens/login_page.dart';
import 'package:uber/screens/passenger_page.dart';
import 'package:uber/screens/register_page.dart';

class RouteGenerator {
  static const LOGIN_ROUTE = "/";
  static const HOME_ROUTE =  "/home";
  static const REGISTER_ROUTE = "/register";
  static const PASSENGER_ROUTE = "/passenger";
  static const DRIVER_ROUTE = "/driver";

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (_) => Login()
        );

      case LOGIN_ROUTE:
        return MaterialPageRoute(
          builder: (_) => Login()
        );

      case HOME_ROUTE:
        return MaterialPageRoute(
          builder: (_) => Home()
        );

      case REGISTER_ROUTE:
        return MaterialPageRoute(
          builder: (_) => Register()
        );

      case PASSENGER_ROUTE:
        return MaterialPageRoute(
          builder: (_) => PassengerPage()
        );

      case DRIVER_ROUTE:
        return MaterialPageRoute(
          builder: (_) => DriverPage()
        );
    }
  }
} 