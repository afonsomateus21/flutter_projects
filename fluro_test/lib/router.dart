import 'package:fluro/fluro.dart';
import 'package:fluro_test/pages/home_page.dart';
import 'package:fluro_test/pages/login_page.dart';
import 'package:fluro_test/pages/not_found_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static FluroRouter router = FluroRouter();
  
  static Handler _loginHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) => LoginPage()
  );

  static Handler _homeHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      var random;
      random = 1;
      if (random != null) {
        return HomePage(
          username: params['username'][0],
        );
      } else {
        return LoginPage();
      } 
    } 
  );

  static Handler _notFoundHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) => NotFoundPage()
  );

  static void setupRouter() {
    router.define(
      '/login',
      handler: _loginHandler
    );

    router.define(
      '/home/:username',
      handler: _homeHandler
    );

    router.notFoundHandler = _notFoundHandler;
  }
}