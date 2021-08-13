import 'package:flutter/material.dart';
import 'package:flutter_web_tests/settings/configure_nonweb.dart' if (dart.library.html) 'package:flutter_web_tests/settings/configure_web.dart';
import 'package:flutter_web_tests/locator.dart';
import 'package:flutter_web_tests/router_generator.dart';
import 'package:flutter_web_tests/services/navigation_service.dart';
import 'package:flutter_web_tests/pages/home_page.dart';

void main() {
  setupLocator();
  configureApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Web',
      home: HomePage(),
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: HOME_ROUTE,
    );
  }
}

