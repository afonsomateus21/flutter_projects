import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_navigation/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({ Key key }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Routes.setupRouter();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      onGenerateRoute: Routes.router.generator,
    );
  }
}