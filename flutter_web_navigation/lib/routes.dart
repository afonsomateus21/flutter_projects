import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_web_navigation/pages/landing_page.dart';
import 'package:flutter_web_navigation/pages/splash_screen.dart';

class Routes {
  static final FluroRouter router = FluroRouter();

  static Handler _splashHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) => 
      SplashScreen()
  );

  static Handler _mainHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) => 
      LandingPage(page: params['name'][0])
  );

  static Handler _mainHandlerTwoParams = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) => 
      LandingPage(page: params['name'][0], extra: params['name'][0],)
  );

  static void setupRouter() {
    router.define(
      "/", 
      handler: _splashHandler
    );

    router.define(
      "/main/:name", 
      handler: _mainHandler,
      transitionType: TransitionType.fadeIn
    );

    router.define(
      "/main/:name/:extra", 
      handler: _mainHandlerTwoParams,
      transitionType: TransitionType.fadeIn
    );
  }
}