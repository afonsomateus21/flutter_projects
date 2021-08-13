import 'package:flutter/material.dart';
import 'package:flutter_web_app/locator.dart';
import 'package:flutter_web_app/routing/route_names.dart';
import 'package:flutter_web_app/routing/router.dart';
import 'package:flutter_web_app/services/navigation_services.dart';
import 'package:flutter_web_app/view/layout_template/layout_template.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Open Sans')
      ),
      builder: (context, child) => LayoutTemplate(
        child: child,
      ),
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: HOME_ROUTE,
    );
  }
}

